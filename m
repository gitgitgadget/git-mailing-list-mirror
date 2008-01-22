From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 11:00:34 -0500
Message-ID: <30e4a070801220800l6f38bbe5wc6b1ceeac7efbf06@mail.gmail.com>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
	 <alpine.LSU.1.00.0801221255530.5731@racer.site>
	 <m3k5m2klmh.fsf@roke.D-201>
	 <30e4a070801220635q4978fd2fvc469ca00af4e11cc@mail.gmail.com>
	 <4F8D70B2-B264-46FF-BFBB-01AEF42DD888@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ab_lists@mac.com
X-From: git-owner@vger.kernel.org Tue Jan 22 17:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHLZ0-00018W-QG
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 17:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbYAVQAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 11:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756293AbYAVQAj
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 11:00:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:38570 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYAVQAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 11:00:38 -0500
Received: by wr-out-0506.google.com with SMTP id c49so876195wra.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YS4w8xR0/f6qgpAzU1yfXTR5FUKZsg0lou/Rm4I5/RY=;
        b=TToJ0EoOi9kjqxraRnuK/VH8s8DiHJdMzKYmTv7+Pm2lMNJT53J976EQPzFSaTDeMVdc8bnrnf9ZNjcdCAn9M/ML/6poAOWQCnparaj/lfw2cR0JRYEChnYofbsYYTes+XznjpZ4ZGaiH1B2gEVrbIUwphX3vvN8GWTcm692fO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rRlr3y+KkwhLiUfVbjf74/2syPcxBUmeOEZQapa7nvVNZYDWOy3zzWDmU5jBUsbh0R7SuFpeeFNLm0Ra0wq6rsTaxw4sWAjeavQMPDofHiDS8fFNSPqT7KNQfwUPD6bawhC3lX2GmOTO35jDa6tksKo0rgfc6iZrc4B5SJ00FzI=
Received: by 10.142.48.14 with SMTP id v14mr4129101wfv.133.1201017634538;
        Tue, 22 Jan 2008 08:00:34 -0800 (PST)
Received: by 10.143.15.6 with HTTP; Tue, 22 Jan 2008 08:00:34 -0800 (PST)
In-Reply-To: <4F8D70B2-B264-46FF-BFBB-01AEF42DD888@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71458>

On Jan 22, 2008 10:05 AM,  <ab_lists@mac.com> wrote:
> Thank you all for your feedback!
>
> So would it be wise to synchronise the repositories over time using
> the bundles and despite having exchanged email patches or should they
> be used separately?
>
You can use both: patches to distribute proposed changes, bundles to
distribute the integrated (and presumably controlled) branches after
changes are accepted. Of course, you can use a bundle to distribute a
proposed change as well (as a topic branch), you have to decide for
yourselves what works best. Patches are great for distributed review
over a mailing list, but if only a couple of you and no mailing list
that advantage diminishes.

Mark
