From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 14:53:22 +0000
Message-ID: <569907E2.9070104@ramsayjones.plus.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
 <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
 <5697E550.9020102@ramsayjones.plus.com> <56981DC2.6070706@kdbg.org>
 <5698415E.7070907@ramsayjones.plus.com>
 <alpine.DEB.2.20.1601150730440.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 15:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK5kp-0003qc-4R
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 15:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbcAOOx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 09:53:27 -0500
Received: from avasout07.plus.net ([84.93.230.235]:40607 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbcAOOx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 09:53:27 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 6EtP1s0044mu3xa01EtQu6; Fri, 15 Jan 2016 14:53:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=tnmD3aIxVeOKCBGCOnAA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <alpine.DEB.2.20.1601150730440.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284171>



On 15/01/16 06:34, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Fri, 15 Jan 2016, Ramsay Jones wrote:
> 
>> On 14/01/16 22:14, Johannes Sixt wrote:
>>> Am 14.01.2016 um 19:13 schrieb Ramsay Jones:
>>>> Correct me if I'm wrong (quite possible), but _each_ drive has a
>>>> current working directory associated with it in win32, so it's a bit
>>>> difficult to use drive designators with a relative path (eg.
>>>> C:usr/lib).
>>>
>>> As far as it matters for Git, such a path is still an absolute path,
>>> because it is not anchored at $(pwd).
>>
>> [...] seems to contradict what you say above.
>>
>> What am I missing?
> 
> The missing bit is: while C:usr/lib is *not* anchored on $(pwd), it is
> *still* not an absolute path because it is anchored on the current
> directory of the C: drive (the entire idea that some drive state can
> change the meaning of "C:usr/lib" makes it a non-absolute one).
> 
> Since this concept -- a path that is neither relative to $(pwd) nor
> absolute -- does not exist on Linux, I do not think that Git for Windows
> handles this case well at all.

Yep, I may not have expressed it very well, but this is what I was trying
say! ;-)

ATB,
Ramsay Jones
