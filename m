From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 10:27:36 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601131022410.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de> <5695E4FB.2060705@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1593712626-1452677258=:2964"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 10:27:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJHid-0000SJ-QF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 10:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbcAMJ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 04:27:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:56167 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114AbcAMJ1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 04:27:48 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiDrv-1ZoMxN1nvf-00nPwE; Wed, 13 Jan 2016 10:27:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5695E4FB.2060705@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LpLy6AtawakY8QxdrV7B/M0QnqPjoiiYfCPXMmnTFR5lNhnJFzT
 hgt8IAUv1O+bBfI9xUSisd1qjfIPLdCqTPFvXJx595fmfrimBvCeYzDQ/KiL99TFDB6vsEe
 OAaxI9z/ODWmDwiXKZgurjBOwm/YopBdiSoKtdEEQhFUOPNwOOFFRa+MS+BhcAzyFP4qjh3
 cXzU4CoRxVR/DD8g2Yygg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NbnuEXOGcbQ=:yRv14bsglA/Ve1zAjMXeCO
 6NfPhdZqJNZWSSV3z5bg5SsP3e16QvgtgtbIjBJCqF4G7PNpUKoPfqgojWPpEx0jW7dMTmNLJ
 wuWVla54LwJumctYA7UsIA77H+hq+YLCWJKnJTT1xWpnXwlsazyRRPTO5zjjBUnXPvfFL6r8C
 pgdLh7my4Yx0+wl3a4Gq17N3cqn45GxYR6p5YgRj9gWWDtzPNSMGRsLivUX56AaOZbGAMVFyL
 4fRvUIi4liJ/s6MN3rl/xrUnyed1rbjmqXgtrBlt7PzautzlCRhS6aqARFFDhHf4GexQLDGt1
 IGIt0rTu3lhPIk7H2V1yndp7P/WtZROvmUGXfUaJ6mK3g7Tnn8AQaS5nx5uUuDpmcWXiDg898
 Q7Tm+SzX22aR4b2eWC1aiTIsPb6sbQkv4da2jq7VRPCyXpK9ffuc+Y6Aauhpdzre5MPpf5XYZ
 iqRhFc3ldypw2AtZt47ybbuv5UcTNeUzwzjdR8EizU7aGPwFHVD4mgtdz1QvY+eYUyPnWEijO
 0OOy27JsHM04sQtdmG7F3k6p2tSZVcm9YPh9hQphnOJqVChdG+wM35XDFa+mB+Y3aMVob4RNP
 khK+aR/w+9Dam2ZNtKwSZj5depozzQtNScOJkvNljlaqunVuYbCccP5KBDgLApIPD+KhXr/xR
 YiAkiiCAo5PzL7kI/iTeJIhRm8WbTJWuGq0imtPrFeWYaBnBbrHUGvZORYG2vAIhwnnflhQ4i
 +8lzZqVfz6zhNf7p97Z6v6ZJxcKnMzWMrwa6Vghvc9J/iRQWm+LEU3ptYjSmsuBCX8Ke7EzK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283896>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1593712626-1452677258=:2964
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Wed, 13 Jan 2016, Torsten B=F6gershausen wrote:

> On 01/12/2016 08:57 AM, Johannes Schindelin wrote:
>=20
> > +static struct test_data basename_data[] =3D {
> > +=09/* --- POSIX type paths --- */
> > +=09{ NULL,              "."    },
> > +=09{ "",                "."    },
> > +=09{ ".",               "."    },
> > +=09{ "..",              ".."   },
> > +=09{ "/",               "/"    },
> > +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
> Why the !defined(NO_LIBGEN_H)
>=20
> Shouldn't CYGWIN always behave the same ?

One would assume... Alas, it does not.

I inherited the code in question and wondered the same. I opted for
keeping the code as a documentation of the differing behavior.

> The main problem is, that t0060 fails under Mac OS (with mac ports
> installed):
> expecting success: test-path-utils dirname
> error: FAIL: dirname(//) =3D> '/' !=3D '//'

See the patch I sent this morning.

Ciao,
Dscho
--8323329-1593712626-1452677258=:2964--
