From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 09:55:11 -0400
Message-ID: <fcaeb9bf0707260655v1dbbacfbta23e670713683963@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <Pine.LNX.4.64.0707251510130.14781@racer.site>
	 <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
	 <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
	 <fcaeb9bf0707260620i2ec1ab36ka470758edfd570d2@mail.gmail.com>
	 <46d6db660707260632q16f927a2r64f6b4588dd3cb48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Christian MICHON" <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE3oh-0006LR-RF
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 15:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760062AbXGZNzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 09:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759721AbXGZNzO
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 09:55:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:11455 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbXGZNzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 09:55:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so477924wxd
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 06:55:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cdEyO4tGeSKAaJfZsdSZj1TbwaqFNK23vYIQYhI26JNJ87q5WptXZE9l1+FRRPv+n/lp4XY520pP7HRV9QWeQHr99VvcnAO2zLcL9s/CDmT2xoJwjlAXPvVx6VoifXKIoWlzPOUXuGUgCeSM6jjOHolXho5jQZ4dVvYizmIz2hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/unPYA1gBEPkHARzPpvo4VzTgbh7Ma5ri64e5ykF8WUTjtQbInzXDBhndslnKl6P/zQ6FL0Amp3pV53np+IvnIIfJaZT7yq93O1TWCMZAvlcJLF1OJ9XwmoJT6q4rx2/eZHEKMgxp1Rk+hfYfgwsvUhi2lj87bstWdVHgOz1Gg=
Received: by 10.100.166.14 with SMTP id o14mr1298226ane.1185458111745;
        Thu, 26 Jul 2007 06:55:11 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 06:55:11 -0700 (PDT)
In-Reply-To: <46d6db660707260632q16f927a2r64f6b4588dd3cb48@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53830>

On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > > it seems you're not very far off. I believe you intend to replace in git-commit
> > > "#!c:/msys/bin/sh" with something like "#!c:/gitbox/bin/gitbox ash", right ?
> >
> > No. I tweaked try_shell_exec() to use gitbox shell if the interpreter is "sh".
> >
>
> interesting. have you tried inserting busybox vi inside git-box ?

Not yet. That would be fun but I rather focus on ash in the moment.
You could set EDITOR to notepad or something else.

> I can commit using "git commit -a -m ok", but then I get this kind of
> error message (and ash dies, I go back to xp/cmd prompt)
>
> mv: cannot rename '.git/next-index4540': File exists

Baah.. something goes wrong again.

> C:/gitbox/bin/git-commit: exit: line 658: Illegal number: -1
>
> nice piece of work. it could really be tiny once fixed.

Um.. that "Illegal number" might be an ash bug. Intended to fix it but
then forgot :(

>
> I suggest to replace most git-* by git-box/ash shell wrappers,
> calling the git.exe binary directly.

Cool. Will do.

> --
> Christian
> --
> http://detaolb.sourceforge.net/, a linux distribution for Qemu
>


-- 
Duy
