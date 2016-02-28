From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Sun, 28 Feb 2016 18:52:49 +0100
Message-ID: <56D333F1.9050905@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, k_satoda@f2.dion.ne.jp
To: Eric Wong <normalperson@yhbt.net>, tboegi@web.de
X-From: git-owner@vger.kernel.org Sun Feb 28 18:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa5Wp-00052e-It
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 18:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbcB1RxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 12:53:06 -0500
Received: from mout.web.de ([212.227.15.14]:57497 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbcB1RxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 12:53:05 -0500
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LrbLR-1ZvIZG2o0r-013RXH; Sun, 28 Feb 2016 18:52:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160228045945.GA14289@dcvr.yhbt.net>
X-Provags-ID: V03:K0:PKW3MDBDo6NXK8pgE23ypDhX090HD0rFMzPdGzh2PGen2JrHjJr
 zAupitOqEi2vmMPaR4qQKHC12dtzzCYhCQg6pgZfM2B2AtSpltfGBQwCIM+DFvCkpBDxCT6
 EYM3BjUf0JWDzcd0SpovyCI94KYSLLlAWWdBPXxfUn2RyZ5D/UTBrqxrraS9IB0U87psDdd
 phdCT3B9Xu7t362m95VNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i/FholMEgOk=:b9Njv0++25iXFvsOfW1hoP
 cU9+BUCViWYMoH0G2E/MHy3LZyyS/HufJyViWBEDSszLHusQzWsHL8rrW753LXYlhOQQ/vQbH
 kCjdJCIchcgcbKxdysymsDv+sFBVNLjDbfSgr7avFB+kuLI7iKD8yG/iJV5BVkt/SAWt5KX1p
 5+2GS9bRrFGH9IACCpW+oVZqHWWkJhjWZTR/BXvTEdfmRoBGvR7aG/8/vOe7OPI1bsdW6YMm/
 gQn4UnibNPnZJICN7vihZLHmP+Usr3vYzNSHnljQ1a6uLDiUNewUefjfOuJl14iHJabuJZrSi
 X+791GjnWRq8sdDHDidSM4eNIcf+cpTz/gBBtje+LRGUwBazEF54WDLrAHKXOPcQjy5gh2N4j
 JtAdD8YWNbANZlNn1KFDT9iojDGAxqEc/wplj8XWKDv3ncZULpu8ol/D+10kzwUWYTzfEAAqu
 BV78lEpPY4n8f7ClVNa1LWZgBMg9M8c9oUtvqQq6PXiIxsXFGekwXu6C4spnjQY7ui4uaoKk4
 p6bB4MzLcfhxpE77nmWYS/ffApymZoZt8Ho+Ug8es3v0+F4sTzHIaoOiVr76FVMpudElZDU1d
 7NmGWL9Zs+DoG1YAvvzQxA4OTfiCRlWbSqzr8vCXabslpJXWngdFqHol0JnwwVqCpWf/D1Eut
 WxAfdCmnGILP3M39q0HNV7nufCocI9BrbvAwKViM2sHtcM9NH4A7CTjnp8IZmT9hEdWaCQHsY
 bAQg+/6oDbnGF122zrocyIaz+kG1Ntm6HK55l5gpiYu0Qf3NoEG/QaAjy5kgvMKQYx1bdIfe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287779>

On 28.02.16 05:59, Eric Wong wrote:
> tboegi@web.de wrote:
> Please keep lines wrapped at 80 cols or less.
> (I need big fonts)
OK
> 
>> @@ -105,10 +105,10 @@ test_expect_success UTF8 'svn.pathnameencoding=cp932 new file on dcommit' '
>>  '
> Why the extra 'o'?
That shouldn't be there, sorry.
Will send V2...
