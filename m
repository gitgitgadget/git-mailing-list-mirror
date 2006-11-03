X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 10:59:06 +0100
Message-ID: <20061103095905.GD7545@admingilde.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061103074857.GA15972@diana.vm.bytemark.co.uk> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
NNTP-Posting-Date: Fri, 3 Nov 2006 09:59:32 +0000 (UTC)
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30811>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfvpa-00039m-FS for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752805AbWKCJ7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbWKCJ7N
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:59:13 -0500
Received: from agent.admingilde.org ([213.95.21.5]:1944 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1752805AbWKCJ7M
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:59:12 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GfvpK-0003Kb-38; Fri, 03 Nov 2006 10:59:06 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Nov 03, 2006 at 12:51:32AM -0800, Junio C Hamano wrote:
>     With separate remotes, I'd need something like:
>=20
>             for b in master maint next pu
>             do
>                     git checkout $b && git pull && make || break
>             done
>=20
>     And I also would need to have per-branch configuration to merge
>     from ". remotes/origin/$b" without re-fetching while on a
>     non-master branch $b, for the above to work.  I still need to
>     remember to process "master" first, so all things considered,
>     this is a regression in usability for my workflow.

you could also run git-fetch first and then always default to
the local repository.  But that would of course make pull just
a shortcut for merge, without any fetch.

Would it be so bad for you to call fetch three times?
I think the most intuitive thing for pull would be to fetch into
remotes/<remotename>/* and then to merge
remotes/<remotename>/<currentbranch>.

--=20
Martin Waitz

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFSxLpj/Eaxd/oD7IRAhE9AJkBNqZkIzNbUEBpauyQK1eFleV3JwCfR+NC
c8svNGM/5Gr7VFG8nFOY3qw=
=f6KC
-----END PGP SIGNATURE-----

