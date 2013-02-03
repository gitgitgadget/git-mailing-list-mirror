From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Feature request: Allow extracting revisions into directories
Date: Sun, 03 Feb 2013 15:18:05 +0100
Message-ID: <1359901085.24730.11.camel@t520>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wUMmeZUxhLbH0dGHTT3Z"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 15:18:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U20P5-0005Ud-MJ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab3BCOSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:18:22 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:34779 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3BCOSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:18:21 -0500
Received: by mail-bk0-f49.google.com with SMTP id w11so2421808bku.8
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 06:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:content-type:x-mailer
         :mime-version;
        bh=u0AoVTIeINzS5hyrRCFySkGxC3uZQLM7WqIEvCuOJDc=;
        b=mI/psy9Lh/zXiEbPq7yfMIvF9XLX3rUu2Pen5Nk7spfVX4ZP5jTrOn0L36/UiEGtD4
         33Szxzt6KyADw9xhLAwV73zamhWLjFc5DCfTzUEDlIKzOS4boJIJL4YbehOxInndNLNy
         nYVh5Y+8PDKN8Rbs5oWtZE3gHV/nhlndy3AJ0vDpQoNQv8QSYs6PGtkDXkXEeNXjWGKc
         cQXSCuQOoz8c9tnV0y/UOJvojHe97kqtH9by7TxmHGyktmBcxNOoJ1qlFDwK1myx4TEi
         aFNBoyupxp9UfrQEDc6pPUYDTZa++67WecuTIMK9yDA0d8VLcXs+Es2wBYBY7jaHbVUp
         hpPg==
X-Received: by 10.204.145.83 with SMTP id c19mr4019987bkv.69.1359901099790;
        Sun, 03 Feb 2013 06:18:19 -0800 (PST)
Received: from ?IPv6:2a01:1e8:e100:10b::2? (cl-268.leo-01.de.sixxs.net. [2a01:1e8:e100:10b::2])
        by mx.google.com with ESMTPS id r17sm4403437bkw.21.2013.02.03.06.18.18
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 06:18:19 -0800 (PST)
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215309>


--=-wUMmeZUxhLbH0dGHTT3Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

git currently has the archive command that allows to save an arbitrary
revision into a tar or zip file. Sometimes it is useful to not save this
revision into an archive but to directly put all files into an arbitrary
directory. Currently this seems to be not possible to archive directly;
the only way I found to do it is to run git archive and then directly
unpack the archive into a directory.

    git --git-dir REPO archive REVISION | tar x

It would be nice to have a command or simply a switch to git archive
that allows the user to put the files of REVISION into a directory
instead of making an archive.

Thank you very much for your help. Yours,

Robert Clausecker

--=-wUMmeZUxhLbH0dGHTT3Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJRDnGdAAoJEDpa/qG5y+V5/30IAIRGEW8r3yHH9OAgh27XT528
HIGmYETKXxX7557XKDdQq8MiXzQeus9D/7luE+ab+ZSpNaI49tHq5o6cBQ+Gz6Ki
nH1Ma6WWS8bdIEdqs7S8iaXjBBXfEa07YjXkAtgpca9e3R21oI8GzsFMypNPAIN/
NObvYIlD5gzS9DoLT0rg2KIhAKmiT6/Dyz3lECJINLzoMhEN/seYy6A+SlF6fC7j
8BUdurGUv3QG9UotxOOAoxlTwprVIpW5J7weKMq4Ih30LmokyFI7DjcKfSLK9EoN
QuYLUO2TyuNvck0JvuiUD5hGDHIVmyjNz57uhS3NcMfj2L6Z6AfsRXqd681M8wI=
=rKVJ
-----END PGP SIGNATURE-----

--=-wUMmeZUxhLbH0dGHTT3Z--
