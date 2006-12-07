X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Locked down (but still shared) repositories
Date: Thu, 7 Dec 2006 13:21:11 +0100
Message-ID: <20061207122111.GD10468@admingilde.org>
References: <20061207113539.GA10781@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
NNTP-Posting-Date: Thu, 7 Dec 2006 12:21:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061207113539.GA10781@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33574>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsIFc-0005UU-Ve for gcvg-git@gmane.org; Thu, 07 Dec
 2006 13:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032112AbWLGMVO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 07:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032118AbWLGMVO
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 07:21:14 -0500
Received: from mail.admingilde.org ([213.95.32.147]:36861 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1032112AbWLGMVN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 07:21:13 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GsIFT-0004Rp-UI; Thu, 07 Dec 2006 13:21:11 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Dec 07, 2006 at 06:35:39AM -0500, Shawn Pearce wrote:
> So I've patched git-receive-pack to refuse to run if its running
> setuid and the hook's owner isn't the effective uid, or the hook
> is group/world writable.  This seems to close the last hole, but
> it also makes hooks/update and hooks/post-update useless in user
> private repositories on this system.

perhaps don't refuse to run, but simply change back to the safed uid?
Or use one special machine which hosts the repository and which has
the modified version of git installed.

--=20
Martin Waitz

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFeAc3j/Eaxd/oD7IRAn28AJ0Vuo/LIHPKUqQJgGGUa5j2KKgeFgCfQD2B
/jWMspt+vkOiRjMfr0AM1mg=
=+QRM
-----END PGP SIGNATURE-----

