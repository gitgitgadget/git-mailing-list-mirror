From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [parse-options] proposal for merge, take 1
Date: Tue, 16 Oct 2007 10:43:35 +0200
Message-ID: <20071016084335.GH6919@artemis.corp>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <20071016082010.GD6919@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PpAOPzA3dXsRhoo+";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihi1l-0007Yg-Cq
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbXJPIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbXJPIni
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:43:38 -0400
Received: from pan.madism.org ([88.191.52.104]:59836 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757930AbXJPInh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:43:37 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7A3E8253C4;
	Tue, 16 Oct 2007 10:43:35 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 0EE9E32BA95; Tue, 16 Oct 2007 10:43:35 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20071016082010.GD6919@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61119>


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, oct 16, 2007 at 08:20:10 +0000, Pierre Habouzit wrote:
> On mar, oct 16, 2007 at 08:16:31 +0000, Pierre Habouzit wrote:
> >   The branch is available from git://git.madism.org/git.git in the topic
> > branch ph/parseopt. I just rebased it onto the last "next" spearce
> > produced.
>=20
> >       Make builtin-pack-objects.c use parse_options.
>=20
>   ERRR DON'T TAKE 25/25, it's WIP and is broken atm, format-patch again
> hasn't DWIM. It is not pushed to git://git.madism.org/git.git btw.

okay I'm wrong, sorry for the alarm, I just generated the --stat and shortl=
og
too broadly, but 25/25 is definitely OK.

Proper stats for part2 are:

  Jonas Fonseca (1):
      Update manpages to reflect new short and long option aliases

  Kristian H=C3=B8gsberg (1):
      Port builtin-add.c to use the new option parser.

  Pierre Habouzit (15):
      Make builtin-rm.c use parse_options.
      Make builtin-mv.c use parse-options
      Make builtin-branch.c use parse_options.
      Make builtin-describe.c use parse_options
      Make builtin-fetch.c use parse_options.
      Make builtin-revert.c use parse_options.
      Make builtin-update-ref.c use parse_options
      Make builtin-symbolic-ref.c use parse_options.
      Make builtin-http-fetch.c use parse_options.
      Make builtin-for-each-ref.c use parse-opts.
      Make builtin-fsck.c use parse_options.
      Make builtin-count-objects.c use parse_options.
      Make builtin-name-rev.c use parse_options.
      Make builtin-pack-refs.c use parse_options.
      Make builtin-show-ref.c use parse_options [small backward incompatibi=
lity].

    Documentation/git-add.txt          |    4 +-
    Documentation/git-branch.txt       |    2 +-
    Documentation/git-mv.txt           |    2 +-
    Documentation/git-rm.txt           |    4 +-
    Documentation/git-show-ref.txt     |    4 +-
    Documentation/git-symbolic-ref.txt |    2 +-
    builtin-add.c                      |   70 ++++++-----------
    builtin-branch.c                   |  147 +++++++++++++----------------=
-------
    builtin-count-objects.c            |   32 ++++----
    builtin-describe.c                 |   70 +++++++----------
    builtin-fetch.c                    |  146 ++++++++++++-----------------=
-------
    builtin-for-each-ref.c             |  138 +++++++++++++++--------------=
-----
    builtin-fsck.c                     |   80 ++++++-------------
    builtin-http-fetch.c               |   65 +++++++---------
    builtin-mv.c                       |   84 +++++++++------------
    builtin-name-rev.c                 |   64 ++++++----------
    builtin-pack-refs.c                |   47 +++++-------
    builtin-revert.c                   |   67 +++++++---------
    builtin-rm.c                       |   54 ++++++--------
    builtin-show-ref.c                 |  127 +++++++++++------------------=
--
    builtin-symbolic-ref.c             |   52 +++++--------
    builtin-update-ref.c               |   65 ++++++----------
    22 files changed, 515 insertions(+), 811 deletions(-)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFHm3vGr7W6HudhwRAoVVAJ44QMkQ/2fZFpuf9NavSJ10G3+CggCfdYck
/w5/26tdvlhSXE9iASH8C/o=
=5ite
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
