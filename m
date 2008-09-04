From: Federico Lucifredi <flucifredi@acm.org>
Subject: Re: Suggestion: "man git clone"
Date: Wed, 03 Sep 2008 22:22:26 -0400
Message-ID: <48BF4662.9000305@acm.org>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb4VX-0007bk-BZ
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 04:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbYIDCWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 22:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYIDCWc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 22:22:32 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:51497 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYIDCWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 22:22:32 -0400
Received: (qmail 30168 invoked from network); 4 Sep 2008 02:22:29 -0000
Received: from dsl092-066-189.bos1.dsl.speakeasy.net (HELO spaceman.local) (federico@[66.92.66.189])
          (envelope-sender <flucifredi@acm.org>)
          by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <hpa@zytor.com>; 4 Sep 2008 02:22:29 -0000
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48ADE2FF.4080704@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94879>

Hello HP, All,
  I somehow managed to forget this (age must be taking its toll), but 
there is a convention commonly used for man pages of Perl Modules, which 
can be reasonably usable for subcommands as well:

  man APR::Brigade

will work just fine, with a file by the same name. This convention is in 
current use, and would map to

  man git::clone

while :: is not as immediate in context as in Perl, it does do the job, 
and works regardless of pager.

  I would still go with the single big page (people are used to 
vi-search with "/" anyway), but if you want to split the manual this 
would work, and you could refer to the pages explicitly in the main git 
page.

  Finally, and importantly, "apropos clone" or "man -k clone" would 
correctly point to git::clone as a valid result.

  One more option for you.

  Best -F

Federico Lucifredi wrote:
> Hello HP,
>  I have seen this in (funnily enough) a project I manage myself, which 
> has subcommands structured similarly to Git.
> 
>  I have looked at options, but so far the current behavior (man foo-bar) 
> seems the best option for foo's subcommand bar. The alternative, also 
> acceptable, is a large page with subsections for each command. Sections 
> (man 1) are used for chapter-like page groupings, not for subsections on 
> a single command - those would have to be implemented as an additional 
> layer.
> 
>  But, as another participant in the thread has commented, that would not 
> port to other platforms very quickly (although it would get to Linux and 
> OS-X promptly, and may eventually make its way into other platforms).
> 
>  I am open to ideas, but so far the two options above are better than 
> anything else that has been so far suggested...
> 
>  Best -F
> 
> H. Peter Anvin wrote:
>> Given the recent change of "git-foo" to "git foo", it would be really 
>> nice if one could type, for example:
>>
>>     man git clone
>>
>> and actually get the man page for the git clone command.  There are 
>> quite a few other pieces of software which also could benefit from 
>> that kind of indirection.
>>
>> Right now the above command shows the man page git(1) followed by 
>> clone(2), which I believe has be classified as utterly useless 
>> behaviour...
>>
>>     -hpa
> 
> 


-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - flucifredi@acm.org
