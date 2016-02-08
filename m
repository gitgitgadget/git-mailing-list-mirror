From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Mon, 8 Feb 2016 23:11:37 +0100
Message-ID: <56B91299.9060001@redhat.com>
References: <56B32BDA.4010909@redhat.com>
 <xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com> <56B85ECE.4020607@redhat.com>
 <xmqqfux39kmz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0q7rNhGTMfPPXjCdolbKwgGp5CpHJd6Ok"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:11:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSu2E-0001Fk-KU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbcBHWLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:11:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754115AbcBHWLr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:11:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id BB14E804EE;
	Mon,  8 Feb 2016 22:11:47 +0000 (UTC)
Received: from [10.34.4.171] (unused-4-171.brq.redhat.com [10.34.4.171])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u18MBjAI030506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Feb 2016 17:11:46 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqfux39kmz.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285813>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0q7rNhGTMfPPXjCdolbKwgGp5CpHJd6Ok
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 8.2.2016 18:28, Junio C Hamano wrote:
> Petr Stodulka <pstodulk@redhat.com> writes:
>=20
>> On 4.2.2016 20:15, Junio C Hamano wrote:
>>> Petr Stodulka <pstodulk@redhat.com> writes:
>>>
>>>> I found that license file COPYING is different as compared with
>>>> http://www.gnu.org/licenses/gpl-2.0.txt If I pass over with
>>>> Linus's preamble, change is only about whitespaces - tabs
>>>> vs. space.  Probably it's minor non-essential change, but some
>>>> projects do this change, so rather I ask about that.
>>>
>>> Interesting.  I cannot quite connect "some projects do this change"
>>> and "so rather I ask".  Are you asking why this project changed it?
>>
>> Nope. I apologize for my czenglish. It means: From my colleagues I hea=
r,
>> that some projects had same differences (tabs vs. spaces) in their cop=
y
>> of the license file and they make it later equivalent with the one in
>> gnu.org.
>=20
> I'd guess that these projects (among which Linux kernel still has
> these indentation the same as the copy we have) and we independently
> obtained the COPYING file from GNU in some past, and back then the
> copy at GNU was indented that way--which later was changed.
>=20
> The Wayback Machine supports this theory.
>=20
> https://web.archive.org/web/20070713225446/http://www.gnu.org/licenses/=
gpl-2.0.txt
>=20
> i.e. the FSF copy back in 2007-07 indented these section headers
> with tabs, so those projects that obtained this copy would have
> their sections indented with tabs.
>=20
> At 703601d6 (Update COPYING with GPLv2 with new FSF address,
> 2010-01-15), we did a fresh update directly from the URL you cited
> above to primarily replace the addresses of the FSF office.
>=20
> https://web.archive.org/web/20100105100239/http://www.gnu.org/licenses/=
gpl-2.0.txt
>=20
> matches what we use (minus Linus's preamble, of course).
>=20
> The file before that change was what Linus copied from Linux kernel
> project.  The kernel project did their equivalent change at their
> b3358a11 ([PATCH] update FSF address in COPYING, 2005-09-10), and
> the log message says http://www.gnu.org/licenses/gpl.txt was used.
>=20
> The Wayback Machine agrees.
>=20
> https://web.archive.org/web/20050901115237/http://www.gnu.org/licenses/=
gpl.txt
>=20
> i.e. the FSF copy back in 2005-09 matches what the kernel uses
> (again, minus Linus's preamble).

I have expected that license was copied correctly in the past from gnu.or=
g,
when same differences are in various projects. I just point out on anothe=
r change.

Thank You for tip about web.archive.org - I really don't know about that =
web
and it can be useful.

>=20
>> So I ask rather here / point out this difference, if you know
>> about that or you want to have same one.
>=20
> So the answers are:
>=20
>  - No, I didn't personally know about the differences, and I suspect
>    nobody particularly cared.
>=20
>  - Not really, unless the difference has more substance.  For an
>    example of an update with substance, the update we did in 2010
>    had not just the FSF address change but also updated the fully
>    spelled name of LGPL from Library to Lesser.

Thank You for reponse.

>=20
> You may want to bug the kernel folks to update their copy; they
> still spell it as Library General Public License.
>=20

Everyone can do that. I believe that someone report it already or at leas=
t
constult it. I write about this here because I should do that. When You
know about this difference in license in kernel, I believe that they know=

it too and they decide it is ok.

Regards,
Petr


--0q7rNhGTMfPPXjCdolbKwgGp5CpHJd6Ok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuRKZAAoJEPiGu5hNgNqPxV0QAKUw86LbnMdqo/vScEbzR9Ds
PfUIXPgh95xnO5Hc58NrDm8iEMnzXv+fmJcAwikfuL/WdULaSY+ENCt6HSPkZTrz
Y5L/X8JgV2zpQuj9Cvl4kZEx0pHkm8aqUqQz+wFCE5UxQZDoYkUcIWETvzMmELLW
wgxw7UUjeL4V2wk27Flg1CAXjHD3+6aYFyH/m4t7R/jGifHYaY1ViWU0dDlV3I4Z
LkECKaGustxK27b/+LOUqhikxt42MESWvP1FY7RnNYuwyVLKyzFv53trJlAKlmpx
DPVABLP/0GeljxIy2rtuRqviwiiazbQVFurU4Ymw173ZLZ6akJdF4LagSv2Awntp
42gS21AnLXEuPWaSwydgmNrdy4id7rzaBU+tpFqrGil5Z8KHusQG5+xPFqWiqmFj
iwjcLI2Hmm6Fq9RP/quCS17h7liXOHkYx1SSYQr1rrat6V5dS4+N7NuVNRuOjO1b
XzBU2rcIcva4ok8iPpEia6aba7++nFUC8hRCr0y3+y8hoZOvuRYPSMes/F0ChotO
JOeGQ4XqGgIBf9N2NLeBCzWM+zkJBamyR2RSqf6kc3HjXNQa6h7Ze/eaUBfNSScx
47KodDUXkV0BEQ7+M4GWpBEAk7zQ4nHmrIv5Obhyh4OXdWMfFD6CbGwXEib1gxKC
PVCa4SwAVJf9B/+bEEqm
=BQ7L
-----END PGP SIGNATURE-----

--0q7rNhGTMfPPXjCdolbKwgGp5CpHJd6Ok--
