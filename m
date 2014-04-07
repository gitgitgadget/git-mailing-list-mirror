From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Mon, 07 Apr 2014 20:42:44 +0100
Message-ID: <5342FFB4.3000200@ramsay1.demon.co.uk>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org> <5342EFD4.6020007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?VG9ycw==?= =?UTF-8?B?dGVuIELDtmdlcnNoYXVzZW4=?= 
	<tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 21:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFRW-0003L2-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbaDGTmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 15:42:49 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:46963 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753162AbaDGTms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 15:42:48 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 182D5A64604;
	Mon,  7 Apr 2014 19:42:28 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id DBC6FA64681;
	Mon,  7 Apr 2014 19:42:27 +0100 (BST)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Mon,  7 Apr 2014 19:42:27 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <5342EFD4.6020007@kdbg.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245901>

On 07/04/14 19:35, Johannes Sixt wrote:
> Am 05.04.2014 11:19, schrieb Johannes Sixt:
>> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>>  - Enable index-pack threading in msysgit.
>>>
>>>  What is the status of this topic?  A failure report exists
>>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>>  where the discussion stalled.  Is everybody waiting for everybody
>>>  else to get the discussion unstuck?
>>
>> I still have to cross-check Duy's patch. I'll hopefully get to it in the
>> next days and report back.
> 
> The test suite passes with Duy's patch ($gmane/245034), but t5302 fails
> with this patch with a MinGW build. The patches touch the Cygwin
> configuration, but I cannot test a Cygwin build.

I haven't tested these on cygwin yet. However, only the old version of
cygwin is affected (newer cygwin has a thread-safe pread) and, since I
no longer have an old installation, I _can't_ test it anyway. :(
(I updated cygwin earlier today and received a brand new cygwin dll
with today's date!).

> I have, however, lost track of what the objective of these patches is.
> Is the threaded version significantly faster, and these patches are
> worth it?

Indeed. I haven't seen any numbers.

ATB,
Ramsay Jones
