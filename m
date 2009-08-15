From: Mark A Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] git-instaweb: fix mod_perl detection for apache2
Date: Sat, 15 Aug 2009 12:09:34 -0400
Message-ID: <3300D840-9BAB-4233-B949-6A5B300CD9A8@mailservices.uwaterloo.ca>
References: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca> <7vprb45ty7.fsf@alter.siamese.dyndns.org> <m3iqgwoxq7.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 18:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McLvZ-0004V4-Fs
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 18:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbZHOQJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 12:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbZHOQJl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 12:09:41 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:49649 "EHLO
	minos.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbZHOQJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 12:09:40 -0400
Received: from [192.168.26.150] (dhcp-0-c-6e-25-56-e4.cpe.powergate.ca [24.239.6.123])
	(authenticated bits=0)
	by minos.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7FG9ZpB009045
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 15 Aug 2009 12:09:38 -0400
In-Reply-To: <m3iqgwoxq7.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.936)
X-UUID: 724570bf-ab85-4393-9e6c-dbed18f429fb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126009>

Does this means it may be taken off the menu in the not too distant  
future or
deprecated?

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


On 10-Aug-09, at 4:55 AM, Jakub Narebski wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Mark A Rada <marada@uwaterloo.ca> writes:
>>
>>> The script was looking for something that matched the '^our $gitbin'
>>> regex, which no longer exists in gitweb.cgi.
>>>
>>> Now it looks for 'MOD_PERL', which should be on the line that checks
>>> to see if the script is running in a mod_perl environment.
>>
>> Thanks.  That sounds like an ancient bug that in turn perhaps  
>> suggests
>> nobody uses instaweb.  Will apply to 'maint'..
>
> Hmmm... taking a peek at current "Git User's Survey 2009" results
> http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
>
> 11. What Git interfaces, implementations, frontends and tools do you
>    use?
>
>    git-instaweb  	3%  	77 / 2712
>
> 16. How often do you use the following forms of git commands or extra
>    git tools?
>
>    git instaweb
>      never:     1983 - 79%
>      rarely:     208 -  8%
>      sometimes:   50 -  2% 	
>      often:        9 -  0% 	
>
>    Total respondents  	 2506
>
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
