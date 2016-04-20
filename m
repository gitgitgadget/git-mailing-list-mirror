From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv3 0/3] Implements the GIT_TRACE_CURL environment variable
Date: Wed, 20 Apr 2016 20:49:55 +0100
Message-ID: <5717DD63.6050002@ramsayjones.plus.com>
References: <20160420162825.62380-1-gitter.spiros@gmail.com>
 <xmqq4maww2bk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de, sunshine@sunshineco.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:50:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asy8Z-00052g-KN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbcDTTuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:50:04 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41288 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcDTTuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:50:01 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id kjpx1s0042D2Veb01jpyLV; Wed, 20 Apr 2016 20:49:59 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=wQrFfSii5M-D8y-UA0oA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq4maww2bk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292065>



On 20/04/16 19:41, Junio C Hamano wrote:
> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
>> Elia Pinto (3):
>>   git.txt: document the new GIT_TRACE_CURL environment variable
>>   imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
>>   http.c: implements the GIT_TRACE_CURL environment variable
> 
> I think 2 & 3 need to be swapped; otherwise 2 would refer to
> yet-to-be-invented curl_trace() function, and break the build
> without 3, no?
> 
> Strictly speaking 1 should come at the end for the same reason, as
> setting GIT_TRACE_CURL after seeing that commit would not give users
> anything new.

Yep, I was just about to send an email saying that the patches should
be in the exact opposite order! (ie. 1->3 and 3->1) That is *if* you
want to keep them as a series. I would squash them into one patch ...

> Other than that, I didn't find anything blatantly wrong ;-).  Will
> nitpick individual patches later but I expect that it would be
> sufficient to locally tweak while queuing without rerolling.

I have one small issue ... 

ATB,
Ramsay Jones
