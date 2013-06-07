From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 11:33:25 -0700
Message-ID: <20130607183325.GC12924@google.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
 <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
 <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
 <vpqhah9248u.fsf@anie.imag.fr>
 <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?iso-8859-1?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1Ti-0007rM-R5
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3FGSdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:33:31 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60517 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FGSda (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:33:30 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so3929744pbc.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SsBl+YCwph9ubAH9OPcciF/nBe+q0Uii/UlOSJYnHuQ=;
        b=vH8aoa+JIOoOyrF1TMio+VIDZRt6+4vKwGSLEzqyYdytdrKvQWPCnyQwSM/SDbN/mR
         U+QJqWNPbVuX+cmvMjRZwNuMTmkDeJ0HbBjCYaz3aC0rFBCQ9i1yS7E8ssHKANHswu+9
         5C74rcRI9In3xYi4UXjcNN2SutXLs2Uu+JAdxPOcBPAOxK55COrhXWUm73XD+AO2p9fk
         FPfWcva+/xVX4ifIff3c4IeyztK5nLG8I7XU6ecqgFstUFr0cLqfwulgtTOxODDoiu5Q
         1xQnbFmLoOHZ3ggINfBKcQk/nm6hkeNY0I1s/OINHxLeLPwRo51GFFpYPeEDs+04XLAy
         kImg==
X-Received: by 10.68.136.230 with SMTP id qd6mr43891265pbb.112.1370630009699;
        Fri, 07 Jun 2013 11:33:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xz1sm4261018pab.5.2013.06.07.11.33.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 11:33:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226662>

Ramkumar Ramachandra wrote:

> I think he way forward on Windows is

Why is there only one way forward?  Why do you get to pick it, given
that you've said you're not interested in working on it?

[...]
>                                              I never understood why
> users on Windows want to use something as POSIX'y as git.git.

Plenty of users on Windows use a command line.  I have even been such
a user from time to time.  I'm quite grateful for Dscho et al's work
on making that less painful.

Jonathan
