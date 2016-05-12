From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t5551 hangs ?
Date: Thu, 12 May 2016 08:21:10 +0200
Message-ID: <c0f2ae7b-0a67-af75-86ca-258a58b053bd@web.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
 <20160511173130.GA29731@sigill.intra.peff.net>
 <5f285a5f-f66a-ed35-ecf9-0fece19ee5ca@web.de>
 <20160512031628.GA2741@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 12 08:21:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0k02-0007dn-0I
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 08:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcELGV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 02:21:26 -0400
Received: from mout.web.de ([212.227.17.12]:64585 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbcELGVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 02:21:25 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lcxxc-1bRF3g1gCO-00iBSi; Thu, 12 May 2016 08:21:12
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <20160512031628.GA2741@sigill.intra.peff.net>
X-Provags-ID: V03:K0:UXUMtx2r9jnG1cebXisEUziipS60acDWX1EITyD2qr8tyYO/Tqs
 QGW/XAB+Ve00Sd4eh9jALItqmBPClnc9nC9WuMHJT9liTlyj6HU7hWkB6oWETXmX1x7VbmN
 wl7uKOXGho6/gYsfez+2+3d8oIzplsBJdmlCyUkXVam9h3+siem8yqqAWddzTT12cEmLlab
 RS8Uc/Xo0UntPM5V9FNdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:56ETvxeTCII=:E392zLyYyBeFO3XcWGF8wX
 39Z1KEeJG0Og6ON7CB25ZtULOmgCjdPCN2pwaWuJGHNMyIw/mMbUs0nkecTINpvMqdcN8EpK9
 UkEigSMBj0xdUJ2uB8cu1JfoI8fYEw0rF5StAIZAtQ9+NDzOOadxzC/zb4ofCgtPOHimwlGrO
 j9fs0FvAmqC91aePM1YfAUuZDoYCICU2QzFOlesbZ14/Knb73wDqhpUALMO5/58XGGL2FIxOD
 wFJPEVJcyBO/NN7Nrr8nHOEprkSWNRUvUgSJSUPesSJnfnTk6S1yi+od2JjVIzDMqmZq6M4FY
 jVML5vhayfnXNsaUolliTOsi11gupWxZ5ruXPOJ3VTetXAyMlDQS+9JMZcLsYYNC+wZFPrT6n
 hhvz5zCxBKCjRw4gcPR326Xy5HrnkFUduJYqZv3C1xYbOztKpaDePrNJKeR/piJ/oitOc26IY
 +Muq0TjbgIYS3RqPj/GypkE19/EC1jwIEXGznUAZDSSdWg0DqnvpHyQ3iBKYTasZa6JZ/XWU3
 gdeNbEkmk/fDUM2w2Ajlg63wuLXLiSOgL5fI2sVY4jWBedFL0YDKFpnLkV1sdfCqFeezUcsNo
 TRSB9jyBHdo96tbYNgTY92kSpVIIwfIBO/9gY42mtDoeZwX55I6xMo9a6kugOocORXJp5KNR4
 ckQXvZkfvXfqwxvL9QhsFI+tCUx7vNeqVNV8FV4GlML2LaRdALRM7vFEwVRTL6bgIKL4aplIS
 EUwoFtZ/YCN/tF+T1CZ1RgUEcKe9Oih4iG4OMaz5hwXbxbq+cqsLtk9BbyOeNflQaV/FcE7/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294393>

On 12.05.16 05:16, Jeff King wrote:
> On Wed, May 11, 2016 at 10:03:45PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>>> If you are, can you confirm that it's actually hanging, and not jus=
t
>>> slow? On my system, test 26 takes about a minute to run (which is w=
hy we
>>> don't do it by default).
>> Nearly sure. After 10 minutes, the test was still running.
>>
>> Yesterday another machine was running even longer.
>>
>> Any tips, how to debug, are welcome.
>=20
> Try running with "-x" to see what the test is doing. It will probably=
 be
> in:
>=20
>    + git -C too-many-refs fetch -q --tags
>=20
> after a while. Check "ps" to see if you have a fetch-pack sub-process
> running. It should be writing "have" lines and reading lots of ACK
> lines, which you can check via strace.
>=20
> If it's blocked on read() or write(), then it's probably some kind of
> I/O deadlock.
>=20
> -Peff

This is the last log that I see:
---------------------------------------------------------------------
pack_report: getpagesize()            =3D       4096
pack_report: core.packedGitWindowSize =3D 1073741824
pack_report: core.packedGitLimit      =3D 8589934592
pack_report: pack_used_ctr            =3D      96001
pack_report: pack_mmap_calls          =3D      48002
pack_report: pack_open_windows        =3D          2 /          2
pack_report: pack_mapped              =3D    6605494 /    6605494
---------------------------------------------------------------------

+++ perl -e 'print "bla" x 30'
+++ command /usr/bin/perl -e 'print "bla" x 30'
+++ /usr/bin/perl -e 'print "bla" x 30'
++ tag=3Dblablablablablablablablablablablablablablablablablablablablabl=
ablablablablablablablablabla
++ sed -e 's|^:\([^ ]*\) \(.*\)$|\2 refs/tags/blablablablablablablablab=
lablablablablablablablablablablablablablablablablablablablablabla-\1|'
++ git -C too-many-refs fetch -q --tags

And this may be the processes :
(Not sure, probaly need to reboot & clean ?)
/bin/sh ./t5551-http-fetch-smart.sh -x
73459 ttys010    0:21.45 /Users/tb/projects/git/git.pu/git -C too-many-=
refs fetch -q --tags
73460 ttys010    0:00.40 git-remote-http origin http://127.0.0.1:5551/s=
mart/repo.git

 ps | grep fetch
73540 ttys006    0:00.00 grep fetch
73025 ttys010    0:00.14 /bin/sh ./t5551-http-fetch-smart.sh -x
73459 ttys010    3:40.70 /Users/tb/projects/git/git.pu/git -C too-many-=
refs fetch -q --tags


Beside that, reverting the last 2 commits on 5551 doesn't seem to help:
 Revert "t5551: make the test for extra HTTP headers more robust"
 Revert "submodule: ensure that -c http.extraheader is heeded"
