From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH 1/8] cherry-pick, revert: add the --gpg-sign option
Date: Sun, 3 Nov 2013 19:00:59 +0100
Message-ID: <20131103180059.GU4589@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
 <1383494064-5653-2-git-send-email-boklm@mars-attacks.org>
 <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nlttjmhgc7EeTk3T"
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Nov 03 19:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd1zK-0005uI-ER
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 19:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab3KCSBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 13:01:04 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:36300 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab3KCSBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 13:01:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id D975748C2;
	Sun,  3 Nov 2013 19:01:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 57rpHowBHfwn; Sun,  3 Nov 2013 19:01:16 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 5C9424238;
	Sun,  3 Nov 2013 19:01:16 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id E5E2443934; Sun,  3 Nov 2013 19:00:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237272>


--nlttjmhgc7EeTk3T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 03 Nov 2013, brian m. carlson wrote:

> On Sun, Nov 03, 2013 at 04:54:17PM +0100, Nicolas Vigier wrote:
> > diff --git a/sequencer.h b/sequencer.h
> > index 1fc22dcabe13..db43e9cf86dc 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -37,6 +37,8 @@ struct replay_opts {
> > =20
> >  	int mainline;
> > =20
> > +	const char *gpg_sign;
> > +
> >  	/* Merge strategy */
> >  	const char *strategy;
> >  	const char **xopts;
>=20
> One thing you're missing here is the ability to save and retrieve the
> options.  You might be cherry-picking or reverting multiple commits and
> get interrupted (maybe one is already applied) and need to use
> --continue.
>=20
> So populate_options_cb and save_opts need to learn about this sequencer
> option so that after --continue, commits continue to get signed.

Ah indeed, I didn't think about that. I will look at it. Thanks.


--nlttjmhgc7EeTk3T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJSdo9bAAoJECBnABsbZ4pjlxQQALNng9fmYYoJ054p7LNvDCKx
0YI+hFwaBVe97KP3tyPj19R0J7XKh9lGAFFz6VoFz04vIcE1oIULA0t0kxnzXAsC
jWovDXq4RZgGB8TcKyK/8VIrmhLdgSY9gTVFR9Yy4zgftKBXaSMYnuheOhgecXZn
hX4lo4ZdgfVIWydamNDmM1t61SkAuu5iI7b4FfKnf988qHftGqisiWVN4ybh1Kbm
tzLV8dhrhZ/a6sVwU39HXELenME3rFpr0Jw4hHnS6tMsXIbDdEParRUlpgUdiehM
6Fz60AeEG4UuQXFjHScVJ82SNrvX3iuCx9aPU3YNG46j8DClhnS0VT77Ghgxk1FK
D7/0gZ1g5+X4yvql5pIgs6mXHRdrqIltPlcrF6b1n6yyuczQxBYTvDzIfqdtE6xj
KxNMmvW5Sl78vos4FuLxHzM3Ota8D69olcI9uBsqQXTem0RAeIaL+yV7sCrCDixl
q6FouZm1Ozj6miWiP9sexZSJ49k0J9wR6pzEpPTXzO64Onx11G+t84mp7YHrqy/l
1sVU/hg+bYyIvf49TKWAXcCLGVzt9pNC2WQ5uvnRaleTrvDrn75dOCHlR6dC55Wn
cBIv0mfMuI8FopSwZcle5atz86IggP2x3bcwuCWMuz+I8T9AWeRnOwHHZFTlhAKF
dr9D7XJzSykZB+BfAhku
=4uYm
-----END PGP SIGNATURE-----

--nlttjmhgc7EeTk3T--
