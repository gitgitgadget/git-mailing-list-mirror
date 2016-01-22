From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH] completion: Add --word-diff-regex= to diff
Date: Fri, 22 Jan 2016 21:39:14 +0100
Message-ID: <56A29372.4050500@virtuell-zuhause.de>
References: <569FC542.2060504@virtuell-zuhause.de>
 <xmqqy4bj23a3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:39:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMiUP-0007a9-NV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 21:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbcAVUjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 15:39:22 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55605 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521AbcAVUjU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2016 15:39:20 -0500
Received: from pd9fad9ca.dip0.t-ipconnect.de ([217.250.217.202] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1aMiUI-0003WF-6j; Fri, 22 Jan 2016 21:39:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqy4bj23a3.fsf@gitster.mtv.corp.google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1453495160;3a2d1051;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284591>

Am 21.01.2016 um 01:18 schrieb Junio C Hamano:
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
>> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index ab4da7f..d2a08dd 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1169,7 +1169,7 @@ __git_diff_common_options="--stat --numstat
>> --shortstat --summary
>>  			--no-prefix --src-prefix= --dst-prefix=
>>  			--inter-hunk-context=
>>  			--patience --histogram --minimal
>> -			--raw --word-diff
>> +			--raw --word-diff --word-diff-regex=
>>  			--dirstat --dirstat= --dirstat-by-file
>>  			--dirstat-by-file= --cumulative
>>  			--diff-algorithm=
> 
> Thanks; the patch was word-wrapped, but I fixed it up and managed to
> apply.

Thanks for applying Junio, and sorry that you had to clean up my sloppyness.
