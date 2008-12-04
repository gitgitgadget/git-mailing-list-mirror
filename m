From: Adrian Klingel <Adrian.Klingel@illumaware.com>
Subject: Re: git rebase --continue with goofy error
Date: Thu, 4 Dec 2008 11:24:37 -0500
Message-ID: <49EAD7F5-F087-4674-9046-47DDD6F96CB2@illumaware.com>
References: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com> <9F631552-BA29-4A85-9A85-2992232CDDE6@railsnewbie.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 17:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8H1e-0007WI-AA
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbYLDQYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 11:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbYLDQYo
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 11:24:44 -0500
Received: from outmail137144.authsmtp.net ([62.13.137.144]:49477 "EHLO
	outmail137144.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751382AbYLDQYo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 11:24:44 -0500
Received: from mail-c189.authsmtp.com (mail-c189.authsmtp.com [62.13.128.71])
	by punt9.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id mB4GOgwL092094
	for <git@vger.kernel.org>; Thu, 4 Dec 2008 16:24:42 GMT
Received: from [192.168.1.4] (nc-67-239-173-206.dhcp.embarqhsd.net [67.239.173.206] (may be forged))
	(authenticated bits=0)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id mB4GOeEZ047011
	for <git@vger.kernel.org>; Thu, 4 Dec 2008 16:24:41 GMT
In-Reply-To: <9F631552-BA29-4A85-9A85-2992232CDDE6@railsnewbie.com>
X-Mailer: Apple Mail (2.753.1)
X-Server-Quench: 0db5f153-c220-11dd-bc7a-001f29070be2
X-AuthRoute: OCdxYg8WBFZcQB4b AyVCDytBTwooIjVN BRseKAJFKUAEEw9W N1BVL0Z7LlIRXxda ViRVDghKDx8mF2Nx dH4EPhpfYkpGTwRs WkpNSFZTWgNvHx4C DwAfVRpsdQVAZ3x1 Z0N9Xj4GLkANChMI KE5QEm0HZClkb2Af HkAMJQYCcQZJY0xH aFBiVXJZNXhVNX0x WldrZj5rbG0AcC5Y GBc3IABaTkcXViQx TRkZEH1qWEYCQTky KQErYkEdAEZZPUI1 P0ppVEgCNAV6
X-Authentic-SMTP: 61633232373337.kestrel.dmpriest.net.uk:1378/Kp
X-Report-SPAM: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system!
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102346>

That's the problem.  I've resolved the conflicts, added everything.   
Then I run git rebase --continue and that's what I get.  After I do  
the adds, am I supposed to commit them?

Adrian Klingel
President/CEO
Illumaware, LLC

Adrian.Klingel@illumaware.com
phone:  800.880.4964
outside US: 919.783.4037
fax: 919-882.9447




On Dec 4, 2008, at 10:52 AM, Scott Taylor wrote:

>
> On Dec 4, 2008, at 9:55 AM, Adrian Klingel wrote:
>
>> I am trying so, so hard to rebase a branch with updates made in  
>> master:
>>
>> *********
>> git rebase master
>> *********
>>
>> I get about 20 conflicts back, which I fix and do:
>>
>> *********
>> git add *
>> *********
>>
>> There were also many, many error messages after the rebase  
>> command, eg:
>>
>> *********
>> error: test/unit/missing_year_test.rb: already exists in index
>> error: test/unit/axle_test.rb: already exists in index
>> error: test/unit/body_style_test.rb: already exists in index
>> error: test/unit/brake_test.rb: already exists in index
>> error: test/unit/category_test.rb: already exists in index
>> error: test/unit/comment_test.rb: already exists in index
>> error: test/unit/company_comment_test.rb: does not exist in index
>> error: test/unit/country_test.rb: already exists in index
>> *********
>>
>>
>> but I ignore that error, because I have no idea what it means.  If  
>> I were to guess, I'd say it's trying to copy files from master to  
>> my current branch.  Of course.
>>
>> So now I have added my conflict fixes, per the message:
>>
>> *********
>> Failed to merge in the changes.
>> Patch failed at 0002.
>>
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase -- 
>> skip".
>> To restore the original branch and stop rebasing run "git rebase -- 
>> abort".
>> *********
>>
>>
>> So I decide to continue:
>>
>> *********
>> git rebase --continue
>> *********
>>
>>
>> And I get the following:
>>
>> *********
>> mymac:/Library/mydir/code/myapp me$ git rebase --continue
>> Unknown option: 1
>> Usage: head [-options] <url>...
>>    -m <method>   use method for the request (default is 'HEAD')
>>    -f            make request even if head believes method is illegal
>>    -b <base>     Use the specified URL as base
>>    -t <timeout>  Set timeout value
>>    -i <time>     Set the If-Modified-Since header on the request
>>    -c <conttype> use this content-type for POST, PUT, CHECKIN
>>    -a            Use text mode for content I/O
>>    -p <proxyurl> use this as a proxy
>>    -P            don't load proxy settings from environment
>>    -H <header>   send this HTTP header (you can specify several)
>>
>>    -u            Display method and URL before any response
>>    -U            Display request headers (implies -u)
>>    -s            Display response status code
>>    -S            Display response status chain
>>    -e            Display response headers
>>    -d            Do not display content
>>    -o <format>   Process HTML content in various ways
>>
>>    -v            Show program version
>>    -h            Print this message
>>
>>    -x            Extra debugging output
>> Applying
>> You still have unmerged paths in your index
>> did you forget to use 'git add'?
>>
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase -- 
>> skip".
>> To restore the original branch and stop rebasing run "git rebase -- 
>> abort".
>>
>> *********
>>
>>
>> A google search of "git" and "Unknown option: 1" yields zero  
>> results.  Notice I did not commit the adds.  I didn't think it  
>> made sense to do that, since I imagine that is what the rebase is  
>> doing anyway?
>>
>
> I'm not sure what the first part of this is saying (The "unknown  
> option").
>
> The important part is later on:
>
> You still have unmerged paths in your index
> did you forget to use 'git add'?
>
> After you resolve any conflicts, make sure to git add any remaining  
> files before you "rebase --continue"
>
> Regards,
>
> Scott
>
>
