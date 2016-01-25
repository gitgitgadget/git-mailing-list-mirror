From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] merge-file: let conflict markers match end-of-line
 style of the context
Date: Mon, 25 Jan 2016 07:53:32 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601250749580.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <cover.1453632296.git.johannes.schindelin@gmx.de> <d71c7abddd4cba85b967f9fe1d33c7c843176ca2.1453632296.git.johannes.schindelin@gmx.de> <56A4FB64.4010609@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1092327854-1453704802=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 07:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNb23-0001RY-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 07:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbcAYGxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 01:53:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:55307 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbcAYGxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 01:53:42 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MX16a-1aZfpL1wIu-00VzA5; Mon, 25 Jan 2016 07:53:35
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A4FB64.4010609@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-ID: <alpine.DEB.2.20.1601250753310.2964@virtualbox>
X-Provags-ID: V03:K0:gJQnUosE8+3WrhH5iOfAxkCRtHaQ6cmv4VSVH57nmWTH2avER2x
 XWrFd8svXPDxYT2ip2cL71+S35OIArAmRsEPV76k2ivRkBPAC82K865C7u6hR1cUV+gu75D
 WMeOXaKrhSAIqhtw+km313oI71Ku9hx67YQTO6ZAbKZKEKbyClVecFOhUI+tMErH59PCjOZ
 ntFENBj+/r2aOjF3VNaMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ogZExjlvak8=:UnfbgVu23mIJZmzL1Ac0qg
 XYmplSu8mDIz/k4NdT872wkO0letmZXWgjJQmkOdvGEsY1lO0tAISRoMrgt3ZyLh53tw/PzYU
 HwCTaRa4o3caFESlienagCko52uE8Zc8aKIAk0krvczyK2wGh52FWr+jNb2VUXV/SRovuc9vC
 AD/oBi0VTM29LqXF3VzQGOOE5eSMewnFHG9y2O4Y6gmtjeXYdr2djyqoJJ1o36L6IBgGpnX5x
 l+5m05n9pnMrSGYIj1Upt5RPaEr4ZuwSotFmq2Hos8RQLfk/l0DlG1H4ix6lh3HEvIdaA023t
 Yfp/5DWUe/OBsFbUFJxMAsQIKCcg+qK1ynSRZKtRNRyHTfm0rIqVgGV8Cy1TCsY24qDk4Rcza
 1FPjBynsAOfV2XebmMPievI4rWLNd1If0tIw83X8LlvFfek7Wy4R96QlPoYHvz/9O8gthemC4
 MXrK8QRP9N0OD41X7J1CddtzGOPwHZ+R21YkoapBDQJ8/tc75qK0lBTbUWHeSROuSe1oG4Dbo
 VKnMAi6KkebGgxA1owvzvliLIdxDA97Q1q53b8fePGl1KZe4ql88sLdkVHlDAcV7Hp4u9RSgn
 7azo210dhkJwsBrEEAYSo6ir1bx91zomzO8CeNRDR6VbDmv970ZemgCnOt2rS9o6s4iwpgIX5
 DyfpQbwdqpYYcQ8OZ0DsBSglBQvYIZLqWPC8OtZNdMwWmsM2nf7Dp7gZvvNmEVIFnvN17D9VU
 4VVrRbYim3OnTirr/J3mqTLXcmTVQ+cyQpyMUpvK3pRU5zMQZ1VfFwaig3HVXbpiXovzwZ7i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284719>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1092327854-1453704802=:2964
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1601250753311.2964@virtualbox>

Hi Torsten,

On Sun, 24 Jan 2016, Torsten B=F6gershausen wrote:

> On 24.01.16 11:48, Johannes Schindelin wrote:
> (I had the same reasoning about the CRLF in the working tree:
> We don't need to look at core.autocrlf/attributes, so Ack from me)
>=20
> > +test_expect_success 'conflict markers match existing line endings' '
> > +=09append_cr <nolf-orig.txt >crlf-orig.txt &&
> > +=09append_cr <nolf-diff1.txt >crlf-diff1.txt &&
> > +=09append_cr <nolf-diff2.txt >crlf-diff2.txt &&
> > +=09test_must_fail git -c core.eol=3Dcrlf merge-file -p \
> > +=09=09crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
> > +=09test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) =3D 3 &&
> > +=09test_must_fail git -c core.eol=3Dcrlf merge-file -p \
> > +=09=09nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
> > +=09test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) =3D 0
> > +'
> > +
>=20
> Minor remark:
>=20
> Ramsay suggested a test that doesn't use grep or wc and looks like this:
>=20
> test_expect_success 'conflict markers contain CRLF when core.eol=3Dcrlf' =
'
>   test_must_fail git -c core.eol=3Dcrlf merge-file -p \
>     nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
>   tr "\015" Q <output.txt | sed -n "/^[<=3D>|].*Q$/p" >out.txt &&
>   cat >expect.txt <<-\EOF &&
>   <<<<<<< nolf-diff1.txtQ
>   ||||||| nolf-orig.txtQ
>   =3D=3D=3D=3D=3D=3D=3DQ
>   >>>>>>> nolf-diff2.txtQ
>   EOF
>   test_cmp expect.txt out.txt
> '

Probably he wrapped it at less than 192 columns per row, though ;-)

Seriously again, this longer version might test more, but it definitely
also tests more than what I actually want to test: I am simply interested
to verify that the conflict markers end in CR/LF when appropriate. Read: I
am uncertain that I want to spend the additional lines on testing more
than actually necessary.

Ciao,
Dscho
--8323329-1092327854-1453704802=:2964--
