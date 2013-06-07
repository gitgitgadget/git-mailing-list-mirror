From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 00:18:18 +0530
Message-ID: <CALkWK0=mthyNQz9o6vG0b_yEMVL3GsB-dppNt6xgWTdUQQ5Zqw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
 <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
 <vpqhah9248u.fsf@anie.imag.fr> <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
 <vpqip1pzs9d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:49:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1ih-00050x-4W
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab3FGSs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:48:59 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:61957 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab3FGSs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:48:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so2992185ieb.10
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4bOd8hCFLCY7M7bimpJyCXV0o4EitTTEdHZoKIUiwPg=;
        b=vXwtOBVUhMB3TUmsChc9MCDEZx6Frc9LDCQeLWxt9mvbZPO0i6yyWVY9ow0HIjoBeo
         0K+m5zcfF4mjx/4T3GLz/NEJSgk06kjozyHJ3lvVl8YN64ONU0gn9V1PjahChdl7coha
         OsNrc2+sG9mf4P0IynN22qxLt7zirB9K9h/kn7rj7K8YQGMGdPsluKSomBOhAsO6i62y
         MM3MlXPeAZRvyAsnFdNE9vlVJMK5uuxV41L0vcunlXhDtmC9ySz/Qb3Yg867/yLmRFQI
         e+eDzoOWLZQkUFiPGAdvYMH3C9cznFMbsnu1FRkzG6FUip3J5vGLUWNwZitsmQ8GvOxX
         j/dw==
X-Received: by 10.50.171.161 with SMTP id av1mr2028690igc.104.1370630938230;
 Fri, 07 Jun 2013 11:48:58 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 11:48:18 -0700 (PDT)
In-Reply-To: <vpqip1pzs9d.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226668>

Matthieu Moy wrote:
> Visual Studio now has official Git support from MS (based on libgit2 if
> I understood correctly). That's cool, but not a reason to kill msysgit
> IMHO ;-).

Oh, I'm not interested in killing anything.  If people want msysgit,
they will work on it: I'm nobody to say otherwise.  I was just curious
to know why msysgit is suffering from a lack of attention: fewer
users?

> Whether it's based on POSIX is an implementation detail for the user.
> The real question is more command-line Vs GUI than POSIX/Win32. Some
> Linux users like GUI, some windows users use command-line. I tried IDE
> integration with EGIT, and quite frankly I ended-up doing all the Git
> stuff in a terminal next to Eclipse.

I see.  But isn't it possible to implement a CLI in libgit2 too, no?
