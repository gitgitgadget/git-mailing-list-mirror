From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: Fix typo in --detect-labels
Date: Wed, 21 Nov 2007 08:48:56 +0100
Message-ID: <200711210848.59818.simon@lst.de>
References: <e66701d40711201901n712e17e6x6018a4dc16e75cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1469796.L6l3UuoV0Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shun Kei Leung" <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukKq-00027i-B9
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055AbXKUHtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755861AbXKUHtF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:49:05 -0500
Received: from esparsett.troll.no ([62.70.27.18]:44657 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbXKUHtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:49:03 -0500
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 3A399741FF; Wed, 21 Nov 2007 08:49:01 +0100 (CET)
Received: from luria.local (unknown [10.3.5.222])
	by esparsett.troll.no (Postfix) with ESMTP
	id 30033741D6; Wed, 21 Nov 2007 08:49:01 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <e66701d40711201901n712e17e6x6018a4dc16e75cea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65617>

--nextPart1469796.L6l3UuoV0Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 21 November 2007 04:01:19 Shun Kei Leung wrote:
> Signed-off-by: Kevin Leung <kevinlsk@gmail.com>

Acked-by: Simon Hausmann <simon@lst.de>



Thanks,
Simon

>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 65c57ac..66b79b6 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1026,7 +1026,7 @@ class P4Sync(Command):
>
>          l = p4CmdList("labels %s..." % ' '.join (self.depotPaths))
>          if len(l) > 0 and not self.silent:
> -            print "Finding files belonging to labels in %s" %
> `self.depotPath` +            print "Finding files belonging to labels in
> %s" % `self.depotPaths`
>
>          for output in l:
>              label = output["label"]

--nextPart1469796.L6l3UuoV0Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQ+LrWXvMThJCpvIRAj7+AJ9JzvZZLpNTMHwBLAumfApGOK375gCffjfS
rILHYUJMRJK3hkdcjoVyvpg=
=aZZP
-----END PGP SIGNATURE-----

--nextPart1469796.L6l3UuoV0Z--
