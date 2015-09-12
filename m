From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: v2.5.2 installation on Windows 10
Date: Sat, 12 Sep 2015 11:57:44 +0200
Organization: gmx
Message-ID: <a64946ac120a98fc1058bd194153cd0b@dscho.org>
References: <loom.20150911T181145-207@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Long <gimmely@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 11:57:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZahZB-0006ZP-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 11:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbbILJ5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 05:57:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:63922 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095AbbILJ5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 05:57:47 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lmqxo-1Z0FoT1vJc-00h9ho; Sat, 12 Sep 2015 11:57:45
 +0200
In-Reply-To: <loom.20150911T181145-207@post.gmane.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:cXjb6Et4FVLM1O98mIi4/00pFJ/zskKDUpduRBtQqra9HBZdXyp
 ndYiqbOUCNGvFB4RHVCxEHegFcpy2QezbPTSUxxORmzwEv5vFMCYMG1SX93y8e+UG1LrHBW
 Fp6JTS+j0kEhmR7Q0GJZWI8n4hSza6F4E5W19ttNgMmo1a/styoSJgxvwJqXRUsgXnneITO
 7+AqhSeuVny31ovcUeMGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pr363DNBY34=:dK8RU+P6Py9NhaEFjUCujf
 HeH1ubua02How/933A9CNGKpWCQ6/snOpk1iDi37H6q401VTeMmiciid8/bsf1E/UzcnXKAuN
 azPM2apcQ1qpSr0wJ8327q+OYhJNCU2Nm/zFBnBiHF+52+8Ep2TljqqLuOUcW1RH9s9D97S5k
 3nxmShnIgU2cga6g/negahCjV2AyVJ1PD1Y8hfpcAW54ScWZ6VKk6QKTpl3fFrS5VcoAQuDxz
 fQeByTllUKMNRZX/Fe2ZAIoGw3aMQkLl3juaBAhP/UzvQ2O4GJ6UHTbIMfe/lTk9Wg2iuvSbK
 XmC38wXrDxjH8+2pfXvNgUxUX60/jwutAB/zeUpyw39P9FdnKCOkObNKU7BrkjsvwQKCS5TXa
 hTBoBS1tpFTIdEbHttbKMByCmwDb5k7ems4tJfcpURDjxUHl4R0Qtq7d+T9q5vU+y0rdC5lQB
 bulFDPjS23DHVLaudjlv9adPxPap+ISp5iJejpJPx1dA+NnpIYZHZnOeXNDpGWb4p5KkC4cQU
 i8PSfbbxq9Sd2AAz9Kpo0w0ZFFWekqn9kEch7OuJh/pNDl181M7s1mStjwPoWWMavmF5VXIvk
 3LDMo9cabSc3Ud/2LdUDo6yROUmhlUHd2AoTw+6lKCZzkHpFXzoXvHrypRrHV8F0jNM/Rd0CA
 Ti7wFaWQRuXZ0qGoyM72VkHhW8VC9/nEE6IFIdLlTP5RPyN4fPjUqXVGpC/EIaeI5MZCq8Vgp
 1ZuVNJltHL4H4AiPedHTHZetU/neNi60t5zjvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277720>

Hi Long,

On 2015-09-11 18:13, Long wrote:
> Installation of 64bit could complete, but running Git GUI always prom=
pt the
> error below:
>=20
> Couldn=E2=80=99t read file =E2=80=9CC:\Program
> Files\Git\cmd\mingw64\libexec\git-core\git-gui=E2=80=9D: no such file=
 or
> directory


Please see the corresponding ticket: https://github.com/git-for-windows=
/git/issues/376

In short: I will release an updated installer soon, with other fixes. I=
n the meantime, as a work-around you could right-click on the Git GUI s=
hortcut (you can right-click the icon in the Windows menu and open the =
file location to get there), select Properties... and change the Target=
: from

"C:\Program Files\Git\cmd\git-gui.exe"

to

"C:\Program Files\Git\cmd\git.exe" gui

It will open an ugly, unnecessary console until the next Git for Window=
s version is available, but at least it will work until then.

Out of curiosity: how did you go about finding the best place to report=
 this bug?

Ciao,
Johannes
