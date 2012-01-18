From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Using signed tag in pull requests
Date: Wed, 18 Jan 2012 12:07:18 +1100
Message-ID: <CAH5451nSMcJ50fu2qtMkw4zPpx-Kg-k-jqCcpryu+pkC8JX8rw@mail.gmail.com>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 02:08:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnK0P-0003nn-MM
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 02:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab2ARBHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 20:07:42 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53287 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754212Ab2ARBHk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 20:07:40 -0500
Received: by lahc1 with SMTP id c1so1887105lah.19
        for <multiple recipients>; Tue, 17 Jan 2012 17:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jbr3EptnLVLpV3ht+4YDsH8Mt/37z7Be+iF0+50SI+s=;
        b=mj+chtORj/Ek8QsrxMVlUTFIAoaTHl4yaNbAQB/vjP4qgf49+9xkgXLcZMcey11mlQ
         QwrfQjOzqSIFdxgR7t8qJ3EHX/NsJCDEwQiByHP1YpAKhrsYwD/7XBw/qL0T8VX+hpXK
         PSX2/j2BvMzb2NllE9Jm/mgii1LiB22qW5s/s=
Received: by 10.152.113.2 with SMTP id iu2mr9476784lab.26.1326848859281; Tue,
 17 Jan 2012 17:07:39 -0800 (PST)
Received: by 10.152.14.71 with HTTP; Tue, 17 Jan 2012 17:07:18 -0800 (PST)
In-Reply-To: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188731>

Looks pretty good Junio, though one of the lines was a bit confusing:

On 18 January 2012 09:53, Junio C Hamano <gitster@pobox.com> wrote:

> Starting from Git release v1.7.9, a contributor can add a signed tag to
> the commit at the tip of the history and ask the integrator to pull that
> signed tag. When the integrator runs `git pull`, the signed tag is
> automatically verified to assure that the history is not tampered with.
> In addition, the resulting merge commit records the content of the signed
> tag, so that other people can verify that the branch merged by the
> contributor was signed by the contributor, without fetching the signed tag

I think you mean to say 'the branch merged by the integrator was signed
by the contributor'. If you are talking about two separate contributors, or
the same contributor merging one of her own branches, the wording can
likely be improved.

> used to validate the pull request separately and keeping it in the refs
> namespace.

Overall it was easy to understand and makes the whole workflow quite clear.

Regards,
Andrew Ardill
