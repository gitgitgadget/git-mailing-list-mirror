From: John Szakmeister <john@szakmeister.net>
Subject: Re: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Sat, 4 May 2013 09:17:13 -0400
Message-ID: <CAEBDL5W6J60KhAjnWyCkMbR_tu2kftqp_w0rc0RsUr2-rDNgUQ@mail.gmail.com>
References: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
	<5184B9F9.2010708@kdbg.org>
	<CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 15:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYcLD-0004Ov-6L
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 15:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461Ab3EDNRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 09:17:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59665 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab3EDNRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 09:17:14 -0400
Received: by mail-we0-f174.google.com with SMTP id z2so1940675wey.19
        for <git@vger.kernel.org>; Sat, 04 May 2013 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Nt6jVNhJQNDqra5S2o/8FuYe4FVcfCGAKwSrfiaCxs8=;
        b=NJrGavNbp8nFSgqerVOhQieieFWbCTYcImsrtjrgom90fRO05bJw4cCviWX4+O4e3k
         EKJTSzoS5FjOv1maDZHwG3JkeN8TWkwwmJo9105Eh6gXWQo7LNlcs232N3zCyMC6EGox
         fiqOMLuOTIHKXanQvofqFNBJHg745pYU/N0//JVmVa+dlUEOwd3+91r7Gk3vMKzUvUiP
         QAOk5lMTRUswbH70W9A+OijDHJ1omBg5/DEbZVM0JhftcUJfHLiHlS1+nflC3Ml8FiTe
         E2Fb9GsP48KXYzV7ho0+o0gIyQsjWPZmFQIJ1PeKCbXG7MiUL7ND2CKDj5N6O1ynJ30I
         0zgQ==
X-Received: by 10.194.78.204 with SMTP id d12mr18166004wjx.42.1367673433352;
 Sat, 04 May 2013 06:17:13 -0700 (PDT)
Received: by 10.180.78.69 with HTTP; Sat, 4 May 2013 06:17:13 -0700 (PDT)
In-Reply-To: <CACPiFCK=8KFX++Bg+LhymorSMnWgrj5Js+-f=UYyZnNY=n9WiA@mail.gmail.com>
X-Google-Sender-Auth: o15xLt5EwLE960yIhzIWE848z1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223367>

On Sat, May 4, 2013 at 7:35 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
[snip]
> When I do git pull, git is careful to only update the branch I have
> checked out (if appropriate). It leaves any other branches that track
> branches on the remote that has just been fetched untouched. I always
> thought that at some point git pull would learn to evaluate those
> branches and auto-merge them if the merge is a ff.
>
> I would find that a natural bit of automation in git pull. Of course
> it would mean a change of semantics, existing scripts could be
> affected.

I agree.  I've been using this script for quite a while now:

<https://github.com/jszakmeister/etc/blob/master/git-addons/git-ffwd>

I've been pretty happy with it.  It's not of my own design, I picked
up from StackOverflow:

<http://stackoverflow.com/a/9076361/683080>

And made a couple of minor tweaks to cope with my configuration (I
have merge setup to not fast-forward merge by default).

-John
