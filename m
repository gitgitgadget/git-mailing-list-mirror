From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] doc: documentation update for the branch track changes
Date: Tue, 19 Feb 2008 17:09:38 -0500
Message-ID: <76718490802191409w4ca693dcr6a0c1006645ad907@mail.gmail.com>
References: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
	 <1203438278-73786-2-git-send-email-jaysoffian@gmail.com>
	 <7vfxvoiqb5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRafX-0003e2-Ef
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbYBSWJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755521AbYBSWJl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:09:41 -0500
Received: from qb-out-0506.google.com ([72.14.204.235]:36035 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYBSWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:09:40 -0500
Received: by qb-out-0506.google.com with SMTP id e11so2255906qbe.15
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eTajbD34zVukRaILEtVqAd4M1S9pI/i3SvfyGfYU+iM=;
        b=Rx1FrkVsnbKeASse528uDXDXgp970Bbk+yTYcSUU1xUNDarJN5dmwnz4e39091LWl/btetXWXJTxDw2WqrVjhmtGWOG5I3NWDcn6yMAtPJYrHWAbbGiNEOKJZ016fxU0KK94esQUsznC9tljQHjBfD1smKsi8DiAryGPZJ1ncPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xhiqmz3qJ+1cqDJrOv73+zxOsIyfUleHhQA+O7/UOmeNAWyHls4lZMjUaT1g08yk8Gq5Ddv2HI8TjHUnp93O/qiksBA3CzN+/wjK9ihcvR/xeeQ7cZqywudLiQoCVGRnPTPKEaLoJfLZGkAL3lWjonn9mAJHilaG6DXmKlA/Slg=
Received: by 10.114.123.1 with SMTP id v1mr4106938wac.147.1203458978780;
        Tue, 19 Feb 2008 14:09:38 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Tue, 19 Feb 2008 14:09:38 -0800 (PST)
In-Reply-To: <7vfxvoiqb5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74466>

On Feb 19, 2008 4:34 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Micronit; I think this ", or" should be ", and".

Probably, I just kept the existing wording. Should you go over all the current
docs with the same fine-toothed comb you're applying here, you'd end up in a
hole from which you might never emerge. :-)

> Micronit; we would want to create track-options.txt and then
> include::track-options.txt[] from here and in git-branch.txt
> (that can be done later).

Yes, lots of opportunity for refactoring the documentation. Was trying to keep
the change small.

> Otherwise, the patch looks fine, and I'll queue this as-is,
> together with your [1/2] (with the "oops, commit message is
> stale" amended in).  We can incrementally improve on these
> in-tree from here on.
>
> I am very tempted to squish the "s/,or /, and/" change in while
> applying [2/2], though.

Thanks, either way.

> By the way, please do not get discouraged to send-in the doc
> clean-ups.  I "gave up (for now)" last night because it was
> getting late, I had other patches to review and accept/respond,
> and I felt I did not have time to comment on a patch that mixes
> clean-ups and feature enhancements at that point.

Fair enough, it was the "now this is getting tiresome" that raised my hackles.
but no worries, I think I may be getting the hang of this...

> It is a good idea to organize a series so that clean-ups to
> existing stuff that you are going to touch come first, and then
> your own enhancements come on top, for a few reasons:
>
>  [...]

Understood and appreciated. I think I didn't realize the cleanup was needed
till after I sent in the patches and realized, hey, I guess I need to add some
documentation too... I know better for next time.

Thanks again for all your help on this.

j.
