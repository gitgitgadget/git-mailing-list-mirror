From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Fri, 22 May 2015 08:37:56 +0200
Organization: gmx
Message-ID: <1be7702fa53d1705e913aff2e00eac21@www.dscho.org>
References: <20150521041435.GA18978@peff.net>
 <20150521041619.GC5196@peff.net>
 <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
 <3516DC60279A42188EE2AA394921FC70@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri May 22 08:38:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvgay-0005FP-4e
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbbEVGiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:38:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:61703 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbbEVGiG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:38:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M0y47-1Z9UNt34Bj-00v9CF; Fri, 22 May 2015 08:37:58
 +0200
In-Reply-To: <3516DC60279A42188EE2AA394921FC70@PhilipOakley>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:+6vQYCsJvmEUFV/0dXpjOYYUxJ7qRL4azJgdjwhPE+8yI8LFyn2
 wIJWMd6WNp7AA8k7xKWv67LStonV/O/rdtgwphL6Z1FHCFyO13VY8qqoGW0aF7O+4aZxuSn
 GhaGaJ0zPmQpKcN7558iX0/MbJP/Ynd7T3b/eBnY7jkx45nSCSPoqAkm14tsgwseUVC0bRJ
 tiyf2J3k/DxPosT6Ki09Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269693>

Hi Philip,

On 2015-05-21 21:45, Philip Oakley wrote:
> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>>
>> On 2015-05-21 06:16, Jeff King wrote:
>>
>>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>>> index f1f2a3f..ffeb03b 100644
>>> --- a/Documentation/git-clone.txt
>>> +++ b/Documentation/git-clone.txt
>>> @@ -107,6 +107,9 @@ objects from the source repository into a pack in
>>> the cloned repository.
>>>  transfer and stop borrowing from them after a clone is made
>>>  by making necessary local copies of borrowed objects.
>>>
>>> +--seed <repository>::
>>> + A convenient shorthand for `--dissociate --reference=<repository>`.
>>> +
>>
>> Since you want to advertise this as an easier way than `--dissociate --reference=<repository>`, it might make sense to avoid sending the reader that way, too.
>>
>> Maybe something like
>>
>> --seed <repository>::
>>    Fetch objects from <repository> instead of the clone URL when possible. This is useful when a (possibly partial) clone already exists locally, to avoid transferring the same objects again.
>>
> 
> Would it be worth mentioning here that a bundle is a satisfactory
> alternative to repository?
> 
> +--seed <repository|bundle>::
> +    Fetch objects from <repository> or <bundle> instead of the clone
> URL when possible. This is useful when a (possibly partial) clone
> already exists locally, to avoid transferring the same objects again.
> 
> I haven't checked if the invocation would accept a bundle filename,
> but I'm presuming it can in the same way that clone does.

The proof would lie in the pudding ;-) Would you mind testing whether it works with bundles?

Ciao,
Dscho
