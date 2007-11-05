From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Use parseopts in builtin-fetch
Date: Mon, 05 Nov 2007 09:43:33 +0100
Message-ID: <20071105084333.GA25574@artemis.corp>
References: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6TrnltStXW4iwmi0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 09:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoxYm-0001OH-OZ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 09:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbXKEIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 03:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbXKEIni
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 03:43:38 -0500
Received: from pan.madism.org ([88.191.52.104]:33687 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbXKEInh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 03:43:37 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 499FC258FA;
	Mon,  5 Nov 2007 09:43:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 1D2888550; Mon,  5 Nov 2007 09:43:33 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63489>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 03:35:34AM +0000, Daniel Barkalow wrote:
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I mostly did this and the next one for practice with the API. I'm=20
> impressed that "git fetch -vv" is even handled correctly without anything=
=20
> special. Now that I've done it, assuming I did it right, it might as well=
=20
> get added to the series.

  I believe the same patches (or very similar ones) are in pu but are
not in next yet because they conflict with the builtin-fetch recent
series.

  see http://git.madism.org/?p=3Dgit.git;a=3Dblobdiff;f=3Dbuiltin-fetch.c;h=
=3D12b1c4;hp=3D6b1750d;hb=3D7407915;hpb=3D61610e6

> +		OPT_BOOLEAN('q', "quiet", &quiet, "fetch silently"),

  there is an OPT__QUIET(&quiet) for this one.

> +	i =3D 1;
>  	if (i < argc) {
>  		int j =3D 0;
>  		refs =3D xcalloc(argc - i + 1, sizeof(const char *));

  this is wrong, you meant i =3D 0, and frankly, it's better to just strip
i altogether.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLte1vGr7W6HudhwRArAbAKCp+tMIw66hTZvmecb0ukw/+j1AtwCfe4Mv
ymHjW9xkzAoloGxc1dBwby0=
=+tuv
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
