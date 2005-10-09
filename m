From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Problems cloning
Date: Sun, 9 Oct 2005 16:15:47 +0200
Message-ID: <20051009141547.GA8609@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
X-From: git-owner@vger.kernel.org Sun Oct 09 16:16:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOby7-00034Y-NM
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 16:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJIOPu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 10:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJIOPu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 10:15:50 -0400
Received: from wg.technophil.ch ([213.189.149.230]:61924 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750700AbVJIOPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 10:15:49 -0400
Received: (qmail 9279 invoked by uid 1000); 9 Oct 2005 14:15:47 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9865>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Cloning gitweb from kernel.org fails:

----------------------------------------------------------------------
[16:10] hydrogenium:build% cg-clone http://www.kernel.org/pub/scm/git/gitwe=
b.git=20
defaulting to local storage area
16:10:35 URL:http://www.kernel.org/pub/scm/git/gitweb.git/HEAD [41/41] -> "=
refs/heads/.origin-fetching" [1]
progress: 84 objects, 295012 bytes
Getting pack list
Getting alternates list
error: Unable to find d263a6bd453df849c9f9211f1966c830c3cf913a under http:/=
/www.kernel.org/pub/scm/git/gitweb.git/

Cannot obtain needed commit d263a6bd453df849c9f9211f1966c830c3cf913a
while processing commit f5dfb3f6a6655d4d60fdd0aaeef7b5b14226147f.
cg-fetch: objects fetch failed
cg-clone: fetch failed
----------------------------------------------------------------------

Info:

----------------------------------------------------------------------
[16:01] hydrogenium:cinit% cg --version
cogito-0.15.1 (cfeac5893d97b830ac31b9d41951c30f80967410)

[16:13] hydrogenium:cinit% git --version
git version 0.99.7d
----------------------------------------------------------------------

Greetings,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ0kmE7OTBMvCUbrlAQIWbw//WbDK0sTI0w+vHj0l6NvTRZsbL/TK5WnG
zrxlbCOoGYEQtcsy3J5UNdP3BYShmT2iLvlNNxjGxKzAkoGKIi+i+ed35zee2ANx
eZDx4bxVBpJutxlRfVlk0SUSX/aSBE+7ss0Anbva9HmdueiUiCezD7KSysNgHQbY
+xCvz3iSA/yS/l0ff/bVHidAvAeFmeq2E8QfHgMPLXk37Zl5rP0GOGOrjvgIYFBF
R6UItWq0oAeE7TwljGKphSPFplzG1uQAyEt1YrohISeWoz4gsgTHytGjuU9y8+43
fonKUUaFrhvIgiuDuiM+jd8cl2SFoMSQWGQx18sxSbOsmlurIiqlrNjulGAd8XhZ
fukZLx8/Prcq/gW30+ynNrW2lqmxw+ERvXogz+PB3PBCgj90Q3j1378bnyCAqnke
ymnPQyVSUFUOzC+OlCWbKKNXoWiBvx7zB3fMHOhT9wMtDbd07fHf8v+INGfN8SLC
XkFLVKcAFqc/dF3QArzp4ZOY4RRyp3OlMuSMw0x4zkhVE0VlcVqChJKn0na1iEgk
T4AT66H8gwYNtFSl3KTF4Z9FYIHfYojC2ZEeENRJXfQbIqCcmEp2mzKLrkiaMjt8
sJQ1EM52y9+3aZpFaXpAJO6tWoU1awCCLTpy79/mqnOQAtn2JByZhM0QQ7TrBW9c
3j+/UdUiQHc=
=ZvTz
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
