From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Teach diff machinery to display other prefixes than "a/"
 and "b/"
Date: Tue, 18 Dec 2007 17:45:41 +0100
Organization: Home - http://www.obry.net
Message-ID: <4767F935.8060207@obry.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <Pine.LNX.4.64.0712181619550.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:46:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fa8-0002jQ-Ei
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758921AbXLRQpr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758568AbXLRQpr
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:45:47 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:22634 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758474AbXLRQpq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 11:45:46 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1911.orange.fr (SMTP Server) with ESMTP id 7FF3B1C000BE
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 17:45:44 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf1911.orange.fr (SMTP Server) with ESMTP id 347FE1C0008E;
	Tue, 18 Dec 2007 17:45:44 +0100 (CET)
X-ME-UUID: 20071218164544215.347FE1C0008E@mwinf1911.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712181619550.23902@racer.site>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68777>

Johannes Schindelin a =E9crit :
> With the new option "--prefix=3D<prefix1>[:<prefix2>]" you can change
> the shown prefix, or suppress it (by specifying the empty string).

Why not ? But do you have a motivation for this change ? I mean why
would you want to use a completely different prefix ?

My change was only for format-patch as this is used to build patch that
some other tools can process. If we find a sensible usage for your
prefix option I'm all for it as this solves also my problem. It is just
that I think all options must have at least one usage :)

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
