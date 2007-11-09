From: Pascal Obry <pascal@obry.net>
Subject: Re: linux-2.6 clone with CygWin git
Date: Fri, 09 Nov 2007 18:16:17 +0100
Organization: Home - http://www.obry.net
Message-ID: <473495E1.3080305@obry.net>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net> <20071109150306.GA20531@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Medve Emilian <Emilian.Medve@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 18:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXTA-00024j-Ph
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXKIRQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbXKIRQV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:16:21 -0500
Received: from smtp21.orange.fr ([80.12.242.48]:10511 "EHLO smtp21.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbXKIRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:16:20 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2116.orange.fr (SMTP Server) with ESMTP id DBE651C0009B
	for <git@vger.kernel.org>; Fri,  9 Nov 2007 18:16:17 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-37-239.w82-120.abo.wanadoo.fr [82.120.19.239])
	by mwinf2116.orange.fr (SMTP Server) with ESMTP id A1C051C0008F;
	Fri,  9 Nov 2007 18:16:17 +0100 (CET)
X-ME-UUID: 20071109171617662.A1C051C0008F@mwinf2116.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071109150306.GA20531@old.davidb.org>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64222>

David Brown a =E9crit :
> It's because of the case-insensitive nature of the filesystem.  The k=
ernel
> contains both an xt_connmark.h and an xt_CONNMARK.h file, that are
> different.  But only one exists on Windows, so git sees the first one=
 it
> wrote as having been modified.

Probably not something for the list... but if you ask me this is just
bad practice anyway. Casing has no semantic, it is nonsense to have two
files with the same name with different casing!

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
