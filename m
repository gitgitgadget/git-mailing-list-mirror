From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/4] parallel fetch for submodules
Date: Thu, 6 Aug 2015 22:08:59 +0200
Message-ID: <55C3BEDB.20809@web.de>
References: <1438882524-21215-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 22:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNRTd-0000PR-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 22:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbHFUJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 16:09:07 -0400
Received: from mout.web.de ([212.227.15.3]:56151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbbHFUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 16:09:06 -0400
Received: from [192.168.178.41] ([79.211.102.26]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M1o4o-1YYDOZ15BK-00tnqE; Thu, 06 Aug 2015 22:09:01
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <1438882524-21215-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:ANahj6msS4UDOaXssTiTgI8NGPJSTAEKDddgVEWnFaXKsy60vFo
 as5BQEdLsWiY1T+4HiJKKkkuR6da9CtdfedJWtRSjmDMxpKdcaTahhbMec6zVeOT8NXx60q
 T2KFanDPhfJo0jjz7OGeiKuoK864Y5Cd99IfQSGhk55pTIQrqJwL3LqnviMwz6XHlr8TUeI
 UFqd23+sMk4X4P6sUIo4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GBErglBYnxc=:JeFfthy/sACHOUJoyhUpjN
 e5ycRMTa2wWNYfo3xLTPYvRN85Mg6d4JVNIPYM0PXU8AFsqzjxIS9LdcLq4SQV5GLhBSHRZaU
 u2w3nC9BqbN7heYdujS2Da/J0Qmo5ctjJGS/3fwI48jkgYx3in4VxuUFhQ/kaNjYMenZrr59k
 53WjpkMmWFxj3tCWiz578z+7ARbisQ81yPEkv0d8hcAkuXbPNWXcXw+CW+rbhKSKzQOVUh081
 3aAG7q5aCZlqeX/EfmWESRGFYkAQGBoNQPUwaLNazdDoZbOYgWzXftEEHJJE2reoUFRsK5EIF
 +iDHfF2trewSbhHqMwD2blf9U+kpATp9QhPdI5sxBnYyd7wS8JaSQivWvq8HmqcwspJgqwR2F
 G9OFa8ZR+aB/8Ucw2+qSqfEfg5yNQ2NcSxRGrK7+8d+Ejy0YaBHm+Sov9a4wK4NgelL1ICTvC
 ZkxjII/lwxUcd9Johz3Mx24PEwUcI8WwJx9x13i+4zx36dW1AUkIWj8hmp4tBkt7Ko/Hl+akb
 aA7NgX94B/5EbGV3RbpiO3enghnAbxfH6a7p31WhIWczzXWpx/ASZR3cHvvzLhu0xarXFn1Vg
 XZ0gYRAibsdB1GCyW6pfo7/2VTcG3306MnaEpYZCdTzPOVKGLBnRQfD7KGfUJKKw7vJdyLZ+S
 1ldC5sAOHZzMhYoG6G872HOOl5lCdvfPXgD2ArN982RuvZpe7/8Kmrup0B5aIwPWj9EM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275442>

Am 06.08.2015 um 19:35 schrieb Stefan Beller:
> When I was looking at the branches of Jens for work done on submodules
> not yet upstream I found a commit "WIP threaded submodule fetching[1],
> and I was side tracked wanting to present a different approach to that.

Cool. I didn't follow that route further than building a proof of
concept because I ran into a nasty DNS-timeout on my router at home
and at work we host all repos on a not-so-beefy server making parallel
fetch rather pointless. But I suspect this approach will bring down
fetch times for some users.

Maybe we could also re-use parallel fetch for multiple upstreams in
the superproject when doing a "git fetch --all" without too much
extra work?
