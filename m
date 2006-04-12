From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to make a git-format patch
Date: Wed, 12 Apr 2006 13:12:44 +0200
Organization: At home
Message-ID: <e1inb0$o7n$1@sea.gmane.org>
References: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Apr 12 13:13:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTdHY-0006uK-5N
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 13:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDLLNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 12 Apr 2006 07:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDLLNA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 07:13:00 -0400
Received: from main.gmane.org ([80.91.229.2]:24709 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932154AbWDLLM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 07:12:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FTdHE-0006rI-Vs
	for git@vger.kernel.org; Wed, 12 Apr 2006 13:12:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 13:12:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Apr 2006 13:12:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18629>

Aubrey wrote:

> But I saw most of the git-format patches have a header in the front o=
f
> the patch file, like:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0*=A0Added=A0xxxxxx=A0support
>=20
> Signed-off-by: xxxxxxxx <xxxxxxx@email.com>
> ---
>=20
> =A0net/packet/Kconfig=A0|=A0=A0=A011=A0++++++++++-
> =A01=A0files=A0changed,=A010=A0insertions(+),=A01=A0deletions(-)
>=20
> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
> index 34ff93f..959c272 100644
> --- a/net/packet/Kconfig
> +++ b/net/packet/Kconfig
>=20
> ----snip----
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Just want to know how this kind of patch format generated.
> Thanks for any hints.

Perhaps git-format-patch(1) is what you want?

--=20
Jakub Narebski
Warsaw, Poland
