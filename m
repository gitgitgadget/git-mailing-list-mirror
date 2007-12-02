From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sun, 02 Dec 2007 17:56:48 +0100
Organization: Home - http://www.obry.net
Message-ID: <4752E3D0.6030802@obry.net>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.99999.0711292004340.9605@xanadu.home> <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se> <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org> <20071130212500.GB25946@coredump.intra.peff.net> <Pine.LNX.4.64.0711302306580.27959@racer.site> <FFEBE8BB-E764-4DD0-A7DC-8CC01659D9BC@wincent.com> <Pine.LNX.4.64.0712021637250.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:57:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iys88-0004tJ-HS
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbXLBQ45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 11:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755508AbXLBQ45
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:56:57 -0500
Received: from smtp2f.orange.fr ([80.12.242.151]:23598 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755393AbXLBQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:56:56 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f13.orange.fr (SMTP Server) with ESMTP id F007E700009E
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 17:56:53 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-88-105.w86-205.abo.wanadoo.fr [86.205.126.105])
	by mwinf2f13.orange.fr (SMTP Server) with ESMTP id 289587000098;
	Sun,  2 Dec 2007 17:56:53 +0100 (CET)
X-ME-UUID: 20071202165653166.289587000098@mwinf2f13.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712021637250.27959@racer.site>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66794>

Johannes Schindelin a =E9crit :
> Okay, how many executables are there in your /usr/bin/?  Here there a=
re=20
> 2973.
> Guess what.  I am not intimidated by that number.

Good, and look in /usr/bin, all those 2973 binary are all disconnected.

Here we are speaking about a tool as a whole : Git.

And I agree that hiding some of them will probably help new comers. We
can also argue that a new comers should read some documentation :)

After all I'm not sure what's the right move !

At least let me say something constructive :) I'm a new comer to Git.
I've read many documentations before grabbing the system and I've not
been impressed by the number of binaries in /usr/bin... Because I've
almost never looked there. Most of the time I'm using "git <tab>" and
the bash completion feature is just right for me.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
