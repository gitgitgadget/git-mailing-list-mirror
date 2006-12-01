X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 15:58:17 +0100
Message-ID: <20061201145817.GY18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e9ndEBTQFD7P4kUb"
NNTP-Posting-Date: Fri, 1 Dec 2006 14:58:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45703375.4050500@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32930>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq9qR-0002xN-N2 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 15:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759261AbWLAO6T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759120AbWLAO6T
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 09:58:19 -0500
Received: from agent.admingilde.org ([213.95.21.5]:36224 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1759261AbWLAO6S
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 09:58:18 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq9qD-0006qD-FT; Fri, 01 Dec 2006 15:58:17 +0100
To: Stephan Feder <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--e9ndEBTQFD7P4kUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 02:51:49PM +0100, Stephan Feder wrote:
> If you work in the supermodule, even if it is in the code of the
> submodule, you only commit to the supermodule. The submodule does not
> "know" about these changes after step 1.

I think we are using totally different definitions of "submodule".

For me a submodule is responsible for everything in or below a certain
directory.  So by definition when you change something in this
directory, you have to change it in the submodule.
You can't change the submodule contents in the supermodule without also
changing the submodule.
This is just like you can't commit a change to a file without also
changing the file.

Then the supermodule just records the current content of the entire
tree.  The only new thing is that instead of simple files there are now
submodules and that are also recorded.

> Why do you mix up supermodule and submodule? The way I see your proposal=
=20
> you cannot change submodule and supermodule independently. That is a=20
> huge drawback.

No, this is the benefit you get by introducing submodules.
Why would you want to introduce a submodule when it is not linked to the
supermodule?

--=20
Martin Waitz

--e9ndEBTQFD7P4kUb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcEMJj/Eaxd/oD7IRArBhAKCB5C5I5LWDE7upBLkcStt2aZRUoQCghWrd
JUrMrCOen5ExHOnN6/xxpZY=
=nhcN
-----END PGP SIGNATURE-----

