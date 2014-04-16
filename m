From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] config.c: fix a compiler warning
Date: Wed, 16 Apr 2014 18:38:19 +0200
Message-ID: <534EB1FB.5040405@web.de>
References: <20140416141353.GA9676@camelia.ucw.cz> <20140416152920.GA4691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org, kasal@ucw.cz
X-From: git-owner@vger.kernel.org Wed Apr 16 18:38:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaSqy-00027z-9w
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbaDPQiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 12:38:23 -0400
Received: from mout.web.de ([212.227.17.12]:49284 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbaDPQiW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 12:38:22 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MIBu2-1WWd621u50-003xh3; Wed, 16 Apr 2014 18:38:20
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140416152920.GA4691@sigill.intra.peff.net>
X-Provags-ID: V03:K0:bUE5eUZZxCJTy1Zbl89eetWNKBStIFR5ncZIHEVe3ZcW9VL7daf
 wEbXIDbJ/QNziJjCZAc0tRAVXKzBB+bVq/rVGdfc578WO/B7OqKE0Q8In96XLCdZbg9fQaK
 erm/ZbK9fYsCiIpE4mIs39w+1nfF0C5G0zUlRiVTsWBtPbr6dZ5Amyq0V06ZOysjZWuugI6
 dJKc2iHlUF0XBExex57og==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246340>

On 2014-04-16 17.29, Jeff King wrote:
> On Wed, Apr 16, 2014 at 04:13:53PM +0200, Stepan Kasal wrote:
> 
>> Date: Thu, 10 Apr 2014 16:37:15 +0200
>>
>> This change fixes a gcc warning when building msysGit.

[]
> +NORETURN
>  static void die_bad_number(const char *name, const char *value)
>  {
>  	const char *reason = errno == ERANGE ?
> 
> Does that also silence the warning?
> 
> -Peff
This works under gcc 4.2.1 Mac OS: the warning is away.
