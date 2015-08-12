From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Fwd: Re: [PATCH v5 3/5] clone: do not include authentication data in
 guessed dir
Date: Wed, 12 Aug 2015 06:15:17 +0200
Message-ID: <55CAC855.9030908@web.de>
References: <55C9A40F.3010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Patrick Steinhardt <ps@pks.im>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 06:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPNRr-0006Ch-Ou
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 06:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbHLEPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 00:15:24 -0400
Received: from mout.web.de ([212.227.15.4]:49818 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbbHLEPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 00:15:23 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MaafB-1Z5mEJ1rEP-00K53E; Wed, 12 Aug 2015 06:15:18
 +0200
X-Forwarded-Message-Id: <55C9A40F.3010907@web.de>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <55C9A40F.3010907@web.de>
X-Provags-ID: V03:K0:RdW9KO74pPLEnI/pJgJ4eMKgcHrpyoAckZXCwEUSeDrwS6ST7bu
 QaPC9iYGPaMntJPjJPb79MKVqhFmTQYTfgtoX4+bs8QzkPhOsw7DoplT2kdbV+rGfpq9K8t
 lEih8ouIzSfSrh9DAYBoTXWB0yqjCFDYjxsnYRr0wtXiafqfdhhFT4sb3ZNjoFps7WecMvT
 V+UElN3lM2NnEBRXzw/zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KI7EQbdCyb4=:5IpKm/gIaXp260fU/fpNlX
 GZaG07DZ+QJfACIu2DyfZg0GEPPgJQ8XOEYPy+rJSCJcVAdbDM4V8NgKIOWx82oB+3SEzqRZQ
 n4j+TwNaD/4VqRu8kOCXezHv8Dj8MlQHGc4DSbcQ/xHubKvJeNxbGAWJwIwcbz685JuRSG2iW
 08WJYxoqW3iMzF4Sztp/Ln8VjP+pDTG/Z6OVDwNMeseU620NamkD9CzS6gUqTb0Fygv9yTbbi
 3Q1hz4i5RXNudFAs1xOyPLdhOaznmUdokMDHwNNVYjaYVmZEMnHKXSdie71AfTJNw90mUfv2h
 VBbSqHRbyNxPQh7FuRv9VVK/jHM6a8i02QzszTwgdTYf1flR1Z3b/bAyggNzuwxLQ0Q54qz08
 jFadMiPVdcBMFkIesRkawYEvCm+zVgnCqrZBkxJhKnpOUA3JcTuaFOllHIhu/vIyBgfy/YqPP
 dyj1DPRU+t8FY5kJiJiH0s0p/n69l/q3+NhQCh1SFPsAYr0tMbwlxBQyWOmlJ8LMuzkOVh6Yh
 sudkvdyq8mfWBhDVROtLC/6VckA+B4bh+RiTCmwmtulC3hkh+vBeRM4apUYTqm8/TwuUpLRHM
 ikpRYE3YJB146alBQRIROpGqw89vLvJZvTuVdfclom3Tn6ABeKIqhoIE7Ffs3dqW4PfSkuV6u
 0cRRZxyXyE6WLNWiLpGAlat9z3ftPggkD0OGkCzuN5dfLas3OMbpLp2mAP/L84WZ9hFYJZeY9
 21MY+UQ0CKYlmFO8FHIgzfOf5uZhQ+SSjanEkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275755>

On 08/10/2015 05:48 PM, Patrick Steinhardt wrote:

Sorry for the late reply (and possible re-sending), 
I just stumbled over this in transport.c:


/*
 * Strip username (and password) from a URL and return
 * it in a newly allocated string.
 */
char *transport_anonymize_url(const char *url)


Could we use this function for something ?
