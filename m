From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Thu, 11 Dec 2008 10:51:15 -0600
Message-ID: <200812111051.20322.bss03@volumehost.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812101624.11255.bss03@volumehost.net> <alpine.DEB.1.00.0812111015140.18321@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15561858.essnumZemF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 11 17:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAomo-0005Pg-G5
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 17:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbYLKQvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 11:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbYLKQvr
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 11:51:47 -0500
Received: from ispmxmta09-srv.windstream.net ([166.102.165.170]:43241 "EHLO
	ispmxmta09-srv.windstream.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757889AbYLKQvp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 11:51:45 -0500
Received: from ispmxaamta05-gx.windstream.net ([166.102.154.15])
          by ispmxmta09-srv.windstream.net with ESMTP
          id <20081211165143.BJIG4904.ispmxmta09-srv.windstream.net@ispmxaamta05-gx.windstream.net>
          for <git@vger.kernel.org>; Thu, 11 Dec 2008 10:51:43 -0600
Received: from [192.168.1.123] (really [166.102.154.15])
          by ispmxaamta05-gx.windstream.net with ESMTP
          id <20081211165143.UFMB7110.ispmxaamta05-gx.windstream.net@[192.168.1.123]>;
          Thu, 11 Dec 2008 10:51:43 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0812111015140.18321@eeepc-johanness>
X-Cloudmark-Analysis: v=1.0 c=1 a=4x8eZqvhE5cA:10 a=cCwArZ2WySYA:10 a=imw7DGXsOz1VfKdyG2U9cg==:17 a=nEQGfrJnAAAA:8 a=3kvLEAULb9K0Zz103k4A:9 a=wq3KybP0ZUHnjLq7uGpvEL101P8A:4 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=B1tY8eBAA6NSCYE5N0EA:9 a=PcMlrSnLh_kzxCO9HCW7CDrq-gwA:4 a=rPt6xJ-oxjAA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102804>

--nextPart15561858.essnumZemF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 11 03:15:47 you wrote:
>On Wed, 10 Dec 2008, Boyd Stephen Smith Jr. wrote:
>> On Wednesday 2008 December 10 13:46:50 you wrote:
>> >On Mittwoch, 10. Dezember 2008, Tim Olsen wrote:
>> >> It appears that when outputting a fatal error, git-show will choose
>> >> stdout over stderr if stdout is a terminal and stderr is not.
>> >
>> >This is by design.
>>
>> Then it is poor design. :P j/k
>
>Read up on the reasoning before trolling, will ya?  It's all in the Git
>history.

Seeing how I'm new, and this message indicated I had screwed up, I starting=
=20
going through the 'git log' looking for a commit message that either=20
documented this behavior, or indicated the commit had documented this=20
behavior.

Initially, I was looking for 'stdout' or 'stderr', and found many unrelated=
=20
commits.  I then figured it was part of the PAGER support, and began=20
searching for that.  I did find an indication of why stdout and stderr are=
=20
both redirected to the PAGER's stdin -- but that makes sense to me; I wasn'=
t=20
questioning it.  At least not too much -- but when the user indicates stder=
r=20
and stdout should go to different locations, shouldn't they?

I was mainly questioning using a pager AT ALL when the git command is used =
in=20
a non-interactive environment, and how git detects an interactive invocatio=
n. =20
I feel this should be done the same way a (POSIX standard) shell detects=20
interactivity, and that in a non-interactive environment git should not=20
default to using PAGER.

Now, I certainly could have missed the commit message / commit with=20
rationale / documentation.  'git log' output is a long document, and I mayb=
e=20
using the wrong keywords for my search.  It also is not all the documentati=
on=20
that is out there.  I'm not afraid to RTFM; but I'm not having much luck=20
finding the right parts to R.

=46inally, I didn't mean to offend.  I was hoping the smiley (":P") and "j/=
k"=20
would indicate that a was only half serious and know that I don't have the=
=20
benefit of following the project closely for very long.  I'm appreciative o=
f=20
the hard work that goes into git and don't mean to belittle that effort.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart15561858.essnumZemF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklBRQcACgkQdNbfk+86fC1XBQCfYqXSt6gNBuZCgLYaEPnvhPqB
g/QAni28guPkUzqguCFYVO+vhdP3u+je
=imPt
-----END PGP SIGNATURE-----

--nextPart15561858.essnumZemF--
