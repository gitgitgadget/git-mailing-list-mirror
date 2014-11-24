From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 22:59:34 +0000
Message-ID: <5473B856.5000205@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk>	<xmqqegstychq.fsf@gitster.dls.corp.google.com>	<54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de>	<5473A2D0.5010101@ramsay1.demon.co.uk> <xmqq7fykw9y5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2bl-0003La-BC
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbaKXW7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:59:45 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:38125 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750813AbaKXW7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:59:44 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F301C1280E0;
	Mon, 24 Nov 2014 22:59:42 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id ABAE01280BF;
	Mon, 24 Nov 2014 22:59:42 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Nov 2014 22:59:42 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqq7fykw9y5.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260164>

On 24/11/14 21:44, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> I updated from cygwin 1.5 to cygwin 1.7 at the beginning of the year.
>> Since it is no longer supported, I don't think we need to worry about
>> version 1.5. When I said 'old installation' I meant my old version 1.7
>> 32-bit installation.
>>
>>> One netbook was converted from XP to Linux, the other machine needs to be
>>> re-installed and CYGWIN 1.5 is no longer available for download.
>>>
>>> I can confirm that Ramsays patch works with CYGWIN 1.7 32 Bit.
>>
>> Thanks!
> 
> Thanks.  So the unconditional version of the patch is good to go, I
> take?
> 

Hmm, I don't know what you mean by 'unconditional version'. ;-)

Anyway, the commit message of my patch needs some edits to reflect
my new 'theory' of the cause. I suppose I should try to track down
the changes to the cygwin headers to be more confident that I have
actually identified the correct cause. (Like Jonathan, I'm still a
bit surprised that _GNU_SOURCE doesn't trump _XOPEN_SOURCE, but I
can't say that it is a bug).

However, I suspect that the patch as is, modulo commit message edits,
should be sufficient to fix this up (at least for now).

ATB,
Ramsay Jones
