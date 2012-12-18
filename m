From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: sys/param.h
Date: Tue, 18 Dec 2012 20:46:50 +0100
Message-ID: <50D0C82A.4010706@web.de>
References: <20121217213730.GA17212@ftbfs.org> <50D02B9A.1040906@viscovery.net> <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl39X-000548-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab2LRTsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:48:18 -0500
Received: from mout.web.de ([212.227.17.11]:57358 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab2LRTsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:48:17 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lilcj-1TFHoF3PLh-00cn2x; Tue, 18 Dec 2012 20:46:50
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:k+2T25IAqX7S8ZqhUzS+/mNjh4NEqzFoY5XihPPpWcX
 XloLAmtqIROSmf/7EExgX1tu/RfkmjkS+S3UCLIp6Q27dxQIki
 o7z3BnTtPGK92PcBmMJE50L2K7tderYUWGdXFBwe2ClLh/qukl
 V+NIFvMSKrP4FiamJJWPOqxEcdaXtsey633bdbGTZrJTo9gpGn
 5lPmGpKvTnUigUpSf1N+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211780>

On 18.12.12 18:01, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>>> Junio C Hamano wrote:
>>>> It could turn out that we may be able to get rid of sys/param.h
>>>> altogether, but one step at a time.  Inputs from people on minority
>>>> platforms are very much appreciated---does your platform build fine
>>>> when the inclusion of the file is removed from git-compat-util.h?
>>
>> MinGW works fine with sys/param.h removed from git-compat-util.h.
> 
> It seems that OpenBSD 5.2 does not mind it getting removed, either.
> Debian 5 and Debian 6 seem OK; so do Ubuntu 10.04 and 12.04.  I have
> a hunch that Fedora or anything based on glibc would be fine, too.
> 
> What other platforms do we care deeply about?

Mac OS X 10.6.8:  OK
