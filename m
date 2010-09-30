From: Dennis Huynh <dennis@brainstorm-digital.com>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Thu, 30 Sep 2010 18:44:20 -0400
Message-ID: <4CA512C4.5090003@brainstorm-digital.com>
References: <4CA3EFE6.2010306@brainstorm-digital.com> <20100930024059.GA2373@burratino> <4CA41FCC.8050704@kernel.org> <4CA49D39.1020403@brainstorm-digital.com> <4CA510AA.2010908@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 01 00:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Rra-0001i7-Gd
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab0I3WoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 18:44:22 -0400
Received: from omr7.networksolutionsemail.com ([205.178.146.57]:47033 "EHLO
	omr7.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756936Ab0I3WoV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 18:44:21 -0400
Received: from cm-omr8 (mail.networksolutionsemail.com [205.178.149.5] (may be forged))
	by omr7.networksolutionsemail.com (8.13.6/8.13.6) with ESMTP id o8UMiKZM001335
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 18:44:20 -0400
Authentication-Results: cm-omr8 smtp.user=dennis@brainstorm-digital.com; auth=pass (CRAM-MD5)
X-Authenticated-UID: dennis@brainstorm-digital.com
Received: from [38.117.157.152] ([38.117.157.152:11722] helo=[192.168.1.119])
	by cm-omr8 (envelope-from <dennis@brainstorm-digital.com>)
	(ecelerity 2.2.2.41 r(31179/31189)) with ESMTPA
	id F9/58-22505-4C215AC4; Thu, 30 Sep 2010 18:44:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4CA510AA.2010908@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157719>

Its fine.  I'm going with the EPEL repo to start and learn from. If this 
can be upgraded in the near future that would be dandy.  If not, I 
should have a handle on maintaining a repository by then and be able to 
build the latest and greatest myself.  Because of my inexperience with 
maintaining this type of technology, I didn't realize the projectroot 
was not consistent throughout the documentation.  Had I known, I 
would've had an easier time, but doubt I'd have a working server up by 
now.  Not that I have a working server up right now, but I'm getting 
closer than I was yesterday.  If I have any questions I will be sure to 
ask and when I understand more, hopefully I'll be able to contribute 
better documentation myself as to where the original led me astray.  
Thanks again for following up.  I'm sure you'll hear from me again if 
you don't mind.


On 9/30/10 6:35 PM, J.H. wrote:
> On 09/30/2010 07:22 AM, Dennis Huynh wrote:
>    
>> Alright, I'm going with the Fedora EPEL repositories.  But last I
>> checked the latest version available via that method was 1.5.x.  Since
>> this is a server, I preferred to use the latest and greatest so to last
>> in the long run from any major patches or cover any major upgrades, but
>> if that's the version that's preferred, who am I to argue.  One problem
>> I recall in yum'ing the install for git however was the man pages
>> weren't installed either.  I could be wrong however.  I'll keep you guys
>> up to date.  Wish me luck!  Thanks for all your help and the timely
>> responses.
>>      
> The stuff in EPEL is a bit older, I should have words with whoever is
> maintaining those to see if we can get those upgraded.  There really
> isn't any reason those should be lagging that much.
>
> This is however why I suggested just recompiling the rpms present on
> kernel.org, which would get you the latest and greatest and not,
> completely, push you into maintaining the packages on your own.
>
>    
>> Also, is there how-tos you'd suggest I use in setting up the git/gitweb
>> combo with the yum install?  I noticed yum installs files in different
>> locations then the source does.  Thanks again!
>>      
> They install into different locations though the instructions should be
> relatively straight forward.
>
> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=blob;f=gitweb/README;h=ad6a04c464075c31afe3c67222f0bdeabc76f569;hb=HEAD
>
> is the official documentation, but a quick glance at it shows that it
> doesn't stay consistent on where the the document root is.  If you have
> problems give me a holler and I'll throw up how I have it configured at
> kernel.org on the kernel.org wiki as a reference point for people to a
> specific installation.
>
> - John 'Warthog9' Hawley
>
>
>    
