From: Paul Walker <PWalker752@aol.com>
Subject: Re: installation issue when building with NO_CURL=YesPlease
Date: Wed, 26 May 2010 15:41:36 +0100
Message-ID: <24D3B56E-0EA0-4E1C-BF42-F5BF71891F78@aol.com>
References: <5B1E2CF0-4BC4-43FF-A372-EB3582DA6286@aol.com> <4BFD290B.6050502@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 26 21:06:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHLw5-0003xf-N7
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab0EZTGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 15:06:32 -0400
Received: from omr-d33.mx.aol.com ([205.188.249.131]:47451 "EHLO
	omr-d33.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab0EZTGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 15:06:32 -0400
Received: from oms-db02.r1000.mx.aol.com (oms-db02.r1000.mx.aol.com [205.188.58.2])
	by omr-d33.mx.aol.com (8.14.1/8.14.1) with ESMTP id o4QJ4b8B019942;
	Wed, 26 May 2010 15:05:08 -0400
Received: from mtaout-da05.r1000.mx.aol.com (mtaout-da05.r1000.mx.aol.com [172.29.51.133])
	by oms-db02.r1000.mx.aol.com (AOL Outbound OMS Interface) with ESMTP id CB6EB1C0001A6;
	Wed, 26 May 2010 15:04:38 -0400 (EDT)
Received: from [192.168.0.3] (unknown [92.30.139.179])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-da05.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id 2950BE000093;
	Wed, 26 May 2010 15:04:38 -0400 (EDT)
In-Reply-To: <4BFD290B.6050502@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.936)
x-aol-global-disposition: S
X-SPAM-FLAG: YES
X-AOL-SCOLL-SCORE: 0:2:441332928:93952408  
X-AOL-SCOLL-URL_COUNT: 0  
x-aol-sid: 3039ac1d33854bfd70c60efa
X-AOL-IP: 92.30.139.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147821>


On 26 May 2010, at 14:58, Michael J Gruber wrote:

> Paul Walker venit, vidit, dixit 26.05.2010 15:35:
>> As I could not find any bug reporting information on the wiki I
>> thought I would mention this here, please let me know if there is a
>> better forum for bug reports.  I believe the latest git release
>> (1.7.1.) has an installation bug when building with
>> "NO_CURL=YesPlease".  Looking at the Makefile line 1999 it reads
>>
>> for p in $(REMOTE_CURL_ALIASES); do
>>
>> which results in "/bin/sh: syntax error at line 1 : `;' unexpected"  
>> as
>> REMOTE_CURL_ALIASES is empty.
>
> That seems to depend on the shell. My bash 4.1.2 doesn't care. What  
> does
> /bin/sh --version say for you?
>
> Michael

I am struggling to work this out as my version of sh does not support  
the --version flag.
I tried a bunch of other options provided by google with not success.
If it helps I believe that /bin/sh is a version of ksh that comes with  
AIX 6.1
