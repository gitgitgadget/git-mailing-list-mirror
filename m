From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 2/2] git-svn: Configure a prompt callback for
	gnome_keyring.
Date: Fri, 27 Apr 2012 11:36:19 +0200
Message-ID: <20120427093618.GE4023@login.drsnuggles.stderr.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl> <1335468843-24653-1-git-send-email-matthijs@stdin.nl> <1335468843-24653-2-git-send-email-matthijs@stdin.nl> <20120427082840.GB7257@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="06QVapOOS70QnETl"
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNhbl-0000TY-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 11:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab2D0Jg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 05:36:27 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:50873 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2D0Jg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 05:36:26 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNhb9-0004oD-4e; Fri, 27 Apr 2012 11:36:20 +0200
Received: (nullmailer pid 18485 invoked by uid 1000);
	Fri, 27 Apr 2012 09:36:19 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120427082840.GB7257@dcvr.yhbt.net>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196460>


--06QVapOOS70QnETl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> > This requires changes in the subversion perl bindings which have been
> > committed to trunk (1241554 and some followup commits) and should be
> > available with the (as of yet unreleased) 1.8.0 release.
> I'm a hesitant to use/depend on unreleased functionality in SVN.
>=20
> Is there a chance the API could change before the release.  Also, what
> kind of tests do the SVN guys do on the Perl bindings + GNOME?  I'm
> especially concerned since we just worked around segfault bugs in the
> other patch.
There is a testcase for this particular function (though it only tests
calling the function, not the full workings because no gnome-keyring is
available in the testsuite).

As for the other segfault: the reason for that one was that apparently
swig autogenerates bindings even when some typemaps are missing and then
just puts an abort or failing assert or something like that in there.
Unlikely to happen here, but I understand your restraint.

> Can we put this on hold until somebody can test the 1.8.0 release?
Sure, the change won't be useful without svn 1.8.0 anyway (and since
it's not a critical feature, we can live without it in the window
between 1.8.0 and the next git release as well).

I'll try to keep any eye on the 1.8.0 release. According to the svn
roadmap [1] it is planned for july (1.7.0 + 9 months) but looking at the
list of features "not started", I'd say it might be later...

http://subversion.apache.org/roadmap.html

Gr.

Matthijs

--06QVapOOS70QnETl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+aaJIACgkQz0nQ5oovr7zNsQCgo+wbg1u8sc1pFvTLEcWW31ze
mq8AoNx+53Ld8Jap5ell9cEFPxC0x8k0
=ncG3
-----END PGP SIGNATURE-----

--06QVapOOS70QnETl--
