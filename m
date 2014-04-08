From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Tue, 08 Apr 2014 15:13:38 +0200
Message-ID: <5343F602.8080007@kdbg.org>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org> <5342EFD4.6020007@kdbg.org> <CACsJy8A0oNRZ45xLvGTDPmDu0ZEAyHbdQBt2gdyo1yUtUeeB_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2U=?= =?UTF-8?B?bg==?= 
	<tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 15:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXVqb-0004SB-FK
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 15:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbaDHNNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 09:13:47 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:31722 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932136AbaDHNNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 09:13:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E6B3BA7EB3;
	Tue,  8 Apr 2014 15:13:39 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4EAB519F40F;
	Tue,  8 Apr 2014 15:13:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CACsJy8A0oNRZ45xLvGTDPmDu0ZEAyHbdQBt2gdyo1yUtUeeB_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245924>

Am 08.04.2014 02:39, schrieb Duy Nguyen:
> On Tue, Apr 8, 2014 at 1:35 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 05.04.2014 11:19, schrieb Johannes Sixt:
>>> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>>>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>>>  - Enable index-pack threading in msysgit.
>>>>
>>>>  What is the status of this topic?  A failure report exists
>>>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>>>  where the discussion stalled.  Is everybody waiting for everybody
>>>>  else to get the discussion unstuck?
>>>
>>> I still have to cross-check Duy's patch. I'll hopefully get to it in the
>>> next days and report back.
>>
>> The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
>> with this patch with a MinGW build.
> 
> Is "this patch" the one on 'pu', or mine?

"This patch" is the one on pu (sz/mingw-index-pack-threaded). I'm sorry
for the confusion.

-- Hannes
