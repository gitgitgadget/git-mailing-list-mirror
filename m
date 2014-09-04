From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Can git detect and manage source file's extensional attribute by
 command 'setfattr' ?
Date: Thu, 4 Sep 2014 13:07:28 +0000
Message-ID: <20140904130728.GB17505@vauxhall.crustytoothpaste.net>
References: <CAHbSJRD=S4u=_Ke3UKfzaVdsPnjvkKf0VYBjo8sNjFXM32wKTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Cc: git@vger.kernel.org
To: wangfeng wangfeng <wangfeng.v1.1985@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPWlE-0001Ux-3f
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 15:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbaIDNHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 09:07:33 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49974 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751106AbaIDNHd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 09:07:33 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1B9EA2808F;
	Thu,  4 Sep 2014 13:07:32 +0000 (UTC)
Mail-Followup-To: wangfeng wangfeng <wangfeng.v1.1985@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAHbSJRD=S4u=_Ke3UKfzaVdsPnjvkKf0VYBjo8sNjFXM32wKTQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256440>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2014 at 04:11:06PM +0800, wangfeng wangfeng wrote:
> Hi ,
>     I know that git can cope with file's chmod. But how about
> setfattr? I have tried to set some extensional attribute with command
> :
> ####
> setfattr -n user.t1 -v 1 testfile.txt
> ####
> It seems like git cannot detect it. So do I need some config option
> for git? Or doesn't it have this feature?
>     Thanks very much.

No, Git doesn't support extended attributes natively.  In fact, the only
modes that Git stores are the file type and the executable bit.

If you need to store this information, you could either have it
recreated by running, say, a Makefile, or you could see if the filter
functionality of .gitattributes does what you want.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUCGQQAAoJEL9TXYEfUvaLdloQAI81ag57gP1BwZlKa39kEE05
TkgCqZqfIW4cz1JvXyEvQV73JMQa4peZoL2SFgqvgJ8pvF6rLHYC3IHlHKM8QKK7
a3PBo/txpFBibmunsWfdEuvIA2eecx0E6DgkU8k8xAtaVKR3oLSc33TIP1046Bt9
UvEDVYXSHTQSUegvP1KM9/iJ1YTF/bpFPvbRbCFFb+Y+HX/3BhMBanDOuk9YnAee
W/d7vnFwKx1a+bO2tf4IvV3lM093SX14Ei2RTnZTvO7k3JWi37JYdv7jscvqz2U8
Wtm5VFapRFGS5WZHxHNIJwZl8VxivT6mF7rXdd75LCz2sN1o4IjV8QNqw5xlK7xN
Pg84vKMLFwxeOmSZEPPRHhG/HBPPa1TgA7m27sEOD3XUb2fkBXGZYz5NFogkq92h
svFfshPMW8cI4ZagH5VAh1yhER0oGtmgqTGLbjOt54rS7UxGDfCMvebfSWpEF71W
2Qoph+TDj0kdYLCGHVfVkO0tZuug0ldHLQWKKnUFv8ofjXTDbtsq228/PQIzQ8zL
VpsLOKzLa6f9jiLXzzeyX6/JeLz9LXQNAikLnAr+FHnbYNORIrtaKXEMSOm10Kxh
ztnWbuHvhabwLfwKx1T6BnsKxCZINhchBzkigXP9eZUCIZEDxuEnt04FBcLIUHVR
2dAMMeoFbrrLvtscqgkD
=2gOC
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
