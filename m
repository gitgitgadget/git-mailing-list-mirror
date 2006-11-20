X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 23:28:53 +0100
Message-ID: <20061120222853.GB20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
NNTP-Posting-Date: Mon, 20 Nov 2006 22:29:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejt9dh$kfm$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31944>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHdL-0005En-0Q for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934006AbWKTW2z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934217AbWKTW2z
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:28:55 -0500
Received: from agent.admingilde.org ([213.95.21.5]:35513 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S934006AbWKTW2y (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:28:54 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmHdF-0003O3-OA; Mon, 20 Nov 2006 23:28:53 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 20, 2006 at 11:16:45PM +0100, Jakub Narebski wrote:
> Martin Waitz wrote:
> > A submodule really is part of the parent tree, so it is very natural to
> > add the link to the submodule commit into the GIT tree data structure.
> > In addition to links to blobs and other trees, they can now also hold
> > a link to a commit, which in turn has the pointers to the submodule tree
> > and its history. =A0In order to differenciate a submodule entry with
> > normal file or directory entries, they get a special file mode.
>
> Erm... isn't a _type_ of tree entry saved somewhere? Currently it can
> be only 'tree' or 'blob', what you do is adding 'commit' (then permissions
> are permissions of top tree of module, of course).

It is saved inside the object which is being refered to.
Right now tree objects are also identified by their file mode and not
by the type of object which is referenced.

> By the way, in todo branch, in Subpro.txt, there is talk about adding
> link to submodule trees in _commit object_... well link to submodule tree
> or commit, with the "mount point".

But isn't the submodule really part of the tree?
Right now the commit is used to construct the history of one project.
And a submodule is not part of the history of the parent, it is part
of the parent's tree.

--=20
Martin Waitz

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYiwlj/Eaxd/oD7IRAuzMAKCFPu6VbkWGlg2CjoEZ1DwkQYommQCcCKcV
RywFV6ovcbP2145OYPsKlbQ=
=O/CS
-----END PGP SIGNATURE-----

