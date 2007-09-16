From: Jan Hudec <bulb@ucw.cz>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 17:59:13 +0200
Message-ID: <20070916155913.GB30476@efreet.light.src>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site> <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Sep 16 17:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWwWp-00023y-CL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 17:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbXIPP7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbXIPP7S
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 11:59:18 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:52805 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbXIPP7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 11:59:18 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id E5A6A572EA;
	Sun, 16 Sep 2007 17:59:16 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id EIvG5TMxEqGa; Sun, 16 Sep 2007 17:59:14 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A385F572E8;
	Sun, 16 Sep 2007 17:59:14 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IWwWf-0000Fe-DX; Sun, 16 Sep 2007 17:59:13 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58322>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2007 at 18:30:53 -0700, david@lang.hm wrote:
> 1. whatever is trying to write the files with the correct permissions
>    needs to be able to query the permission store before files are
>    written. This needs to either be an API call into git to retreive the
>    information for any file when it's written, or the ability to define a
>    specific file to be checked out first so that it can be used for
>    everything else.

You seem to be forgetting about the index. Git never writes trees directly =
to
filesystem, but always with intermediate step in the index. So the API
actually exists -- simply read from the index.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7VLRRel1vVwhjGURAjZeAKDD9JpjkqDkQbvG5Zvqhvar1VXmoQCdFRFn
XRd38N31LkccTyJPBOcKnBo=
=D1eD
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
