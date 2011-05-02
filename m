From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2] Add default merge options for all branches
Date: Tue, 3 May 2011 00:47:35 +0200
Message-ID: <20110502224735.GU21056@genesis.frugalware.org>
References: <4DBF04C5.1080608@dailyvoid.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Cc: git@vger.kernel.org, deskinm@umich.edu, gitster@pobox.com
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Tue May 03 00:47:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH1u4-00047r-4P
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 00:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457Ab1EBWrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 18:47:39 -0400
Received: from virgo.iok.hu ([212.40.97.103]:42616 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806Ab1EBWri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 18:47:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1A0C4580BB;
	Tue,  3 May 2011 00:47:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5621544965;
	Tue,  3 May 2011 00:47:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 62406BAC005; Tue,  3 May 2011 00:47:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DBF04C5.1080608@dailyvoid.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172638>


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 02, 2011 at 02:23:49PM -0500, Michael Grubb <devel@dailyvoid.com> wrote:
>  		if (argc < 0)
> -			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> -			    split_cmdline_strerror(argc));
> +		{
> +			if (merge_option_mode == 1)

checkpatch.pl from the kernel tree may help you - { belongs to the end
of the previous line.

Thanks.

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2/NIcACgkQe81tAgORUJYqkgCeIE7sb4QdWAbUsp9zt7GZPxGg
kYcAoJs1Nv/ZVorQTW8mSn18AUiRceGB
=HUqQ
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
