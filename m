From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 09:05:49 -0500
Message-ID: <491AE2BD.7080103@wellfleetsoftware.com>
References: <4919EECB.7070408@wellfleetsoftware.com>
 <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 15:07:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0GN8-0007yX-S9
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 15:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbYKLOFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbYKLOFv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 09:05:51 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:39697 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYKLOFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 09:05:50 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA800HKB4HPUGC7@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Nov 2008 08:05:49 -0600 (CST)
In-reply-to: <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100749>

Jonas Fonseca wrote:
...
>   
>> Now I am wondering where to begin to learn how to do the equivalent of the
>> following commands via the gjit Java API:
>>
>>   * git add /file/
>>   * git rm /file/
>>   * git mv /file
>>   * Whatever is the git way to get a specific version of a file
>>     
>
> JGit currently has two APIs for working with the index, which will
> allow you to add, remove and move data around in the tree. In nbgit I
> ended up using GitIndex, which I found easier to figure out. As I
> understand it, in the long run you want to use the DirCache API, but
> it is still a work in progress.
>   

I am happy to use GitIndex now and switch to DirCache API later when it 
is ready.
Can I please get some pseudo-code fragments on how to do the use cases I 
identified above?
The javadoc is still not obvious to me.
>   
>> I am hoping that there aremore docs, samples, tutorials etc. somewhere that
>> I am missing. Thanks for any help you can provide. Some pointers or code
>> fragments would be terrific.
>>     
>
> I started working on a tutorial for JGit, but didn't get very far so
> it mostly consists of stub pages.
>
>  - http://code.google.com/docreader/#p=egit&s=egit&t=JGitTutorial
>
> I have been working on moving the tutorial to maven project before
> starting to write the more code heavy topics. This would make it
> possible to include code snippets in the tutorial, while also allowing
> to compile and test the examples.
>   

The wiki is an awesome resource even in its current state. Thank you.
I would be glad to help contribute improvements to wiki if you give me
write privilege. What I could do is take the help I get from the list and
then update wiki carefully as appropriate if you want me to help.

Thanks again to all of you for helping get me bootstrapped with gjit and 
git.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
