From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Thu, 8 May 2014 01:22:38 +0000
Message-ID: <20140508012238.GA25231@vauxhall.crustytoothpaste.net>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
 <1399417144-24864-1-git-send-email-dturner@twopensource.com>
 <1399417144-24864-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Thu May 08 03:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiD2v-0004RZ-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 03:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbaEHBWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 21:22:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600AbaEHBWp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2014 21:22:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a04c:bcbd:f5ef:c7f5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A9FD328087;
	Thu,  8 May 2014 01:22:44 +0000 (UTC)
Mail-Followup-To: dturner@twopensource.com, git@vger.kernel.org,
	gitster@pobox.com, David Turner <dturner@twitter.com>
Content-Disposition: inline
In-Reply-To: <1399417144-24864-2-git-send-email-dturner@twopensource.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248397>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2014 at 03:59:04PM -0700, dturner@twopensource.com wrote:
> @@ -74,7 +74,7 @@ int cmd_mv(int argc, const char **argv, const char *pre=
fix)
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
>  	enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDEX } *modes;
> -	struct stat st;
> +	struct stat src_st,dst_st;

Extremely minor nit: we generally put a space after the comma.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTatxeAAoJEL9TXYEfUvaLihgQAIpHFWmbd45rXmI2ReVL5MsZ
uhZQnR0Smy/fknNAg2b+8hN/XbkaKhq0Z9+FNhrCqWL+BdnSdCIjuqe0Ee9nlD/N
oi1KFY9fTj9LuXZD+dw2gVeattoKg0f/MJEGyswNpEfkebhTYphiigyDBL38m8/M
LixnrumDAz/QqnICoPDNlIEbkNaYJ1qU3xmTi8BdPjah2dbuZCorzRrNQMFMmHXK
DNmUR9q3WxMYQmtEJHmNwl2qfHCvaQ1i8tX7WHBaux00vhbZlugbKqz7Mk9xdIc1
BIx1NhfHwiBLN29zoNI/aQbzXEhGCMisDnLLPzyPnqwN4s4+s6JXuOFQz0vhFJMK
KYpwv86cS6APYn0r3SbMB94ftGGCWAET8e97U4AnNucpGJfUDTKvLqO18fUvaRgU
lS+ztUlRamXjjTl8LiCAzacc3GL5gh+xwgGiED1jcCN3j7+N7Igr1sWJlNLVjvnx
X1hAYtOJiySdm913K8tbi/bfJFWRTPSOBSkV/Ak5bZmQCNEeN0REoY4vSigvjP/g
MRJ9SCwv0XSaiI1vkhv5Navt1ew4OH3AnlNtqppgrccYickM0NbXaRQGWLquFbSR
b6QvSZriw5aeY0t5/3eGA3bS8ITFnhSeIoPr3Jq5niItV9ZgJz5VcynBGv26CbTc
cENKcJ9l4RwZ4yBakE1l
=4wm9
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
