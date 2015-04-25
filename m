From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] t0027: Add repoMIX and =?UTF-8?Q?LF=5Fnul?=
Date: Sat, 25 Apr 2015 17:13:19 +0200
Organization: gmx
Message-ID: <6d0ff6f2d14e9efe73a39715c26be402@www.dscho.org>
References: <553B3871.6050904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 17:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym1lp-0006KN-OU
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 17:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbbDYPNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 11:13:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:56142 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933243AbbDYPNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 11:13:23 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MMkDH-1Yfhi30SFD-008ZFN; Sat, 25 Apr 2015 17:13:20
 +0200
In-Reply-To: <553B3871.6050904@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9CkiDLNtWbZSLVjaUB8CQzwtamNMBUcVSp/T/IsyTuLpmpo6cIn
 /LMDs/x2QVI3IIp/WGyjRgTXzxe+SCm4HqkWPbWVYTtrjsdjdQb6hQ1O+FBxXDp1+rvDTjO
 rujS0ppGl4EK/Ij3rZZsk2FlVwnNc1eI2R1Ul1ik0A/UU3FH+UtWrZ1/vdpglKEvN02Sdl2
 CJpKt17T88Bb3Zx04Dnow==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267789>

Hi Torsten,

On 2015-04-25 08:47, Torsten B=C3=B6gershausen wrote:
> "new safer autocrlf handling":
>   Check if eols in a file are converted at commit, when the file has
>   CR (or CLLF) in the repo (technically speaking in the index).
>   Add a test-file repoMIX with mixed line-endings.
>   When converting LF->CRLF or CRLF->LF: check the warnings
>=20
> checkout_files():
>   Checking out CRLF_nul and checking for eol coversion does not
>   make much sense (CRLF will stay CRLF).
>   Use the file LF_nul instead: It is handled a binary in "auto" modes=
,
>   and when declared as text the LF may be replaced with CRLF, dependi=
ng
>   on the configuration

Works precisely as advertised on Windows (tested on top of Git for Wind=
ows 2.3.6 release 2).

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

=46WIW Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
