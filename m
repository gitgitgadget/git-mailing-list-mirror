From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 16:46:51 +0000
Message-ID: <56967F7B.8080407@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
 <5695E4FB.2060705@web.de> <alpine.DEB.2.20.1601131022410.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOZe-0000sW-2y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbcAMQrA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2016 11:47:00 -0500
Received: from avasout04.plus.net ([212.159.14.19]:36759 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbcAMQq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:46:59 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id 5Umx1s0024mu3xa01UmyV5; Wed, 13 Jan 2016 16:46:58 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=jmBSgutfuu9kwsSDzq0A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <alpine.DEB.2.20.1601131022410.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283932>



On 13/01/16 09:27, Johannes Schindelin wrote:
> Hi Torsten,
>=20
> On Wed, 13 Jan 2016, Torsten B=F6gershausen wrote:
>=20
>> On 01/12/2016 08:57 AM, Johannes Schindelin wrote:
>>
>>> +static struct test_data basename_data[] =3D {
>>> +	/* --- POSIX type paths --- */
>>> +	{ NULL,              "."    },
>>> +	{ "",                "."    },
>>> +	{ ".",               "."    },
>>> +	{ "..",              ".."   },
>>> +	{ "/",               "/"    },
>>> +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
>> Why the !defined(NO_LIBGEN_H)
>>
>> Shouldn't CYGWIN always behave the same ?
>=20
> One would assume... Alas, it does not.

Err, ... yes it does! :-P

>=20
> I inherited the code in question and wondered the same. I opted for
> keeping the code as a documentation of the differing behavior.

Exactly.

ATB,
Ramsay Jones
