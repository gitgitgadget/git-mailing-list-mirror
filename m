From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 12:22:12 +0100
Message-ID: <cda58cb80511140322v686e4ee0g@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:24:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbcPh-0005uK-6r
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 12:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVKNLWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 06:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKNLWN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 06:22:13 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:21722 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751081AbVKNLWN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 06:22:13 -0500
Received: by zproxy.gmail.com with SMTP id 14so1239579nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 03:22:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3OB4QQOGQzZ313V8KT2UXxgd+o2VeNx+Hhy9MbG1ly8drgiMVNuSuXM5kfUpCtTbOpuciYgWoxGyQBk0+FUiDgDdX0thdpHu6lXa5NXyEbVQwD9qukj1KdWMBd0F1BNT4eHqmI6drCJYIyGAGQcWAgRHBSOhEt8f4CFpnkWv6Q=
Received: by 10.36.100.4 with SMTP id x4mr1612886nzb;
        Mon, 14 Nov 2005 03:22:12 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 03:22:12 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <437870AF.8060607@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11789>

Hi Andrea

2005/11/14, Andreas Ericsson <ae@op5.se>:
> Franck wrote:
> > Hi,
> >
> > I'm trying to use gitk --all command but it fails like this:
> >
> > """
> > Error executing git-rev-list: couldn't execute "git-rev-list": no such
> > file or directory
> > """
> >
>
> Is git-rev-list in your $PATH?

yes:
            # git-rev-list HEAD
            3f1d5f26509defe2f691f5e94a2848848d1ba3a0
            cd9a0ae21e015cc25a0ea98169451a59d49c0909
            538310ad38629a1c1f983d982e52b568bc1dbe79

> Did you compile (and/or install) with
>
>         make NO_OPENSSL=YesPlease
>         make NO_OPENSSL=YesPlease install
>

nope I just did: "make; make install". I tried what you suggested but
it's still failing the same way...

> Do other git commands work?
>

yes, at least some other commands like git-diff-xxx, git-checkout....

> > I'm running git on a fedora core 3. Can anybody give me some help ?
> >
>
> Trying to, but a bit more verbosity in the error report wouldn't hurt.
>

I'm usig git v0.99.9h

Thanks
--
               Franck
