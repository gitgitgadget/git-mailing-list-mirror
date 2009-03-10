From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] git-instaweb: fix lighttpd configuration on cygwin
Date: Tue, 10 Mar 2009 18:34:34 +0100
Organization: Home - http://www.obry.net
Message-ID: <49B6A4AA.7050301@obry.net>
References: <49B5609B.5070705@ramsay1.demon.co.uk>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:36:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh5s8-0004nV-Rt
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 18:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbZCJReb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 13:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbZCJReb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 13:34:31 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54915 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbZCJRea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 13:34:30 -0400
Received: by fxm24 with SMTP id 24so1703427fxm.37
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 10:34:26 -0700 (PDT)
Received: by 10.103.226.10 with SMTP id d10mr3356172mur.105.1236706466539;
        Tue, 10 Mar 2009 10:34:26 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-34-1.w82-124.abo.wanadoo.fr [82.124.16.1])
        by mx.google.com with ESMTPS id t10sm2205466muh.59.2009.03.10.10.34.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Mar 2009 10:34:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.0
In-Reply-To: <49B5609B.5070705@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112833>

Ramsay Jones a =E9crit :
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>=20
> A recent email from Pascal reminded me that I had this patch
> kicking around. I haven't tested this on Linux, since I don't
> have lighttpd installed there (I already have Apache), but I
> don't expect any problems; famous last words!
>=20
> The essence of the change is the addition of the "mod_setenv"
> module, along with the PATH environment variable assignment.
> (otherwise gitweb can't find a shell and, therefore, can't
> execute any git programs)
>=20
> Also, I had to add a default mime-type assignment of text/plain
> ("" =3D> "text/plain").  If my memory serves me, the other additions
> to the mime-type mapping was just cosmetic; and why not?
>=20
> Hmmm, I just noticed that the first hunk, which is needed to
> suppress a "lighttpd: not found" error message, could perhaps be
> seen as an un-related fix. Dunno.

Tested on my side using Cygwin 1.5.25 and httpd. Working fine. Thanks.

  Tested-by: Pascal Obry <pascal@obry.net>

or

  Signed-off-by: Pascal Obry <pascal@obry.net>

Not sure as I have never seen Tested-by!

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
