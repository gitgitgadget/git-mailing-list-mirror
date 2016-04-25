From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] remote.c: spell __attribute__ correctly
Date: Mon, 25 Apr 2016 23:14:38 +0100
Message-ID: <571E96CE.80606@ramsayjones.plus.com>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
 <20160425211030.GA10309@sigill.intra.peff.net>
 <20160425211523.GA11227@sigill.intra.peff.net>
 <2FDBFACB68254498A8F83367553AED80@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 00:14:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auomJ-0007Pi-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 00:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbcDYWOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 18:14:47 -0400
Received: from avasout07.plus.net ([84.93.230.235]:53715 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcDYWOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 18:14:47 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id mmEi1s0012D2Veb01mEjQn; Mon, 25 Apr 2016 23:14:45 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=PKzvZo6CAAAA:8 a=e_B4Ik6_DY99Bqp_GdIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <2FDBFACB68254498A8F83367553AED80@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292577>



On 25/04/16 22:50, Philip Oakley wrote:
> From: "Jeff King" <peff@peff.net>
>> On Mon, Apr 25, 2016 at 05:10:30PM -0400, Jeff King wrote:
>>
>>> It should be handled in git-compat-util.h, which is included by cache.h,
>>> which is included by remote.c.
>>>
>>> There we have:
>>>
>>>   #ifndef __GNUC__
>>>   #ifndef __attribute__
>>>   #define __attribute__(x)
>>>   #endif
>>>   #endif
>>>
>>> which should make it a noop on compilers which don't know about it. Is
>>> VS (or another file) setting __GNUC__?
>>
>> Of course it helps if we spell the name right...

Indeed! ;-)

Not that it matters, but the above #define in git-compat-util.h is not
the relevant definition - msvc will not see it. However, it does see
the #define on line 12 of compat/msvc.h. :-D

ATB,
Ramsay Jones
