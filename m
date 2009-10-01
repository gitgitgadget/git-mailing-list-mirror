From: Jason van Zyl <jason@sonatype.com>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Thu, 1 Oct 2009 06:55:16 -0700
Message-ID: <AA4C92B2-36CB-48A0-A373-AA4012AB2C05@sonatype.com>
References: <138076.57408.qm@web27806.mail.ukl.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonas Fonseca <jonas.fonseca@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Thu Oct 01 15:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtM83-0000sG-5p
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 15:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503AbZJANzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 09:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbZJANzQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 09:55:16 -0400
Received: from 63-246-20-110.contegix.com ([63.246.20.110]:53049 "EHLO
	sonatype01.sonatype.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbZJANzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 09:55:14 -0400
Received: (qmail 23280 invoked by uid 89); 1 Oct 2009 13:55:18 -0000
Received: from unknown (HELO ?10.0.1.201?) (jason@maven.org@98.248.33.49)
  by 63-246-20-110.contegix.com with ESMTPA; 1 Oct 2009 13:55:18 -0000
In-Reply-To: <138076.57408.qm@web27806.mail.ukl.yahoo.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129392>

Sorry, what do you want?

A fork of the EGit repository with the EGit specific changes we have  
made to use Tycho to build EGit?

Or do you want a fork of the JGit repo with the Maven build (i.e. not  
Tycho) changes?

On 2009-10-01, at 4:15 AM, Mark Struberg wrote:

> Can you please create an EGit repo on github.com/sonatype and push  
> the JGit changes to a fresh branch in sonatype/JGit ?
>
> txs,
> strub
>
> --- On Thu, 10/1/09, Jason van Zyl <jason@sonatype.com> wrote:
>
>> From: Jason van Zyl <jason@sonatype.com>
>> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the  
>> initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de 
>> >
>> To: "Mark Struberg" <struberg@yahoo.de>
>> Cc: "Shawn O. Pearce" <spearce@spearce.org>, "Jonas Fonseca" <jonas.fonseca@gmail.com 
>> >, "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>, git@vger.kernel.org
>> Date: Thursday, October 1, 2009, 1:16 AM
>>
>> On 2009-09-30, at 4:13 PM, Mark Struberg wrote:
>>
>>> Hi!
>>>
>>> I now squashed all my changes into 2 commits and
>> omitted the eclipse parts. They are available at
>>>
>>> http://github.com/sonatype/JGit/commits/mavenize2
>>>
>>> As Shawn pointed out on IRC, the next step would be to
>> migrate this patch over to the eclipe.org-post branch which
>> I will do tomorrow evening.
>>>
>>
>> I also have a Tycho build for the EGIT part, and I have
>> bundle creation working for the JGIT part. I've already
>> integrated these two builds into our product so it all
>> works. I can put it somewhere as you're ready to absorb it
>> if you want it.
>>
>>> LieGrue,
>>> strub
>>>
>>> --- On Wed, 9/30/09, Shawn O. Pearce <spearce@spearce.org>
>> wrote:
>>>
>>>> From: Shawn O. Pearce <spearce@spearce.org>
>>>> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1:
>> moved over the initial poms  from Jasons branch
>> Signed-off-by: Mark Struberg <struberg@yahoo..de>
>>>> To: "Mark Struberg" <struberg@yahoo.de>
>>>> Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>,
>> "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
>> git@vger.kernel.org,
>> "Jason van Zyl" <jvanzyl@sonatype.com>
>>>> Date: Wednesday, September 30, 2009, 11:16 PM
>>>> Mark Struberg <struberg@yahoo.de>
>>>> wrote:
>>>>>> From: Jonas Fonseca <jonas.fonseca@gmail.com>
>>>>>> actually
>>>>>> removes features (by not keeping the JGit
>>>> specific
>>>>>> settings), which
>>>>>> you then try to amend later in the patch
>> series.
>>>>>
>>>>> I'm not sure what JGit specific settings you
>> speak
>>>> about?
>>>>
>>>> I think he's talking about the Eclipse settings
>>>> files?  Or is it
>>>> something else?
>>>>
>>>>>> In terms of making the patch series more
>>>> manageable for
>>>>>> you, I think
>>>>>> the best approach is to start with the
>> patches
>>>> not relevant
>>>>>> to the
>>>>>> mavenizing (renaming PathSuffixTestCase).
>>>>>
>>>>> In fact the fix of the PathSuffixTestCase came
>> a few
>>>> days later
>>>>> after I found the reason why I miss a few
>> tests. This
>>>> should be
>>>>> fixed in the current master anyway and has not
>> so much
>>>> todo with
>>>>> the mavenization itself.
>>>>
>>>> But it should be earlier in the series because its
>> easier
>>>> to apply.
>>>> Use rebase -i to swap the order of the patches.
>>>>
>>>>> I had the following in mind: every single
>> commit
>>>> should be
>>>>>    compileable and working. So
>> it's not easily
>>>> manageable to move the
>>>>> directory structure in one patch and apply all
>> the
>>>> changes into
>>>>> the poms in another commit.
>>>>
>>>> Well, you need to edit the pom to change the
>> source
>>>> directory and do
>>>> the move in one commit, and then edit the pom
>> further in
>>>> another,
>>>> possibly removing the source directory directories
>> once it
>>>> is the
>>>> standard maven layout.
>>>>
>>>>> We could for sure squash the later few
>> commits, but I
>>>> didn't
>>>>> liked to rebase and push since there have been
>> a few
>>>> forks of the
>>>>> mavenize branch and I hoped I could pull back
>> a few
>>>> commits from
>>>>> others and later do a rebase -i.
>>>>
>>>> True.
>>>>
>>>> At this point we need to rebase the patches on the
>> new
>>>> history in
>>>> the eclipse.org-post branch, which contains a
>> massive
>>>> rename of
>>>> org.spearce to org.eclipse.  That may make
>> the tree
>>>> reorg patch in
>>>> your Maven series harder to bring over to the new
>> history,
>>>> sorry.
>>>>
>>>> Worse, we now have to start following the Eclipse
>> IP
>>>> process[1]
>>>> for submissions to JGit...
>>>>
>>>> [1] http://www.eclipse.org/projects/dev_process/ip-process-in-cartoons.php
>>>>
>>>> --Shawn.
>>>> --
>>>> To unsubscribe from this list: send the line
>> "unsubscribe
>>>> git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>>>
>>>
>>
>> Thanks,
>>
>> Jason
>>
>> ----------------------------------------------------------
>> Jason van Zyl
>> Founder,  Apache Maven
>> http://twitter.com/jvanzyl
>> ----------------------------------------------------------
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>

Thanks,

Jason

----------------------------------------------------------
Jason van Zyl
Founder,  Apache Maven
http://twitter.com/jvanzyl
----------------------------------------------------------
