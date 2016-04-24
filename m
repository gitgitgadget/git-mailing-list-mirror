From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Sun, 24 Apr 2016 18:42:51 +0100
Message-ID: <571D059B.2010908@ramsayjones.plus.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
 <571CE4D5.8010403@ramsayjones.plus.com>
 <CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
 <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 19:43:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auO3u-00082d-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 19:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcDXRnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 13:43:06 -0400
Received: from avasout07.plus.net ([84.93.230.235]:54605 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbcDXRnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 13:43:04 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id mHiv1s0022D2Veb01Hj2EA; Sun, 24 Apr 2016 18:43:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=dIu3SnmMAAAA:8 a=NEAV23lmAAAA:8
 a=hUom9P0TY2pM-mIw0BMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292423>



On 24/04/16 17:56, Christian Couder wrote:
> On Sun, Apr 24, 2016 at 6:27 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>>
>>>
>>> On 24/04/16 14:33, Christian Couder wrote:
>>>> This is a patch series about libifying `git apply` functionality, and
>>>> using this libified functionality in `git am`, so that no 'git apply'
>>>> process is spawn anymore. This makes `git am` significantly faster, so
>>>> `git rebase`, when it uses the am backend, is also significantly
>>>> faster.
>>>
>>> I just tried to git-am these patches, but patch #78 did not make it
>>> to the list.
>>
>> That's strange because gmail tells me it has been sent, and it made it
>> to chriscool@tuxfamily.org.
> 
> Instead of waiting for the patch to appear on the list, you might want
> to use branch libify-apply-use-in-am25 in my GitHub repo:
> 
> https://github.com/chriscool/git/commits/libify-apply-use-in-am25

Hmm, that branch doesn't correspond directly to the patches you sent
out (there are 86 commits, some marked with draft. I think commit d13d2ac
corresponds kinda to patch #83, but .... ).

I think I'll wait to see the patches as you intend them to be seen. ;-)

ATB,
Ramsay Jones
