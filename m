From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] .gitignore: Ignore editor backup and swap files
Date: Thu, 16 Jan 2014 22:56:47 +0000
Message-ID: <52D863AF.30506@ramsay1.demon.co.uk>
References: <1389907164-13400-1-git-send-email-alexander@plaimi.net> <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Berntsen <alexander@plaimi.net>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3vrt-00085e-1n
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbaAPW4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:56:52 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:49557 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750750AbaAPW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 17:56:51 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 1335A384082;
	Thu, 16 Jan 2014 22:56:50 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id DB6F0384081;
	Thu, 16 Jan 2014 22:56:49 +0000 (GMT)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 16 Jan 2014 22:56:48 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqtxd3y43b.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240545>

On 16/01/14 22:06, Junio C Hamano wrote:
> Alexander Berntsen <alexander@plaimi.net> writes:
> 
>> Signed-off-by: Alexander Berntsen <alexander@plaimi.net>
>> ---
>>  .gitignore | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index b5f9def..2905c21 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -240,3 +240,5 @@
>>  *.pdb
>>  /Debug/
>>  /Release/
>> +*~
>> +.*.swp
> 
> I personally do not mind listing these common ones too much, but if
> I am not mistaken, our policy on this file so far has been that it
> lists build artifacts, and not personal preference (the *.swp entry
> is useless for those who never use vim, for example).
> 
> These paths that depend on your choice of the editor and other tools
> can still be managed in your personal .git/info/exclude in the
> meantime.

As a vim user, I have these set in my ~/.gitignore file, which I refer
to from ~/.gitconfig using core.excludesfile. ;-)


ATB,
Ramsay Jones
