From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: Is it possible for git to remember the options preference for "git log"?
Date: Mon, 12 Nov 2007 10:21:10 +0800
Message-ID: <f17812d70711111821v2e14cf6bsd65a192114872056@mail.gmail.com>
References: <f17812d70711111633u6c00d182u532fef1c16c3c94a@mail.gmail.com>
	 <Pine.LNX.4.64.0711111954520.29952@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 03:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrOvZ-0004L3-1f
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 03:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbXKLCVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbXKLCVM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 21:21:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:8261 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbXKLCVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 21:21:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1372341wah
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 18:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KCU2Zw01P4C0if3y2IKj4X8Nb61PpQgnj+i20W9R9IU=;
        b=fSiEvVZ14aYj30Nb9v+BneD3yrsvjctf27bh/J0ZZX2rALHpNguBP/MvBwYsvzi4Vj2j8fImUxkacBQTvHVYRLwpjVCN+pMStzWSvANdTr9L9S6AGZNAXLm5xmy1ZzlmncyhED2z1epjiuphfYEuoRoQj1v7YHFbWAFDPEuegS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UGFyRF6Q9pNlPg/IJwqUvpu9ygKkqSNRH2zpFjBnNjDsSco7VA3T2Vjwux/Wl+8G9fO9pOivW5LPquOpYxYHgJgQRTSIAADfyh6d37zfQbjcvjzgbLyd9v7Gc0irZyrFHCQIj687c6rMoeOtUb6It7vfWVvos/TmYQWOzPUIybw=
Received: by 10.115.94.1 with SMTP id w1mr2030272wal.1194834071034;
        Sun, 11 Nov 2007 18:21:11 -0800 (PST)
Received: by 10.114.147.6 with HTTP; Sun, 11 Nov 2007 18:21:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711111954520.29952@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64550>

On Nov 12, 2007 9:02 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> On Mon, 12 Nov 2007, eric miao wrote:
>
> > All,
> >
> > Most of the time I'm using git-log for inspecting a brief history
> > and insert/remove/modify commits between, which I have to
> > type "git log --abbrev-commit --pretty=oneline" every time. Is
> > it possible for git to remember this command line options
> > preference?
> >
> > And no, I don't really want to use shell's alias or something
> > else, I was just used to type "git xxx" :-)
>
> Git has a built-in alias mechanism, which is probably what you want. If
> you put in your config file:
>
> [alias]
>         xxx = log --abbrev-commit --pretty=online
>

Thanks, this is exactly what I want.

> then you can type "git xxx" and it'll do what you want. Changing the
> default behavior of the basic commands is looked down on because there are
> scripts that use them to get their input, and those scripts have
> particular formats they expect.
>

Ye, agree, I don't think that's a good idea either.

>         -Daniel
> *This .sig left intentionally blank*
>



-- 
Cheers
- eric
