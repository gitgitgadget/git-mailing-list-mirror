From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Tue, 26 Jan 2016 09:54:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260951030.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <cover.1453632296.git.johannes.schindelin@gmx.de> <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de> <56A4FB64.4010609@web.de> <alpine.DEB.2.20.1601250749580.2964@virtualbox>
 <56A67B6F.60300@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-325737745-1453798467=:2964"
Cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 09:54:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNzOe-0005HT-O2
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 09:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933848AbcAZIym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 03:54:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:58835 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932511AbcAZIyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 03:54:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Las1k-1ZiIvb1HlA-00kOUu; Tue, 26 Jan 2016 09:54:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A67B6F.60300@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cieJw19i+iDOM3f3TBOuWzbU7OqQUJRPuvW3ya5cmdLhZeVT06X
 Ym4sAk5HC6nomtj2A1C3CuaKOc0bCl1QTOKrt+uxPwTgT5+fTpDVXK+x2FY3ghBWFuTvRjy
 zKSYaIAme6QTHMwxBzWQ39jufkqvoTREATWQfCdAlCkh2vMcXK4EEwSrz1CRfdnU0Jl5YLA
 qrI+9hg6zAZrTG1CTrgJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LKuYMf7Oyd4=:xb1J5koB+383KUv+TjAE0+
 SAM1GI5wamk8u7xnk3i8grmVQnuQHaITCoBLE3tJSrrkpLJlVqWQ02Aoh1ZPuESNeMWfjoyvh
 KstvMHRPUMfAPhgj/Qs2YuXsu2UKGkNnVHg2rsxVPp71lFKNpbZBRHfLelWsCtSM2fvb2JIn4
 QmV0Go9pz4np4Ho7ypoSVf8pvUTa0Lw8NTv2DYYlhz9qZYwX03qBoH3zR9D+ybmE0D6UhFuSJ
 Yb+Jwx6g/lWnydaVw9qDFswYiWZxD3+EpfqvPysYFlw1MxwVJEjkLl2bnzlJ3Sst3KuMFRT08
 AbHDwwtjmqy8SyrYgGcbgW7YknnL6z/ITNZc+hbeybOMZgUHTiqzXkYDP/MmscQy3VvlqQnnb
 wzCi/M8KV2YwXwJoLcBfkXp5qtC+u7fFac4EU74NcbvW4AVPA+SLofJV+d73ANpdQYw7aIMMt
 K4tpBc08ag3McumoX8/eDxv073c7kt6M9j2MRaE+Q4mzBD+MUlUxy2n7ipMcEnxQMhjVLzEi/
 q96uRxirsTOR+3PN3vlyVm+bC7vuilz3VG+4JGjHKWCfX7fBZy3V4h8rklQAHjIwPmxQqbaII
 hTynKw4RfONxm0TuirZ/ssOwxRWlFoeNQjE7nk0eKa7BpJHtG6uLMomxhD85vNjaiUoRY9gRG
 J5sZxGOkjmnilB+NsRNyGcFbO9cCg0J8WEQtoXLM+7GWNKzrTYJyh4bPeZqhoyPFcjWkRvmhW
 5JrOkvhrEUEe2KPEHuL95uflMb6DNEL+27ynXwgpw5aQ1ndiCIXW4cwOqu6yOrhBaQEsjsBF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284788>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-325737745-1453798467=:2964
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ramsay,

On Mon, 25 Jan 2016, Ramsay Jones wrote:

> On 25/01/16 06:53, Johannes Schindelin wrote:
> >=20
> > On Sun, 24 Jan 2016, Torsten B=F6gershausen wrote:
> >=20
> >> On 24.01.16 11:48, Johannes Schindelin wrote:
> >> (I had the same reasoning about the CRLF in the working tree:
> >> We don't need to look at core.autocrlf/attributes, so Ack from me)
> >>
> >>> +test_expect_success 'conflict markers match existing line endings' '
> >>> +=09append_cr <nolf-orig.txt >crlf-orig.txt &&
> >>> +=09append_cr <nolf-diff1.txt >crlf-diff1.txt &&
> >>> +=09append_cr <nolf-diff2.txt >crlf-diff2.txt &&
> >>> +=09test_must_fail git -c core.eol=3Dcrlf merge-file -p \
> >>> +=09=09crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
> >>> +=09test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) =3D 3 &&
> >>> +=09test_must_fail git -c core.eol=3Dcrlf merge-file -p \
> >>> +=09=09nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
> >>> +=09test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) =3D 0
> >>> +'
> >>> +
> >>
> >> Minor remark:
> >>
> >> Ramsay suggested a test that doesn't use grep or wc and looks like thi=
s:
> >>
> >> test_expect_success 'conflict markers contain CRLF when core.eol=3Dcrl=
f' '
> >>   test_must_fail git -c core.eol=3Dcrlf merge-file -p \
> >>     nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> >>   tr "\015" Q <output.txt | sed -n "/^[<=3D>|].*Q$/p" >out.txt &&
> >>   cat >expect.txt <<-\EOF &&
> >>   <<<<<<< nolf-diff1.txtQ
> >>   ||||||| nolf-orig.txtQ
> >>   =3D=3D=3D=3D=3D=3D=3DQ
> >>   >>>>>>> nolf-diff2.txtQ
> >>   EOF
> >>   test_cmp expect.txt out.txt
> >> '
> >=20
> > Probably he wrapped it at less than 192 columns per row, though ;-)
> >=20
> ;-)
> > Seriously again, this longer version might test more, but it definitely
> > also tests more than what I actually want to test: I am simply interest=
ed
> > to verify that the conflict markers end in CR/LF when appropriate.
>=20
> But you are only testing 3/4 conflict markers end in CR/LF. :-D

The fact that ||| markers are present is the fault of previous test cases.
I tried to make a point of *not* relying on such a side effect (so as to
debug failures quicker by commenting out all previous test cases).

So the fact that I am testing only 3 of the 4 conflict markers is very
much by design.

> > Read: I am uncertain that I want to spend the additional lines on
> > testing more than actually necessary.
>=20
> If the here doc is too verbose for you, how about something like this
> (totally untested):
>=20
>     test $(tr "\015" Q <crlf.txt | grep "^[<=3D>|].*Q$" | wc -l) -eq 4
>=20
> instead?

Hmm. I do not see the benefit over grepping for `txtQ$` it's essentially
the same.

> HTH

How the hell?

> ATB,
> Ramsay Jones

Authorization to Buy?

Ciao,
Dscho
--8323329-325737745-1453798467=:2964--
