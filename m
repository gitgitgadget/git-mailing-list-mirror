From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Tidy up some rev-list-related stuff
Date: Thu, 9 Jun 2005 19:57:45 +1000
Message-ID: <2cfc403205060902571b99af3f@mail.gmail.com>
References: <20050608205943.GO982@pasky.ji.cz>
	 <2cfc4032050608180650e5ef12@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 09 17:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgOj4-0002Dy-FC
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 17:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVFIPRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 11:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVFIPRu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 11:17:50 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:16408 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261896AbVFIPRk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 11:17:40 -0400
Received: by rproxy.gmail.com with SMTP id i8so205729rne
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 08:17:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xzt0PXt/ZB0Nnl6Y4/qHBE4jmm8QtIFOH/STahvNGUibo6HPloa76VqqtQzbFc80f1jKFyoTTaQCejn4uWVTXgug0/8zxz+o7BmRsv94/MixrgQ/N6pxooM4qxzmLJU+mmbu4MP6elCz5cniYNQJkXzwAMY8XytoubWVIz1Zw2E=
Received: by 10.38.11.38 with SMTP id 38mr183632rnk;
        Thu, 09 Jun 2005 02:57:46 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 9 Jun 2005 02:57:45 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc4032050608180650e5ef12@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Speaking of which, I can't emacs to indent properly even when I use
> this suggestion from that document:
> 
>     (defun linux-c-mode ()
>       "C mode with adjusted defaults for use with the Linux kernel."
>       (interactive)
>       (c-mode)
>       (c-set-style "K&R")
>       (setq tab-width 8)
>       (setq indent-tabs-mode t)
>       (setq c-basic-offset 8))
> 
>     This will define the M-x linux-c-mode command.  When hacking on a
>     module, if you put the string -*- linux-c -*- somewhere on the first
>     two lines, this mode will be automatically invoked. Also, you may want
>     to add
> 
>     (setq auto-mode-alist (cons '("/home/jon/.*/.*\\.[ch]$" . linux-c-mode)
>                             auto-mode-alist))
> 

Actually, these instructions do work for me. An earlier version of the
instructions I pulled from a google hit didn't work.

jon.
