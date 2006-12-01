X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 17:15:58 +0100
Message-ID: <20061201161558.GC18810@admingilde.org>
References: <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de> <20061201121110.GP18810@admingilde.org> <45702C50.9050307@b-i-t.de> <20061201134311.GV18810@admingilde.org> <45703ACB.6050007@b-i-t.de> <20061201150746.GA18810@admingilde.org> <45705283.5080900@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SHFFXbs3XlGSDX14"
NNTP-Posting-Date: Fri, 1 Dec 2006 16:16:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45705283.5080900@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32941>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqB3T-0000cp-Gq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031543AbWLAQQA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031552AbWLAQQA
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:16:00 -0500
Received: from agent.admingilde.org ([213.95.21.5]:45538 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031543AbWLAQP7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:15:59 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqB3O-0007V1-Rd; Fri, 01 Dec 2006 17:15:58 +0100
To: Stephan Feder <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--SHFFXbs3XlGSDX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 05:04:19PM +0100, Stephan Feder wrote:
> I was looking into git-init-module.sh (branch module2). There you set up=
=20
> a separate git repository for the submodule and store references to it=20
> into the supermodules's repository.

yes.

This is to be able to call git-fsck-objects and git-prune in the
toplevel supermodule.  When traversing the object tree, it already knows
about all submodule, but only about those versions that are really part
of their supermodule.
So I have to teach git about separate submodule branches which may be
used, in order not to prune them away.

--=20
Martin Waitz

--SHFFXbs3XlGSDX14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcFU+j/Eaxd/oD7IRAoNkAJ9msKhKBg3n/xn9K6Na5OMVzfipzgCdEtrD
OaA63dDDFe0pFwHfq4g90Ro=
=zOgD
-----END PGP SIGNATURE-----

