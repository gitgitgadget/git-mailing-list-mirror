From: Christian Wiese <morfoh@opensde.org>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 23:30:36 +0200
Message-ID: <20070323233036.77325e5a@athlon>
References: <20070322224829.GA7048@c3sl.ufpr.br>
	<20070323004335.GA17773@spearce.org>
	<Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_9TEfYFC3QkQP5L8bZPGq2Ab;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 22:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUrLk-0001u4-Ta
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 22:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXCWVbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 17:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXCWVbA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 17:31:00 -0400
Received: from foxtrot388.server4you.de ([85.25.140.218]:49351 "EHLO
	speakerboxxx.ixplanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356AbXCWVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 17:30:59 -0400
Received: (qmail 8132 invoked from network); 23 Mar 2007 21:31:20 -0000
X-Mail-Scanner: Scanned by qSheff-II-2.1-r2 (http://www.enderunix.org/qsheff/)
Received: from unknown (HELO athlon) (morfoh@opensde.net@[80.97.102.202])
          (envelope-sender <morfoh@opensde.org>)
          by speakerboxxx.ixplanet.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 23 Mar 2007 21:31:20 -0000
In-Reply-To: <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
X-Mailer: Claws Mail 2.8.1 (GTK+ 2.10.6; i686-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42960>

--Sig_9TEfYFC3QkQP5L8bZPGq2Ab
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

> > - Branches.  In SVN these are in the repository wide namespace,
> > but in Git they aren't.  I imagine we'd want to just enforce the
> > standard layout that the SVN people recommened:
> >
> >  /trunk/    --> refs/heads/master
> >  /branches/ --> refs/heads/ (minus master)
> >  /tags/     --> refs/tags/
>=20
> That would probably be good enough for the majority of=20
> one-project-per-repo Subversion projects at least.  Though there is
> still the issue that Subversion will actually let you create a "tag"
> simply by committing whatever you currently have in your working copy
> (including localally modified files ... yeuch).

If the proposed solution just supports "one-project-per-repo"
Subversion projects then you won't attract much projects which are
currently using subversion. I don't know many svn repos of this kind.

What you should also consider, is that a project might have splitted a
project within a repo into smaller subprojects.
I'm currently facing this issue while trying to migrate from svn to git
within my local working environment to gather experience while working
with git to be able to effectively "sell" git to the other people of
our project and provide a smooth migration path for them.

Chris

--Sig_9TEfYFC3QkQP5L8bZPGq2Ab
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGBEcEFAiA38MZhZ0RAvFbAJ982iOAvS37kXbJYRwAOZvSuWWaiwCggbz2
Bdoh2yMydcpo9QRIWAX3mV0=
=VnEk
-----END PGP SIGNATURE-----

--Sig_9TEfYFC3QkQP5L8bZPGq2Ab--
