From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 12:08:40 +0200
Message-ID: <20071005100840.GI19879@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eVzOFob/8UvintSX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idk73-00009J-Px
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 12:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXJEKIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 06:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXJEKIn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 06:08:43 -0400
Received: from pan.madism.org ([88.191.52.104]:35005 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbXJEKIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 06:08:43 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E2AC72382E;
	Fri,  5 Oct 2007 12:08:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DA4B43575D4; Fri,  5 Oct 2007 12:08:40 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1191447902-27326-1-git-send-email-krh@redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60062>


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 09:45:01PM +0000, Kristian H=C3=B8gsberg wrote:
> +static int parse_one(const char **argv,
> +		     struct option *options, int count,
> +		     const char *usage_string)
> +{
> +	const char *eq, *arg, *value;
> +	int i, processed;

  gcc complains processed could be returned without being initialized
first, so should be processed =3D 0; Even if it cannot occurs, it avoid
raising eyebrows.

> +	case OPTION_INTEGER:
> +		if (value =3D=3D NULL) {
> +			error("option %s requires a value.", argv);

                                                             ^^^
                                           should probably be arg.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBg0ovGr7W6HudhwRAjJeAKCoImEHubmHxRCSuy8HYzhSTr2OigCeP3LS
K25F62DQG1Ykhbgho/6ZhWU=
=csBM
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
