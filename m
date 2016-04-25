From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: How to have EOL=LF and keep binary files auto-detection?
Date: Mon, 25 Apr 2016 18:46:02 +0200
Message-ID: <4501b117-09e9-d24c-e209-bda28059765a@web.de>
References: <3670335C-4938-4DCD-9B1D-6B4737CBE6C2@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0KfQsNGI0L3QuNC60L7Qsg==?= 
	<Nikolay.Chashnikov@jetbrains.com>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:46:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujeL-00063y-PC
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbcDYQqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:46:13 -0400
Received: from mout.web.de ([212.227.17.12]:51808 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932696AbcDYQqN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:46:13 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MgO8g-1b6Esw1POg-00NkGx; Mon, 25 Apr 2016 18:46:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <3670335C-4938-4DCD-9B1D-6B4737CBE6C2@jetbrains.com>
X-Provags-ID: V03:K0:CAbhWP3GjN3qG9u06XGfZFo4/+swFGUYhyfJY3xtkq2pd+VQ65X
 /MIg3C21MCAedD6jYdi7lWRRrC7n5KXYxQpcauxu4NVTrnecx4n4FsX0ytPBe24Bxo9S8kD
 MIhz4NPPV4RV04EFQsWsQhp6n/hjIEVymgSO7efeDRWpld1u/kwYP21q4VRHkPTjhaJfn1P
 px91P+emDUs2ua3Ygk8lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BHr24/B1qVE=:3EkgU5hlxImn1VbjjQ+PCJ
 GJA+rKzUVXCZjaUsctwL6RX/8D9xmHu1LQAaMx7foT8taJ0euEt/0Ef31jNcRdozBEWoE1t2I
 o1yKzaQc61uA/S5qO7wcxYd0qGvpKvPtcYIs3ko0GFtmVUF1znBkpGgD9qL3kVTY1iWaPAlv6
 hQwlM2ge6UxlXB9NXGK7s4083CQgFb47sQRpf7P+Pan1A1lSsXZnM/tT1fuCs+i8wPLe1SiFQ
 JVYEHWOC/BhFavvhBR3UHxJ9l6Clf25HYbWA76dZ5ji+w0970FQ/Qx8SEejpx3c7Yh17CQTWr
 dZfs+wZcprKq5HtVWIJU6hXKN+L8SV01QoN3SVh5QS/GH8JwVL06fd7XgIEKO+uZeVwyLxrIJ
 Pb+ZOYR6g+KRproxGYyqIBEaYjjlYMCbz0cYZboWvaWdTE7I3SG8BQ26lrpzcNetqUsGaxxqk
 yyCuaSHn6AgUtHFdlnExAMTnCO0IC5NUCFxZwsrd2dPVBIl7jwrohQrStjRVqK1J7yw8dV7aB
 dZxgj0zChT5hOmwN9KGk7RY7hPCARuDkysTOxBWrm/BbyVkzqjKJIvtMJzXoW2bikatC0BQ6a
 NyjcqohNOGcpua9k6e2l6p0RfxD4L3hT6+mfBE/4KxafZPoQOiUmLgsAEi6ayM1PMA/Xyvm0h
 rHHlgKsA/lAU6jdPg4gzeMDdwHwv+E/5lFxxMj2fYSX2sq7V9DPjgvF9LlvHT+a/uvoBkHlt8
 W2RS1f2x9GsB7YJLGFcwb+d6fLV8h76vZB+G2ihheHCFo3kOifA2CDr0cmmxq/p+438caMcQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292511>

On 25.04.16 16:11, Kirill Likhodedov wrote:
> Hi,=20
>=20
> I wonder if it is possible both to have LFs in all and only text file=
s in working trees, and keep Git=E2=80=99s binary files auto-detection?
>=20
> To be more precise:
> * we want all text files to be checked out in LF;=20
> * we don=E2=80=99t want force people to set =E2=80=9Ccore.autocrlf=E2=
=80=9D to false, preferring to keep this configuration in .gitattribute=
s;=20
> * we obviously don=E2=80=99t want binary files to be touched by eol-n=
ormalization;=20
> * we also don=E2=80=99t want to declare all possible patterns of bina=
ry files - Git is good enough in detecting them automatically.
>=20
> However, I=E2=80=99ve found no way to do so.
>=20
> If I declare `* eol=3Dlf` in .gitattributes, it makes Git treat all f=
iles as text and thus convert CRLF to LF even in binary files. It is co=
nsistent with man, but a bit surprising to have e.g. a zip or png file =
modified in this way.
>=20
> One could expect `* text=3Dauto eol=3Dlf` to work the way we want, bu=
t unfortunately it doesn=E2=80=99t work either: =E2=80=9Ceol=3Dlf=E2=80=
=9D forces =E2=80=9Ctext=E2=80=9D on all files.
>=20
> Thanks a lot for your help!
> -- Kirill.

The short answer: Git doesn't currently do that.
The closest you can get, is to use
echo "* text=3Dauto" >.gitattributes
and
git config core.eol lf
git config core.autocrlf false.

The longer answer is, that I am working on a patch to allow just
the combination of "* text=3Dauto eol=3Dlf" to work as you want it.

Which platform do you use ?
And (out of curiosity, why do you want text files with LF ?)

If you are willing to compile and install Git yourself,
you can use the branch here:
https://github.com/tboegi/git/commits/160421_0706_reliable_t0027_allow_=
TC_combined_ident_CRLF_v7

=46eedback is welcome, if it works as expected.
