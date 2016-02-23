From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] daemon.c: mark a file-local symbol as static
Date: Tue, 23 Feb 2016 00:49:53 +0000
Message-ID: <56CBACB1.8070109@ramsayjones.plus.com>
References: <56C9F4F2.1060100@ramsayjones.plus.com>
 <20160221232510.GB4094@sigill.intra.peff.net>
 <56CA5753.9030308@ramsayjones.plus.com>
 <20160222211827.GB15595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY1B5-0004hQ-1j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 01:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbcBWAuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 19:50:05 -0500
Received: from avasout01.plus.net ([84.93.230.227]:56870 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755860AbcBWAuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 19:50:04 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id Mcq01s0064mu3xa01cq1yN; Tue, 23 Feb 2016 00:50:02 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=2kEm8GLCBaJTssrXEugA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160222211827.GB15595@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287005>



On 22/02/16 21:18, Jeff King wrote:
> On Mon, Feb 22, 2016 at 12:33:23AM +0000, Ramsay Jones wrote:
> 
>>> Thanks, will do. You notice these with sparse, as I recall? I've meant
>>> to look into running that myself, but it looks like we are not
>>> warning-free with sparse currently. I see complaints like:
>>>
>>>   connect.c:377:40: warning: incorrect type in argument 2 (invalid types)
>>>   connect.c:377:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
>>>   connect.c:377:40:    got struct sockaddr *ai_addr
>>>
>>> As far as I can tell, that's just noise. Do you have a ready-made recipe
>>> for silencing it?
>>
>> Ah, I think you must be on a very old version of sparse.
> 
> I have whatever comes with debian unstable. Looks like 0.5.0 from
> November. So not _that_ old, but I can well believe it is missing tweaks
> found at the tip of their development.

Yes, but that version was released in Jan 2014!

> I guess I was wondering whether I should be adding "make sparse" to my
> set of pre-submission checks. But I can't say I'm enthused about
> manually keeping another tool up to date. :)

Hmm, probably not worth it - I sometimes wonder why I bother! :-D

ATB,
Ramsay Jones
