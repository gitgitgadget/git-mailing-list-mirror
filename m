From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sat, 6 Feb 2016 15:21:02 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602061518220.2964@virtualbox>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1512563554-1454768463=:2964"
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:21:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS3jc-0007vj-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 15:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbcBFOVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 09:21:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:63724 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcBFOVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 09:21:05 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Le5XQ-1Zgxsp1R9g-00ptZW; Sat, 06 Feb 2016 15:21:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GkagvAGRT2KebTRbGFMC3FPbMl3LYaSV7cj7PJ3LpFCXb/71JDS
 0aj9ysfwlN6U0IYB/sOoDSrJrRxpeTPf8iPMAh8xH00itKXS93jaPn/ATJtMXu9/mQFPNSI
 I+KLIvqK4qr2M9/ZfNDer8tEXu1OiqoCEgSVvVi6wAHewiUbL8Ye7tJz+nhV/VdUd2iLytJ
 xWtCqXbqX3IZkU89l4uqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eRuIDlIDST8=:D5tz4XbZSWjZ/W3ph3GS0K
 cNIf+xE4MQVN4ReWm8kJ96vFEvLFYJkrHCpjtnb7C9h3P+LryWvLc2UPqhsleuer9Limwey8u
 nG9ka+nMnCvm9ruZWCZ5uOivMEXurYQ35s2h1iBwm7hP7ILRq2wWFaoqj0Np3AkHWJEfiexK6
 4Z4wJYfbMz7MsBPjjaaNLsewJLroCdMd7mZuOvEpn15q2x97ExtDT4fEHP9RUZ8/F0wiHP8In
 tn2l4Cs+XoFPcfyMGhry3NJU2WJnTUknFV/oUamCbeSj0K6x/lWQ01ujZBd4QYFLvMSQY1nny
 b72IOJ1DMf+qCe3Ug4JN1ZYbXPVvs5AA0m21mn9nVA9grYb47ALA6nbx6+RLhW4SMfRno5Add
 DKqOLR3DjuRme1D9h25M8XM3UZMvb21ANJheqUAhhbhMrPl6ldOGPGttBmBAnI/PCjGHTjd6w
 JzqO0OhlWlPNcExYUjeVi7cwLPQpLHYFi835KHJKNv1h6qNjhuBb88ESTLMhigZaFfg8YVhcj
 F75Lq4p5V1JibX/YVt62c6z4p+pJa/y3gfSOqy2O5Dob0D24iFuqpH4yy1LulJuP8ZfDvW801
 SQzkXO8R9LHtkPn3hnxvO4FhWvgXC/o4gYNMkwbWs0yy6gsH6ZpFC1sq1Y+0TTHYiVbRtv3xu
 Kc+GfsBL++0VyguxTAz3nWWeHdyR2Y0fOeSDMk/GzdZCYgtn5sTCq6e9i7rwVTU6rWg0/hAlp
 scK3tb99TPFObkbAdEI06JYmT/SBB4vCkdLplOukDxFcidNJ3gptEEWjhQvS5DRbFkETnQD1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285689>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1512563554-1454768463=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kirill,

On Sat, 6 Feb 2016, Kirill Likhodedov wrote:

> Is it a bug or I just didn=E2=80=99t find the proper way to escape the br=
ackets?=20
>=20
> Steps to reproduce:
>=20
>     git init brackets
>     cd brackets/
>     echo =E2=80=98asd=E2=80=99 > bra[ckets].txt
>     git add bra\[ckets\].txt
>     git commit -m initial
>     git show HEAD:bra[ckets].txt

This is expected behavior of the Bash you are using. The commands that I
think would reflect your intentions would be:

=09git init brackets
=09cd brackets
=09echo 'asd' > 'bra[ckets].txt'
=09git add 'bra[ckets].txt'
=09git commit -m initial
=09git show 'HEAD:bra[ckets].txt'

You could also escape the brackets with a backslash, as you did, but you
would have to do it *every* time you write the path, not just in the `git
add` incantation.

Ciao,
Johannes
--8323329-1512563554-1454768463=:2964--
