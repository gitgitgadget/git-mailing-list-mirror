From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/19] mingw: try to delete target directory before
 renaming
Date: Mon, 25 Jan 2016 07:59:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601250753470.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <d75b0dc0b76beefee9e705555ca4f2fa4f4b96ce.1453650173.git.johannes.schindelin@gmx.de> <4C2ED807DD184A168C87221809034B70@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-133259012-1453705191=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	nalla <nalla@hamal.uberspace.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 08:00:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNb8A-0004Cw-2l
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 08:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcAYHAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 02:00:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:58516 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbcAYG77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 01:59:59 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LqE5k-1ZsgA31Hkm-00djob; Mon, 25 Jan 2016 07:59:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <4C2ED807DD184A168C87221809034B70@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0vI+jQ9uUYjCNI2vZuWo7KPYfjitsBIzDdzO26Ou5AM1ZRhv+zg
 QlkCsMjsucrizgGrXVOFpGZqhblrloT041sQNDOnHmjF9gMKjjGAfgKICKW4eBSSbSq4Fvy
 Xx+/IWIJM9FUsrvVQPBil2TAWWDBD2wp30071a7xFu3n5N2AjrLDARhQ8dzHXeJxvBS8Prp
 Ah1J+lHA1CVoqtl+VeOzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vkHNXVJWB1w=:BuUMV/qkvskLSAiNoTEqf7
 /ziq2H+inS+y2+un8WzF3ZYTcRscbxEvZrbUoIser3w1mOt7pBQhqclVaULMOAEDAsumcg0vZ
 bsQWoz/V87+2Tr6Jq1cYiAzcq8fFDxrN/qQ4qjVKGNha2oJqZhSBhLSrmoI1GaR33njsw6VzZ
 0Wx/YaLoTCRbFez7pqiFkvJZrf91fDjv6r/Oh/wMrTdps+N92LvSVwZPA/jCvfZpHTw7OucGY
 5LP+yqckrkTdWOMUEX6NQmutCBSWJ5+byyye7+roL7Ha/XHoIGsGnFuRbttg5tQrSJdNX0Kvo
 +efbKTaqLitY0vwzS8Gb08qsDVLZjtyEXxt1w9hbfEbolg6csqPhdhHbF0tLw/G0goBi1dGU1
 BPDH/psYbfmhEMWetXq1oaHhc36kzDR6hVbUWVX3XWbCohsxbpGLxwy76Zr8axjbh3GyxCmXi
 58L7SDqK2aBuVbwNmZNgiKzr9f+Sc1UTlu1gL+m162k2NdBeGM5hstzCv3nhNtdL1cj6fWits
 +02tLufEPeD3rescoU5Wbg7lqqt57WKw6/WH9oadk0Rrj2UK7N/ntb7yPc3KQevUzvdC7bQjG
 4ODPokAq6RWAl4FkDAL2fKKamc5M9fMqYrl23Prqv5w+KqHbA2XQEHFIHtIlnbo5QQ4HvffAM
 XVwTeUPotlios+/Oyq8lsUr0w4R8RFa8ecvxbpjCvl4U73hxfGjSQbaFpPku8kGh/f4k0wrgf
 unZ9flv1GCCBpMSqavgeiC7h5gLLTMmPL6lBgdWDgXMHyi6nGFmhe4B9/yN1kHQNNXG+RIJ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284720>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-133259012-1453705191=:2964
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Philip,

On Sun, 24 Jan 2016, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> >From: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>
>=20
> Is this Nalla's preferred email, or just a carry over from cautions of th=
e
> Github interface?

Neither. It is from the author field as recorded in the commit that I
merged originally: https://github.com/dscho/git/pull/8

Ciao,
Dscho
--8323329-133259012-1453705191=:2964--
