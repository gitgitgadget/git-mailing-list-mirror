From: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Date: Sun, 07 Jan 2007 22:07:44 +0100
Message-ID: <1168204064.3806.40.camel@bip.parateam.prv>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
	 <20070107182151.7cc544f3@localhost.localdomain>
	 <20070107191730.GD21133@flint.arm.linux.org.uk>
	 <20070107200553.GA15101@redhat.com>
	 <20070107151514.be9430b1.seanlkml@sympatico.ca>
	 <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, Dave Jones <davej@redhat.com>,
	Alan <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965166AbXAGVEh@vger.kernel.org Sun Jan 07 22:05:58 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965166AbXAGVEh@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3fCn-0000Zc-Lz
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 22:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbXAGVEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbXAGVEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:04:37 -0500
Received: from smtp23.orange.fr ([193.252.22.30]:42452 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965166AbXAGVEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:04:36 -0500
Received: from smtp23.orange.fr (mwinf2346 [10.232.4.146])
	by mwinf2335.orange.fr (SMTP Server) with ESMTP id 395B21C3F510;
	Sun,  7 Jan 2007 22:04:35 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2346.orange.fr (SMTP Server) with ESMTP id DF79B1C00099;
	Sun,  7 Jan 2007 22:04:12 +0100 (CET)
Received: from awak.dyndns.org (AGrenoble-152-1-91-27.w86-200.abo.wanadoo.fr [86.200.74.27])
	by mwinf2346.orange.fr (SMTP Server) with ESMTP id C95121C00097;
	Sun,  7 Jan 2007 22:04:12 +0100 (CET)
X-ME-UUID: 20070107210412824.C95121C00097@mwinf2346.orange.fr
Received: from localhost ([127.0.0.1] helo=[192.168.0.166])
	by awak.dyndns.org with asmtp (Exim 3.36 #1 (Debian))
	id 1H3f8v-0008Nd-00; Sun, 07 Jan 2007 22:01:25 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
X-Mailer: Evolution 2.8.1.1 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36197>

Le dimanche 07 janvier 2007 =E0 21:40 +0100, Jan Engelhardt a =E9crit :
> >On Sun, 7 Jan 2007 15:05:53 -0500
> >Dave Jones <davej@redhat.com> wrote:
> >
> >> If there's something I should be doing when I commit that I'm not,
> >> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-=
8
> >> which should DTRT to the best of my knowledge, but clearly, that i=
sn't
> >> the case.
>=20
> No, LC_CTYPE defines what charset you use. (I may be wrong, though.)

IIRC LANG is a superset for all LC_* - i.e. if only LANG is defined, it
sets all your locales, but you can individually set the charset, numeri=
c
format, date format, etc.

	Xav
