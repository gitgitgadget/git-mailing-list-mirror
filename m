From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 08:32:57 +0100
Message-ID: <BE2DD4F6-2F40-47DD-ADBF-E549EAF634C2@wincent.com>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com> <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 08:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy0Om-0002uV-14
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 08:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050AbXK3Heg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 02:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756652AbXK3Hef
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 02:34:35 -0500
Received: from wincent.com ([72.3.236.74]:50584 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873AbXK3Hef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 02:34:35 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAU7Ww8j026737;
	Fri, 30 Nov 2007 01:32:59 -0600
In-Reply-To: <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66622>

El 29/11/2007, a las 23:36, Junio C Hamano escribi=F3:

> If people are really serious about reducing the number of commands in
> the path, I would expect fixes and bugreports saying "I am setting
> gitexecdir different from bindir in _my_ installation when I build =20
> git,
> and here are the things that does not work if I do so".  Within the =20
> span
> of more than 20 months (77cb17e9 introduced gitexecdir in Jan 2006), =
I
> do not think there was a single such report or patch, other than the
> message from Nguyen that started this thread.

One reason why there have been no reports is probably because 99% of =20
people have never heard of gitexecdir nor know what it does.

$ git grep gitexecdir | awk -F : '{print $1}' | uniq
Makefile
config.mak.in
git-gui/Makefile
git-gui/macosx/AppMain.tcl
git.c

Try googling for "site:git.or.cz gitexecdir"

Basically, seems the only way you could know about it is if you've =20
heard it mentioned on this mailing list and decided to study the =20
Makefile.

Cheers,
Wincent
