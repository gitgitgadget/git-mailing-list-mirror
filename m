From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Fix an obvious typo
Date: Sun, 3 Feb 2008 19:36:02 +0100
Message-ID: <200802031936.02828.simon@lst.de>
References: <182304.89601.qm@web39507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1715428.d040oJboTV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
To: Tommy Thorn <tt1729@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjqU-0006Kx-U9
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYBCSok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYBCSoj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:44:39 -0500
Received: from hoat.troll.no ([62.70.27.150]:48637 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbYBCSoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 13:44:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id E063D58040;
	Sun,  3 Feb 2008 19:35:16 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 15863-06; Sun,  3 Feb 2008 19:35:16 +0100 (CET)
Received: from luria.local (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 8C6AB58030;
	Sun,  3 Feb 2008 19:35:16 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20080118.763038)
In-Reply-To: <182304.89601.qm@web39507.mail.mud.yahoo.com>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72390>

--nextPart1715428.d040oJboTV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 02 February 2008 09:11:44 Tommy Thorn wrote:
> The regexp "$," can't match anything. Clearly not intended.
>
> This was introduced in ce6f33c8 which is quite a while ago.
>
> Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>

Acked-by: Simon Hausmann <simon@lst.de>


Simon

> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index c80a6da..553e237 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1670,7 +1670,7 @@ class P4Clone(P4Sync):
>          depotPath = args[0]
>          depotDir = re.sub("(@[^@]*)$", "", depotPath)
>          depotDir = re.sub("(#[^#]*)$", "", depotDir)
> -        depotDir = re.sub(r"\.\.\.$,", "", depotDir)
> +        depotDir = re.sub(r"\.\.\.$", "", depotDir)
>          depotDir = re.sub(r"/$", "", depotDir)
>          return os.path.split(depotDir)[1]

--nextPart1715428.d040oJboTV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHpgmSWXvMThJCpvIRAmsbAJ9RaNTiQOcY7phWsGEl6yGNUrJF8QCeNW7g
XiS433AqV2Zx8/nlcWyasOo=
=slRy
-----END PGP SIGNATURE-----

--nextPart1715428.d040oJboTV--
