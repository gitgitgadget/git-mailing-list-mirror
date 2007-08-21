From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
	documentation
Date: Tue, 21 Aug 2007 20:02:18 +0200
Message-ID: <20070821180218.GA14739@piper.oerlikon.madduck.net>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <7vd4xhsybm.fsf@gitster.siamese.dyndns.org> <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: hjemli@gmail.com, Junio C Hamano <gitster@pobox.com>,
	skimo@liacs.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 20:02:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INY3q-0006ty-NI
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759922AbXHUSCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761491AbXHUSCf
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 14:02:35 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48519 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759851AbXHUSCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 14:02:33 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id B2FC2895D9E;
	Tue, 21 Aug 2007 20:02:26 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15702-09; Tue, 21 Aug 2007 20:02:26 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 96967895D98;
	Tue, 21 Aug 2007 20:02:21 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id DE3B69F16A;
	Tue, 21 Aug 2007 20:02:18 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0F65243F4; Tue, 21 Aug 2007 20:02:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4xhsybm.fsf@gitster.siamese.dyndns.org> <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56320>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.08.20.2314 +0200]:
> > As per the discussion in this thread:
> >
> >   http://marc.info/?t=3D118721709500008&r=3D1&w=3D2
>=20
> I'd rather see you summarize the conclusion of the thread here.
> Having the URL as additional supporting reference is fine, but
> when one reviews the "git log" output, one is not necessarily
> online.

This is a good point, and I completely agree with you. In this very
case, however, I *consciously* decided against a summary simply
because I was hoping to capture the essence in the patch to the
documentation itself. Anyway, I shall keep your suggestion in mind.
Thanks for being so patient with me.

And while I still have your attention *grin*: I assume this is the
correct way of going about this: keep sending updated patches to the
same thread until it's accepted?

In this case, I'll just send the text before preparing the next
patch; once we agree on it, I'll send a patch. That should make it
easier on everyone.

> Is it "a user _has_ to"?  Or "a user can use 'git submodule
> init' to prepare?"
[...]
> I've read Sven's description on two files.  My suspicion is that
> instead of saying there are two files involved, it may be easier
> to understand if we tell the story like this:

Based your and Sven's suggestions, I sat down and thought for a bit,
then came up with this, which I like very much:

  FILES

  A repository with submodules is identified by a .gitmodules file
  in the repository's top level (see gitlink:gitmodules[5]). This
  file specifies for each submodule its name, the url of the
  submodule's repository, as well as the location of the submodule
  within the (super)project's repository. As the .gitmodules file
  contains information shared by all users of the repository, it is
  typically tracked.

  Users who clone the project's repository need to initialize each
  submodule before they can work with it. By initializing
  a submodule, the submodule's url is copied from the .gitmodules
  file to the (local) configuration in $GIT_DIR/config. The command
  `git-submodule init` can be used for this, or the information
  manually transferred. The key to each submodule's url in
  $GIT_DIR/config is "submodule.$name.url".

  Once a submodule's url is defined in $GIT_DIR/config, the
  submodule can be cloned (from this url) into the local repository
  with `git-submodule update` at the location specified in the
  .gitmodules file.

  By pulling the submodule urls out of $GIT_DIR/config,
  git-submodule allows contributors to use different urls (e.g. via
  ssh for those with an account) and also makes submodule urls
  independent of the currently checked out revision of the
  superproject.

In the process of writing this, I also added a bit to other parts of
the manpage:

  - added reference to FILES section next to .gitmodules file
    mention in description of add command, and a link to git-clone:

      ... and registered in the .gitmodules file (see section
      FILES). If no path is specified, the path is deduced from the
      repository specification (just like gitlink:git-clone[1]).

  - add to the update command description that modules can be
    specificed on the command line:

      Update all submodules registered in $GIT_DIR/config, or only
      those specified as arguments on the command line.

  - clarify what a detached HEAD is:

      This will make the submodules HEAD be detached (it then
      references a specific commit, not the tip of a branch anymore)

I am looking forward to your comments!

Thanks again for your patience.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
if loving linux is wrong, i don't want to be right.
=20
spamtraps: madduck.bogus@madduck.net

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyyiqIgvIgzMMSnURAudfAKCx4J7IeIVQaYX42hj2MeuMjDRqUACgwPVM
PK7BCcjGTn4OaK775MXNoJ4=
=oirU
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
