X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 16:07:46 +0100
Message-ID: <20061201150746.GA18810@admingilde.org>
References: <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org> <45702C50.9050307@b-i-t.de> <20061201134311.GV18810@admingilde.org> <45703ACB.6050007@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McORcswOES2gGXLb"
NNTP-Posting-Date: Fri, 1 Dec 2006 15:08:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45703ACB.6050007@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32932>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq9zd-0005Y0-3g for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759078AbWLAPHs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbWLAPHs
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:07:48 -0500
Received: from agent.admingilde.org ([213.95.21.5]:36296 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1759078AbWLAPHr
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:07:47 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq9zO-0006w1-TQ; Fri, 01 Dec 2006 16:07:46 +0100
To: Stephan Feder <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--McORcswOES2gGXLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 03:23:07PM +0100, Stephan Feder wrote:
> And what is already there is a lot of meta information (see above). You=
=20
> do not need that.

What information are you refering to?
Perhaps you have looked into my old branch?
The current implementation is in "module2".

> For example, in the index, if it is a commit (i.e. a subproject), store=
=20
> the commit id (not the commit's tree id ).

This is exactly what I have done.

> Especially, extend update-index to be able to store a commit=20
> instead of the tree.

Done, except that update-index never stores trees ;-)

> Or else, do not change what is recorded in the index. Then, at commit=20
> time, you not only commit the superproject but also all subprojects.

But then submodules would be handled differently to files which I wanted
to avoid.

> To push and pull you have to extend the tools as well. That is the next=
=20
> step.

Also done.

--=20
Martin Waitz

--McORcswOES2gGXLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcEVCj/Eaxd/oD7IRAk9/AJ9LExFqfjVrgGmhKnDFDnRcqq/CJwCcCkSY
ZDoboe+5txUIM+JbLeAKPfk=
=J/5I
-----END PGP SIGNATURE-----

