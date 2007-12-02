From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Sun, 02 Dec 2007 09:54:39 +0100
Organization: Home - http://www.obry.net
Message-ID: <475272CF.40602@obry.net>
References: <20071202060740.269e54ad.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 20:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyuaJ-0001LR-Cg
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXLBTeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 14:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXLBTeO
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:34:14 -0500
Received: from smtp20.orange.fr ([193.252.22.31]:45392 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbXLBTeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:34:13 -0500
Received: from smtp20.orange.fr (mwinf2014 [172.22.130.42])
	by mwinf2020.orange.fr (SMTP Server) with ESMTP id 61D041D01330
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 09:55:25 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2014.orange.fr (SMTP Server) with ESMTP id 4C4901C000A3
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 09:54:43 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-46-33.w82-124.abo.wanadoo.fr [82.124.248.33])
	by mwinf2014.orange.fr (SMTP Server) with ESMTP id AECED1C000A4;
	Sun,  2 Dec 2007 09:54:42 +0100 (CET)
X-ME-UUID: 20071202085442716.AECED1C000A4@mwinf2014.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071202060740.269e54ad.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66812>

Christian Couder a =E9crit :
> "git help --info XXX" will now call "info git-XXX".

If would be nice if this could be more generic. For example I'd like to
use Emacs woman mode instead of info. Can't we have something like

   $ git help --ext XXX

"ext" standing for external and calling whatever command recorded into
=2Egitconfig for example ?

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
