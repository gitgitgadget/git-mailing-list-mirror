From: Michael Fallows <michael@fallo.ws>
Subject: Re: [PATCH v2] git.c: Remove unnecessary new line
Date: Sun, 10 Mar 2013 00:10:45 +0000
Message-ID: <513BCF85.7050605@fallo.ws>
References: <513BB4A2.8000407@fallo.ws> <20130310000023.GI3908@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 01:11:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UETrC-0006pk-UN
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 01:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab3CJAKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 19:10:53 -0500
Received: from uk-dedi-rs-01.svrz.com ([87.117.195.124]:45219 "EHLO
	uk-dedi-rs-01.svrz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3CJAKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 19:10:52 -0500
Received: from cpc9-tilb8-2-0-cust26.basl.cable.virginmedia.com ([62.31.243.27]:56986 helo=[192.168.1.222])
	by uk-dedi-rs-01.svrz.com with esmtpa (Exim 4.80)
	(envelope-from <michael@fallo.ws>)
	id 1UETqe-0008HI-6m; Sun, 10 Mar 2013 00:10:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130310000023.GI3908@elie.Belkin>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - uk-dedi-rs-01.svrz.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fallo.ws
X-Get-Message-Sender-Via: uk-dedi-rs-01.svrz.com: authenticated_id: michael@htmlland.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217776>

On 10/03/13 00:00, Jonathan Nieder wrote:
> Hi,
>
> Michael Fallows wrote:
>
>> --- a/git.c
>> +++ b/git.c
>> @@ -316,8 +316,7 @@ static void handle_internal_command(int argc, const char **argv)
>>   		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>>   		{ "check-ref-format", cmd_check_ref_format },
>>   		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>> -		{ "checkout-index", cmd_checkout_index,
>> -			RUN_SETUP | NEED_WORK_TREE},
>> +		{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },
>
> This wrapped line was introduced a while ago (4465f410, checkout-index
> needs a working tree, 2007-08-04).  It was the first line to wrap, but
> it was also the longest line at the time.
>
> Now the longest line is
>
> 		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
>
> (94 columns), so you are right that consistency would suggest dropping
> the line wrapping for checkout-index.
>
> But I find it hard to convince myself that alone is worth the churn.
> In what context did you notice this?  Is the intent to help scripts to
> parse the commands[] list, or to manipulate it while preserving
> formatting to avoid distractions?  Did you notice the broken line
> while reading through and get distracted, or did some syntax
> highlighting tool notice the oddity, or something else?
>
> Hope that helps,
> Jonathan
>

I do agree with you it does seem like a silly small change in the 
context of the project! I noticed it when reading through the source 
code (I felt working with git is nice but why not see what makes it 
tick). I will admit also, have never contributed to git and my C is 
nowhere near the standard worthy of any real contribution so this was 
also a step for me to see exactly how the world of patch contribution 
works too :D.

Thanks,
Michael
