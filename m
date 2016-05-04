From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Portability of git shell scripts?
Date: Wed, 4 May 2016 20:35:51 +0200
Message-ID: <cdb4e001-7dc7-3c3b-27ca-2c970135805a@web.de>
References: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Armin Kunaschik <megabreit@googlemail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 20:36:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1eV-0005OR-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbcEDSf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2016 14:35:57 -0400
Received: from mout.web.de ([212.227.15.14]:52559 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbcEDSf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:35:56 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LgK3g-1bU7MC0sei-00nfmC; Wed, 04 May 2016 20:35:52
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
X-Provags-ID: V03:K0:oLcZeb3eXv0kEFkG7+bnU2nS7ntLrTKhjW/gSd+eC0yW+vLFvnL
 j/gsu4FeIcRnp5D8W0lNc0bN9eGBKnb2Prg2qMq9MsKbZK0eJUZ1p1cWDM1CxekUnidmBPM
 fRnKpBEd/9lYkWYwS3PKQAdsW+6rEBKRC7yffBpwS6PPxOuz/Wj2vZslQkr+aCvG9X6KwZ2
 KCG6fICqw7PrRJ6nA6tTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jGoUxBxvo8g=:GyFLeHb63rOnkKTw/huvU7
 x3hatqCwCjXEmf2MYQ3UvdxcKqB/+NRWSXWPfmiHsyWsue0swNRvkCTvweExpnVZLkwZPVeBY
 nwL3DP2/gfux52cEkSsd0xd2lPipF3rW/7pa/AijUKy3QWDC0TAW4OQPQmy8bHqryWM4lIxh3
 l0m+lJ6KaGPSbEcLQKYX7hPqzG9gaBOOrJD1Wb4yFW3vt1di+UUl1Q17Tfu80yLi884cXQkvc
 TT6/CSt6hEN1BF7W0FiagPptkhCQ+tQMf8PzFYovxVYH+gU79ap1uSTq+oRTracjPTJWp6hnL
 O2JDrXlx/3YRV7axhefM5p1ynwT6RiymjulAbO0Dwr96ixTEA4EOZcoOlqkZ15w4EGUZkd2MV
 yyVtRNLgLQINQ2cPvAsP9C4v2lyt4FawRDYJn4Jzvq+s/d3wZsRy2MDJaiSIJREy2kEIwKQi2
 4yiCJsMHHg7+3aC6kgx6mFDETMA5TFPSVXNlPDWgLpY942jcoYgJIj/xoXtkXkb55OZAkMX3W
 uj8uSy0hPja0Nrkn79s2MkVMZzFcBER7FuooQyyFMWC0BzsM4bgb8QhDLiBVhiGmXG5q9Mt8G
 MnvQzm88UZls9IgdYmy98FsQTkHUMKEtySVRTPwXiNYXd7FkavGMkoK6/1L2zWPdJuKN9o9fI
 xJm+ncJa+yMIrcN8PIEGgatG9EPedBSPKpYhlRScqVNLCysQRxfxllNaiU1XbEH5RGL4JB8jp
 6qxgvETHlm1X8O833hoOgVeqa2IF7sP9MSbMAbZ07k0ajF3RD6rzZCehvFKbJ/s/y0OWALrm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293561>

On 04.05.16 20:17, Armin Kunaschik wrote:
> Hi list,
>=20
> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with no bash avai=
lable.
> /bin/sh is a hard link to /bin/ksh which is a ksh88, a posix shell.
> Is this supposed to work?
>=20
> As an example: make test fails on nearly every t34* test and on tests
> which contain rebase.
> The installation of bash (and manually changing the shebang to
> /bin/bash) "fixes" all rebase test failures. So obviously git-rebase
> is not portable at some point.
>=20
> Does it make any sense to put work into making these scripts portable=
,
> that is, work with posix shells?
> And, as last resort, is it possible to configure git use bash in some
> or all shell scripts?
>=20
> Regards,
> Armin
The Makefile has a knob to use a specifc shell:

# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.

Does this help ?

Otherwise:
I don't know how much posix ksh88 is, it may help, if you can post some=
 output ?

I use sometimes
debug=3Dt verbose=3Dt ./t34XXXX.sh 2>&1 =E2=89=A4 tee xx.txt
but there may be better debugging utilities these days.
