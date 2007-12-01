From: Pascal Obry <pascal@obry.net>
Subject: Re: how to create v2 patch
Date: Sat, 01 Dec 2007 14:17:39 +0100
Organization: Home - http://www.obry.net
Message-ID: <47515EF3.8010507@obry.net>
References: <47515693.9070405@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
X-From: git-owner@vger.kernel.org Sat Dec 01 14:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IySEP-0007RQ-Kf
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 14:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbXLANRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 08:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXLANRp
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 08:17:45 -0500
Received: from smtp25.orange.fr ([193.252.22.23]:53656 "EHLO smtp25.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbXLANRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 08:17:45 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2514.orange.fr (SMTP Server) with ESMTP id 71DEE1C00096
	for <git@vger.kernel.org>; Sat,  1 Dec 2007 14:17:42 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-46-33.w82-124.abo.wanadoo.fr [82.124.248.33])
	by mwinf2514.orange.fr (SMTP Server) with ESMTP id 270871C00088;
	Sat,  1 Dec 2007 14:17:42 +0100 (CET)
X-ME-UUID: 20071201131742160.270871C00088@mwinf2514.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <47515693.9070405@imap.cc>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66714>

Tilman Schmidt a =E9crit :
> Let's say that following the scheme laid out in
> http://www.kernel.org/pub/software/scm/git/docs/everyday.html#Individ=
ual%20Developer%20(Participant)
> I have produced a patch, submitted it to LKML, received a few
> comments, committed appropriate changes to my local git tree,
> and now want to submit a revised patch. How do I do that?
> If I just run git-format-patch again, it produces my original
> patch plus a second one containing my updates, but what I need
> is a single new patch replacing the first one.

Can't you merge both of your changes in your local repository? I would
do that with an interactive rebase.

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
