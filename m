From: Richard Rossel <rrossel@inf.utfsm.cl>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 13:10:25 -0300
Message-ID: <4B266371.9040106@inf.utfsm.cl>
References: <4B264F7B.8070504@inf.utfsm.cl> <200912141655.01268.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 17:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKDVN-0004Ij-TS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672AbZLNQKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 11:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757668AbZLNQKc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:10:32 -0500
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:56343 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757663AbZLNQKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 11:10:31 -0500
Received: from trompe.intra.wiseocean.cl (red-corfo.tecnoera.net [200.24.238.226] (may be forged))
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id nBEGAPgt006867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 13:10:25 -0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <200912141655.01268.johan@herland.net>
X-Virus-Scanned: ClamAV 0.94.2/10164/Mon Dec 14 10:49:22 2009 on alegre.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RDNS_NONE
	autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alegre.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135222>

>
> On Monday 14 December 2009, Richard Rossel wrote:
>    
>> Hi,
>> I have a question related to the output of git gc logs. Let me
>> explain,
>>
>> [...]
>>
>> I realized that the message are sent to standard error,
>> so the question is why is the reason to do that?
>>
>> The quick solution to my problem of annoying mails is send the output
>> error to /dev/null
>> but what happens when an error really occur, there will be no message
>> to alert me.
>>      
> Try the --quiet parameter to "git gc" (and other git commands).
>
>
> ...Johan
>
>    


Yes,  the quiet option works when I do 'git gc', but in the cron file 
there is no
git-gc command, only fetch and reset. I suppose that  those commands 
calls (internally)
to git-gc.
Also I try with -q option in fetch and reset but without results, the 
only thing that
works was with 2>/dev/null, but as I mention before, is not a good idea 
because
I will miss the real errors messages.

The real question here is why git-gc send those logs to the standard 
error instead of
standard output?

--
Richard Rossel
Airsage Inc.
Valparaiso - Chile
