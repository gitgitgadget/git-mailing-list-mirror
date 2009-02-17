From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 12:04:09 +0100
Message-ID: <200902171204.20184.trast@student.ethz.ch>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org> <m3wsbps708.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1810204.jZaKOdLaiX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 12:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNlv-0002MX-87
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 12:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbZBQLEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 06:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZBQLEX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 06:04:23 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6363 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbZBQLEW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 06:04:22 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 12:04:21 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Feb 2009 12:04:20 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <m3wsbps708.fsf@localhost.localdomain>
X-OriginalArrivalTime: 17 Feb 2009 11:04:20.0879 (UTC) FILETIME=[7C00F1F0:01C990EF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110357>

--nextPart1810204.jZaKOdLaiX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jakub Narebski wrote:
> > * tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
> >  - Test git-patch-id
> >  - Test rev-list --parents/--children
> >  - Test log --decorate
> >  - Test fsck a bit harder
> >  - Test log --graph
> >  - Test diff --dirstat functionality
> >  - Test that diff can read from stdin
> >  - Support coverage testing with GCC/gcov
>=20
> Hmmmm... wouldn't it be nice to have more tests?

I was hoping the coverage patch would give people an incentive to
write some ;-)

Seriously, the list is huge.  Running the tests in my private
next-and-then-some branch[*], summarizing by function counts and
filtering for >2 untested functions shows:

      4 builtin-apply.c
      4 builtin-blame.c
      6 builtin-fetch-pack.c
      3 builtin-fsck.c
      6 builtin-log.c
      4 builtin-pack-objects.c
      4 builtin-rev-parse.c
      6 builtin-show-branch.c
      3 builtin-update-index.c
      4 builtin-upload-archive.c
      3 config.c
      7 connect.c
      8 date.c
      4 diffcore-order.c
      3 fsck.c
      8 help.c
      5 index-pack.c
      6 merge-file.c
      4 mktree.c
      4 object.c
      4 pager.c
      3 refs.c
      3 shell.c

plus some matches in HTTP, IMAP etc. code that I'll just ignore for
now.

Some of it is fairly easy stuff; for example, rev-parse
=2D-{all,branches,tags,remotes} is completely untested according to the
coverage report.  I might add more tests as my time allows, but it is
also limited.


[*] git://repo.or.cz/git/trast.git next

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1810204.jZaKOdLaiX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmambQACgkQqUud07tmzP2iJgCfekSouMpim4zhgmAIX+En4Nwj
lkEAn1B68z+GoyyrQn0Vk5OShjTBDi1x
=OcrF
-----END PGP SIGNATURE-----

--nextPart1810204.jZaKOdLaiX--
