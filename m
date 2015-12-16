From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question: Exclusions for AV-Software
Date: Wed, 16 Dec 2015 13:24:23 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512161315130.6483@virtualbox>
References: <20151216085212.Horde.y-aVaMjyCCJdxOp8UpgKLg1@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: roman@roume.de
X-From: git-owner@vger.kernel.org Wed Dec 16 13:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9B8P-0000QU-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091AbbLPMY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:24:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:51464 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933377AbbLPMY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:24:26 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4kfR-1aPSM90lo5-00yzqo; Wed, 16 Dec 2015 13:24:24
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20151216085212.Horde.y-aVaMjyCCJdxOp8UpgKLg1@webmail.df.eu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:if8RA5kCGRluuKgfq3yu4HzfvgIq0m0n+5nEHuajUgWGgVk0s+G
 I0uc2hv7bm3tC96c8OEuiYcT4TKE4WXRr4idf226Q3rpyoUtuzFCH3lLlOJiyoZ80QLY+nC
 ZdNzLciDeZu0u0D1IW6PmBe4vr3J38CdkKVL6yQq8dE4Rl5g19k3kL8vEoyuKUNgD8W8nvd
 xSRtTVdpMuoAxqANo0C6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+XxbcqDaJyk=:LNnmXC3b+Kn6WWInIBdAZX
 ERezdL4Rvz3/I9pgEx+lvAoVV2WeNOfIO0p3v8kA30U7Bs/fkoCjkaUMqiyEIulxq64hkjpdb
 DSwSZf0KDBPjYzVsnYf///5ioHwD2VG4IFzCig4W2JPXSsZRtK8EK+ANL79yzkrtXKsRCMOsw
 RigxtNO6/V7lFOytfsCDAoknBFM8QOjwLuAowyIUF+eH9D7OASfyr7Kuc/dP2c1M1Ttm+Gp+/
 sYnXuNE4Y0jGfNV5nAQYyXIYa7XcUKvBugvVeuWsDg+rH8CfOhvTdkLTwaD7f2NtnwLotXXP3
 kXq0XPQdEFEPM76svIbVfB1C8yUitqbszsVKn+SG54JpIX1KUm8j7370dV4aoZCmh5TLRXT4z
 eC/2DqmImtny1xSAW0iBL+c6/G5Re3f1T9tY8kXjgo43fX7HSNXIK0G+L21SSx7ctnv1G6/38
 lSiQwBNWMaUoBlw1SlhF/8sjXTz2bdoEPj+4UMHqCrSBHQ4EOEbg/y4RdFZu0XMCf3N+/MhYV
 NjRc0nMp9sAHLNm87VGL4o2l9QtYnM5ujkNWyiidIbBlSL01I3/61RFLBQanXQzcsAKmEvtEy
 yyWTmYlwdvzlML+5I6ZUvVmpWdvvInb9tlgFdw36R38A0YsBnB3+6dLo5EDww6oXw8ppZiMKi
 8QKwOBC45+9nhVgLBEJG/NOuRxJ4UTkI8OKgZU6ZtsltbeN07EWvkEKBCxVYvTTiVqVGsiPMb
 1WTjeFipUMm2lKhXGCxttCUeFIcFBr1lHs+0exCrUL/Y2Uoh0TEjjdi5WMQdvAiIR3eO4Med 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282551>

Hi Roman,

On Wed, 16 Dec 2015, roman@roume.de wrote:

> do you have any recommendations how exclusions must be set in an anti
> virus software what directories etc.?

If you are talking about a Git for Windows installed into C:\Program Files
(or even C:\Program Files (x86)), it is safe to exclude that location
(after an initial scan, of course) because Git for Windows itself does not
even have write permissions to that location.

Ciao,
Johannes
