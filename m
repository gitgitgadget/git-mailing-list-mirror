From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 10:05:23 +0200
Message-ID: <20101019080523.GB22067@login.drsnuggles.stderr.nl>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dbZqg9QBcePwoL0u"
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 10:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P87Cn-0000ZJ-Qj
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 10:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab0JSIFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 04:05:30 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:54596 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873Ab0JSIF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 04:05:26 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1P87CF-0004Bz-R2; Tue, 19 Oct 2010 10:05:24 +0200
Received: (nullmailer pid 16115 invoked by uid 1000);
	Tue, 19 Oct 2010 08:05:23 -0000
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3ocar5fmo.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159312>


--dbZqg9QBcePwoL0u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>  * The `--cached` option is used to ask a command that
>    usually works on files in the working tree to *only* work
>    with the index.  For example, `git grep`, when used
>    without a commit to specify from which commit to look for
>    strings in, usually works on files in the working tree,
>    but with the `--cached` option, it looks for strings in
>    the index.
>=20
>  * The `--index` option is used to ask a command that
>    usually works on files in the working tree to *also*
>    affect the index.  For example, `git stash apply` usually
>    merges changes recorded in a stash to the working tree,
>    but with the `--index` option, it also merges changes to
>    the index as well.

Doesn't this just offer opportunity for two new options? E.g., --staged
and --also-staged or --include-staged or something? In the current form,
these two options provide a variation of the same concept, using
completely different option names (which could lead people to think
that they're really the same option, just inconsistently implemented).

So, regardless of changing over to --staged, I guess these two options
could be made more consistent (though sticking to the "index"
terminology is tricky, since that would require --cached to be become
--index and --index to become --include--index, which throws away
backward compatibility...).

FWIW, I do rather like the "staging area" concept, since I feel it
accurately describes its use (or at least the most common use of the
staging area).

Gr.

Matthijs

--dbZqg9QBcePwoL0u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky9UUMACgkQz0nQ5oovr7xEfQCgxlPsYYgF/XupD6kceR3eeSNF
+o4An1XwrqNTFS7y4QYlHBvf91zd9eP4
=NWAF
-----END PGP SIGNATURE-----

--dbZqg9QBcePwoL0u--
