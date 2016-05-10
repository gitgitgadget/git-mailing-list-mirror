From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 23:09:00 +0100
Message-ID: <57325BFC.8000101@ramsayjones.plus.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
 <1462832134.24478.49.camel@twopensource.com>
 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
 <1462881130.3018.13.camel@kaarsemaker.net>
 <5731FFB7.20006@ramsayjones.plus.com>
 <xmqq37ppodua.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 00:09:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Fq3-0005cB-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 00:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcEJWJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 18:09:07 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43220 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcEJWJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 18:09:05 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id sm911s0032D2Veb01m92sq; Tue, 10 May 2016 23:09:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=PlzUWASLpKUbIZ6vtjkA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq37ppodua.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294201>



On 10/05/16 21:30, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 10/05/16 12:52, Dennis Kaarsemaker wrote:
>>> On ma, 2016-05-09 at 15:22 -0700, Junio C Hamano wrote:
>>>> It passes on one box and fails on another.  They both run the same
>>>> Ubuntu 14.04 derivative, with same ext3 filesystem.  The failing one
>>>> is on a VM.
>>>
>>> Same here, except ext4 instead of ext3. Failing on a virtual machine,
>>> not failing on a physical one.
>>
>> I can confirm the trend:
>>
>>     Linux Mint 17.3, ext4 - bare-metal pass, (Virtual Box) VM fail.
>>
> I do not think there is anything VM specific, though.  If it is
> SIGPIPE, it is very much understandable it is timing dependent, and
> VMness may be a cause of timing differences, nothing more.

Yeah, I had previously noted that this was probably a timing related
issue - this was only meant as confirmation that David could probably
reproduce the issue if he tested in a VM. ;-)

However, it appears Dennis has found a way to force a failure, even
on bare-metal (at least on v8, I think).

> I seem to getting the failure on my physical box today, by the way.

Ah, interesting.

ATB,
Ramsay Jones
