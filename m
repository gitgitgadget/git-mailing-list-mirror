From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/19] Let Git's tests pass on Windows
Date: Wed, 27 Jan 2016 09:38:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601270936440.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de> <xmqqbn88at2y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:39:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOLcw-00029B-9a
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 09:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbcA0Iiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 03:38:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:54826 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbcA0Iix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 03:38:53 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M0QAP-1a5s0A49Nt-00uayV; Wed, 27 Jan 2016 09:38:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqbn88at2y.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:JfmKrUHqedZl+zxPYlueamAaSAj7Nz0XMZU/9M3VH1j2HDdIzSY
 imwBlHThSvgCVsQcXoEtW2l2ctHPruLot+YqxDtUbMpE3E3HJzJ/z5txq90hECj4lw80z2g
 tQh2WxsL12mTzshET1nKRF4ut4MzP0zunEX1bx9jG4BxXQw512Yy1/0BPKRBxsWkjEWv7/y
 xkzUmS1Fk58WpgKcioPqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dkhbm1U0oHE=:XvRgP2EvG6+emYShdOywUc
 m+IRhOW1yIsgh+wFVnYPZLz6JsTy8UC25rLYBL+a8XrEgKIJC4zlaHqJfOl1U1zsq8hcY9P36
 twaHHGiJ01r1EC7cD95RqRzOAnen3Yy6OJRgETCLz4Luio0N05ycXiA2Ohm4ZmsafCJnBGkpo
 LVjyiLc/9P+MeEHoP8aV1fpRtr6WpH8uoiZNAO1k5Pj0SA/K751yUyM7m53r0XXZZrmcquuDb
 LjCUgvM9AojzgXwN5qxg3NY3Uem4mMihLNtY4s497gyS921poSlgmUsHpIr8rBcijqxi9tutb
 wy/AdOyVpaSk4OgoE8J/TPe1JEWVKmBfjvaBlJb6i4YG7U2Y0eVCXDZuDImTEZsRssC39/sKz
 8z8+DQWgmUDov1IfnB/hRsO7d84yyighf1jw9aGiIJoV4P84bfG0L6SvqGpgeRrEPdK4ehmHm
 FRPYNZjlU/f6gxUfTcjYxBcHNRbplRrTzPkikzsqrpUgDXsj/FtPKka4cJZMR5tGfICfkfS1j
 z2lFdI7NyHG63wO6cLl15GBX2OzbCHGwrRNEuwGLSkfu2S2w02CSFa4TWzBVtCkKB7ydxprtK
 YAQTepxhSB46iRjs38ZRLrK2UF+LLCU1G0Iw7jJBr9rSb9XoO+ZAfyA62wUagnAI9yKtLznIp
 soHW73W+Rriz6hTWy9c2nYF7+ctHmcECFfrGbeRQjQgInO1l07lRvOTCAhL8glHtVhlWpljAc
 lqEFTiUR/080vJ5MKoz8ZZk4lhq6ch0Thc5yZMWAEabDlPPqoNyZuSgfKEowRV5e0SvwhVoE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284895>

Hi Junio,

On Tue, 26 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is a big milestone. With these modifications, Git's source code
> > does not only build without warnings in Git for Windows' SDK, but
> > passes the entire regression test suite.
> 
> Thanks.
> 
> Without a few fixups, the result of applying these patches made
> tests fail for me (so presumably for everybody !MINGW)

Drats! I got lazy and did not re-test everything on Linux after a while
(it really sloooowed me down and for a good while the tests all succeeded,
so those regressions were incurred from working on this very patch
series...)

> which I think I fixed all, but I may have broken things on MINGW while
> doing so.  Please re-fetch from my tree when I pushed the integration
> result out with this merged somewhere on the 'pu' branch, retest, and if
> I broke something please re-fix them ;-)

I made a couple of other adjustments anyway, so expect a new iteration
shortly. This time cross-checked on Linux.

Ciao,
Dscho
