From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 29 Feb 2012 11:38:52 +0100
Message-ID: <4F4E003C.1050301@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><878vjn8823.fsf@thomas.inf.ethz.ch> <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2g2G-0008Sv-QN
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042Ab2B2JlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:41:18 -0500
Received: from luthien2.mpt.es ([82.150.0.102]:35720 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964954Ab2B2JlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 04:41:16 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 7D32AB705C;
	Wed, 29 Feb 2012 10:40:19 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id A35282C6F1;
	Wed, 29 Feb 2012 10:40:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 7D32AB705C.1CBEB
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331113220.70363@yDReubmeaIpFGgVor11lSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191828>

On 02/28/2012 08:24 PM, Junio C Hamano wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
> 
>> Which raises the questions:
>>
>> * Why is this needed?  Does git's use of libcurl ignore http_proxy?  [1]
>>   seems to indicate that libcurl respects <protocol>_proxy
>>   automatically.
>>
>> * Why do you (need to?) support HTTP_PROXY when curl doesn't?
> 
> Let me add a third bullet point.
> 
> I've heard rumors that libcurl on some versions/installations of Mac OS X
> deliberately ignores the environment. For those who agree with Apple, it
> would be a regression if we suddenly start the environment ourselves and
> using it.

Hi Junio, what did you mean by "we start the environment and using it"?
I didn't understand what you mean there..
