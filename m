From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] clone: don't use an integer as a NULL pointer
Date: Thu, 26 May 2016 01:32:59 +0100
Message-ID: <5746443B.6060006@ramsayjones.plus.com>
References: <5746316E.8020902@ramsayjones.plus.com>
 <CAGZ79kaEtayuY8ZdB5hD_uYK8qZKQ1kiP3tPchjUm4k_HuVyow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 02:33:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5jEd-0000Vi-3k
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbcEZAdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:33:06 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33160 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbcEZAdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:33:05 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id yoYz1s0065VX2mk01oZ1kC; Thu, 26 May 2016 01:33:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=4b9g85xA5UGfPwwFbmoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <CAGZ79kaEtayuY8ZdB5hD_uYK8qZKQ1kiP3tPchjUm4k_HuVyow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295624>



On 26/05/16 00:30, Stefan Beller wrote:
> On Wed, May 25, 2016 at 4:12 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Stefan,
>>
>> If you need to re-roll your 'sb/submodule-default-paths' branch, could
>> you please squash this into the relevant patch. (commit 8efbe28b,
>> "clone: add --init-submodule=<pathspec> switch", 23-05-2016).
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
> 
> Thanks for pointing out!
> 
> I am sorry for having you write me these emails;

It's no problem ...

> Out of curiosity, how much of this is manual work and how
> much did you automate of this?

... because this particular problem is caught by 'make sparse'.

[OK, I have to write the patch, test, etc. manually, but that's
not a great burden.]

ATB,
Ramsay Jones
