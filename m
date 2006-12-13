X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sebastian Harl <sh@tokkee.org>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 09:46:20 +0100
Message-ID: <20061213084620.GN2476@albany.tokkee.org>
References: <20061212232321.GL2476@albany.tokkee.org> <Pine.LNX.4.63.0612130102000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LvAn5G4Ewe70kJ1i"
NNTP-Posting-Date: Wed, 13 Dec 2006 08:46:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612130102000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34185>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuPl9-0000dr-37 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 09:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932620AbWLMIqW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 03:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWLMIqW
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 03:46:22 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39632 "EHLO
 albany.tokkee.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S932620AbWLMIqW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 03:46:22 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000) id DF0EE364001;
 Wed, 13 Dec 2006 09:46:20 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--LvAn5G4Ewe70kJ1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2006 at 01:03:21AM +0100, Johannes Schindelin wrote:
> On Wed, 13 Dec 2006, Sebastian Harl wrote:
>=20
> > When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.s=
h=20
> > fails with the following output:
> >=20
> >   * FAIL 6: detect node change from directory to file #1
> >          git-svn commit --find-copies-harder --rmdir \
> >		 remotes/git-svn..mybranch2
>=20
> Could you please run the test like this:
>=20
> git/t> sh t9100-* -i -v

  * expecting failure: git-svn commit --find-copies-harder --rmdir remotes/=
git-svn..mybranch2
  diff-tree 5d3b7d019e8fa8d509091bd1d80113c8f20f9f4f 91d77f97b74783aa97ba2a=
ed5a966e936eb9d30f
  Transaction is out of date: Out of date: 'test-git-svn/bar' in transactio=
n '2-2' at /home/tokkee/projects/debian/backports/backports.org/git-core/gi=
t-core-1.4.4.2/t/../git-svn line 1573
  65280 at /home/tokkee/projects/debian/backports/backports.org/git-core/gi=
t-core-1.4.4.2/t/../git-svn line 575
  	main::commit_lib('91d77f97b74783aa97ba2aed5a966e936eb9d30f') called at /=
home/tokkee/projects/debian/backports/backports.org/git-core/git-core-1.4.4=
=2E2/t/../git-svn line 481
  	main::commit('remotes/git-svn..mybranch2') called at /home/tokkee/projec=
ts/debian/backports/backports.org/git-core/git-core-1.4.4.2/t/../git-svn li=
ne 173
  * FAIL 6: detect node change from directory to file #1
  	git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--LvAn5G4Ewe70kJ1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFf73cEFEKc4UBx/wRAvTzAJ9THS0uW7F9y5g3ZicdSsdU3h4qzQCfe88o
AoLMxG3J+P7Af9LUAD/UwBI=
=t5bE
-----END PGP SIGNATURE-----

