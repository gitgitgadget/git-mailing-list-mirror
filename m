From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 19:19:50 +0700
Message-ID: <fcaeb9bf0711300419i9cf70eo9f96e3a5e3f44585@mail.gmail.com>
References: <20071127150229.GA14859@laptop>
	 <Pine.LNX.4.64.0711271617350.27959@racer.site>
	 <20071128000731.GD9174@efreet.light.src>
	 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
	 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
	 <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
	 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Eyvind Bernhardsen" <eyvind-git-list@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri Nov 30 13:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4qq-00068X-Lz
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXK3MTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXK3MTw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:19:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:51608 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbXK3MTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 07:19:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2228831nfb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=reYhfGiXGZX9ODdSGWF2uJYM8GgWM0HA6FQK5r8WBTI=;
        b=cAr8SQSzfw68Z6ugMNXe2biSyMT7etalhQ029AmXj0oJlFSpDBxzUFv40LUWywqfEFdzN8lZfa4PrOfVnCh+xLuEqJ8NOnRZF0aViCPiNrpwCL7ikWduDl+28yk4g1ipU0KfeT0W04zZdhkT1Ha+75A+kYJEiVjyrNIS1lGjuxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BpEG7TxqWgzzlnpgG5yB+ctetx5oR1V+YYvWKjc4gY9ZhY7bAfJfjPYcNXKQH3CODK1wINHGcAf0/lyzMtgTJw72oqsLrVdZC5j6pAq1Q3Z9iWsDUbB8J1jc41WjQacvGFit0FnAnGzPJrC1755INePcATRugUidX8vn4zqL7hE=
Received: by 10.86.89.4 with SMTP id m4mr7205325fgb.1196425190190;
        Fri, 30 Nov 2007 04:19:50 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Fri, 30 Nov 2007 04:19:50 -0800 (PST)
In-Reply-To: <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66638>

On Nov 30, 2007 6:28 PM, Eyvind Bernhardsen
<eyvind-git-list@orakel.ntnu.no> wrote:
> On 29. nov. 2007, at 23.36, Junio C Hamano wrote:
>
> [...]
>
> > If people are really serious about reducing the number of commands in
> > the path, I would expect fixes and bugreports saying "I am setting
> > gitexecdir different from bindir in _my_ installation when I build
> > git,
> > and here are the things that does not work if I do so".  Within the
> > span
> > of more than 20 months (77cb17e9 introduced gitexecdir in Jan 2006), I
> > do not think there was a single such report or patch, other than the
> > message from Nguyen that started this thread.
>
> I'm setting gitexecdir different from bindir in my installation, and
> here are the things that don't work:
>
> - When pushing to my system over ssh, git-receive-pack and git-upload-
> pack are expected to be in $PATH.  I resolved the problem by putting
> symlinks in /usr/local/bin.
>
> I haven't seen any other problems, but then again, I only use git
> plumbing commands and my own scripts.

You remind me my experience of making every external C-based command
builtin. There is another case: git-merge. It calls  something like
git-merge-$strategy.

-- 
Duy
