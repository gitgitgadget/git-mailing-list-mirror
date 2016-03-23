From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Wed, 23 Mar 2016 06:54:13 +0100
Message-ID: <56F22F85.3010507@web.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
 <56F18F5E.9090301@web.de> <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
 <56F1CACA.5040709@web.de> <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 06:54:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aibki-0001e4-1g
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 06:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbcCWFyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 01:54:39 -0400
Received: from mout.web.de ([212.227.17.11]:49739 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbcCWFyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 01:54:38 -0400
Received: from macce.local ([87.146.133.242]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MX0Q4-1aExQN3vqG-00W0SD; Wed, 23 Mar 2016 06:54:20
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:rIlka5mi22MXkSOih4cEr6czslRYRR8OB1gewyF+0uj8mfVqtOI
 9nFKC1Y+FzKNHSgvu7tniw+LiGaI/C+jZiW3kAMiGdEsD/9xvmtbZrr+g+LngLqgpTPGu1Q
 ylyVytWyD7IhMpS6dMj1iIGNcChNGJ67bqU0DUN9QAOme9oebHxbaKYQhwEvqNfGOZY0bRB
 1oOeAyCjQvxe/hoPoTZeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+IJBIF8tkbo=:LF/hJRZDd1gFIprZWyLAl9
 sL0pO6MTNKYW/2j1p0mu/j3NEWy3pE7eCr9qYyDXjCk1BkNytUglGvkp6t2s2N9HF5yFNGQvF
 CmXdUdxxF7D4Q9vzjy//1KJrCtKDuHK8D1jiiUJKh1c1wxhlpJRfnQv0QLaS7hZpcr5RtadQi
 5Wq4BtqHA2MH9uVEr25TVNtIk2QjAI0n5+ZHM+cAXyvOGr10xYSh7qEkGLkFgihfuUbfGI+sr
 ytW7IK6wrHCLvYtfZWvT7E4X2qkzbrKeMARS83TGIE4K4gfKGm+m9VmuC2feOO7qqVdruQb6f
 MwaaG9/dXBYpz2wSh6lM0LH2foXUkWcpHnwjIt+6bNGdJcyDx4nHtajyh92m/QRrKX6tzr0tg
 U2f5bdopayyMK1RPMJip8CONW1r86VDZW5y9K9j7RCHZHO+es2SFqkS5+DyXAXoW/a+ftcT6T
 2RPmoSOof1GKNKVZTYQQ5rDfpnBQnkXy06b9j4lkL6Ng11rNWWgvt127P/IOZK/+6e0X0jj9y
 0EgIs6755kp59G8t6lllJ4NIPHCEiuLTyKrRv5K3s4dhXHdgcs7Ot2isACEOOOJDMY5tTfspB
 EoOxfVXDjnPnbjVgTFDZqq7JOiGu47PxCiklfQplrq+oUwsQRVYgxMXrMnIlYJ53ABcrlb9Qh
 OHBPnMhc5dix7SEBiXGJZhAtRqzq6rg1x/PJZIPhuI3SWLRjpzy6kgm7aXTcagNE3k0g6jpSO
 uzhR2zaEfAcR6zD4bMmdZvSfV6wYoXwgG+o60FB1hhXQDtyiCe8+YeoiTEfsXMlPgj9H5q+W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289595>

On 2016-03-22 23.57, Junio C Hamano wrote:
> Dscho, I queued two out of these four, with a proposed fix-up patch
> for each of them, on 'pu'; but I won't squash them together myself
> without hearing from you as I do not test mingw or macosx.
>=20
> Thanks.

the queued t9115 passes under Mac OS X (#11 and #12 are skipped as expe=
cted)

----------------
Beside that, do we want to amend the commit message like this:

Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Tue Mar 22 18:43:00 2016 +0100

    skip some tests in t9115 due to file name issues

    These two tests wanted to write file names which work under Linux o=
r
    CYGWIN, but are incompatible with file naming rules under mingw or =
HFS.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
----------------

http://thread.gmane.org/gmane.comp.version-control.git/285776/focus=3D2=
87717
