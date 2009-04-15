From: Ricky Zhou <ricky@fedoraproject.org>
Subject: Re: [PATCH] Use &#160; instead of &nbsp; for XHTML compliance
Date: Wed, 15 Apr 2009 12:21:23 -0400
Message-ID: <20090415162123.GC3316@sphe.res.cmu.edu>
References: <20090415154012.GX13966@inocybe.teonanacatl.org> <200904151755.07425.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7tL-0003Oh-Jg
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZDOQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbZDOQVl
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:21:41 -0400
Received: from mx2.redhat.com ([66.187.237.31]:44168 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbZDOQVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:21:40 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3FGLQgQ018165;
	Wed, 15 Apr 2009 12:21:26 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3FGLOww000939;
	Wed, 15 Apr 2009 12:21:25 -0400
Received: from localhost (vpn-14-120.rdu.redhat.com [10.11.14.120])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3FGLNs6027194;
	Wed, 15 Apr 2009 12:21:23 -0400
Content-Disposition: inline
In-Reply-To: <200904151755.07425.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116623>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009-04-15 05:55:04 PM, Jakub Narebski wrote:
> Wouldn't it be a better solution to add DTD with HTML entities if/when
> gitweb serves XHTML 1.0 together application/xhtml+xml mimetype, instead
> of unconditionally using what is I think worse solution? Especially that
> error is I think quite rare situation and/or bug in browser...
>=20
> I also don't think that the change -nbsp =3D> -subspaces is necessary;
> it causes large code churn for nothing, and name is IMVHO worse.
> It is about nonbreakable and non-compactable space.
Sorry, as Mike mentioned, I was mistaken about the validity of &nbsp;.
I'm going to try to reproduce this myself so I can look more into what
actually caused the error.

Thanks,
Ricky

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknmCYMACgkQrH1ufGsbJY3WGwCdEQDHqyzDroXVDe8q0kgusmaY
p/UAoIyYD5aQTl23fKfu8270SZT1fz61
=P/T9
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
