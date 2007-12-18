From: Pascal Obry <pascal@obry.net>
Subject: Re: Question about git-svn import
Date: Tue, 18 Dec 2007 08:10:02 +0100
Organization: Home - http://www.obry.net
Message-ID: <4767724A.9040207@obry.net>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 08:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Wb5-0007Bg-DH
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 08:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765598AbXLRHKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 02:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765277AbXLRHKI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 02:10:08 -0500
Received: from smtp2f.orange.fr ([80.12.242.150]:11305 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbXLRHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 02:10:06 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f01.orange.fr (SMTP Server) with ESMTP id EA7517000093
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 08:10:03 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2f01.orange.fr (SMTP Server) with ESMTP id A89BC7000087;
	Tue, 18 Dec 2007 08:10:03 +0100 (CET)
X-ME-UUID: 20071218071003690.A89BC7000087@mwinf2f01.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071218034836.GA27080@dervierte>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68703>

Steven Walter a =E9crit :
> Not sure if this is the best way, but I would recommend cloning into =
two
> repositories, then combining them. =20

I feared that :)

> So you already have the newer
> changes with the standard layout.  You would now:
>=20
>     $ git svn init <repo>
>=20
> And only fetch the revisions before the layout change.  You could the=
n
> combine the two repositories using .git/info/grafts and
> git-rewrite-branch.

Hum, looks like something not easy to do (at least for a Git beginner
like me) ! Any documentation on this ? Would you mind showing this on
the example script I sent ?

Thanks,
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
