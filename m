From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 09:59:38 +0200
Message-ID: <471C586A.9030900@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 10:00:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjsCX-0004Bq-Uc
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXJVH7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXJVH7n
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:59:43 -0400
Received: from mail.op5.se ([193.201.96.20]:54167 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbXJVH7m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:59:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B411C1730563;
	Mon, 22 Oct 2007 09:59:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GhR85eUb2ktK; Mon, 22 Oct 2007 09:59:40 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9498F1730561;
	Mon, 22 Oct 2007 09:59:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710212308540.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61969>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 21 Oct 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Sun, 21 Oct 2007, Jakub Narebski wrote:
>>>
>>>> On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>>
>>>>> Maybe we could group commands into more categories?
>>>>>
>>>>> plumbing: should be hidden from the 'normal' user. Porcelain
>>>>>    should be sufficient for every standard task.
>>>> The problem is division between what is porcelain and what is 
>>>> plumbing. Some commands are right on border (git-fsck, 
>>>> git-update-index, git-rev-parse comes to mind).
>>> Sorry, but my impression from the latest mails was that the commands 
>>> are fine.  What is lacking is a nice, _small_ collection of 
>>> recommended workflows.  And when we have agreed on such a set of 
>>> workflows, we optimize the hell out of them.  Only this time it is not 
>>> performance, but user-friendliness.
>> http://www.kernel.org/pub/software/scm/git/docs/everyday.html would be a 
>> good starting point, I think.
> 
> I don't think so.  Way too few authors were involved in writing this 
> document, so it is not "typical" in and of itself.
> 
> I'd really like people to respond not so much with broad and general 
> statements to my mail (those statements tend to be rather useless to find 
> how to make git more suitable to newbies), but rather with concrete top 
> ten lists of what they do daily.
> 
> My top ten list:
> 
> - git diff
> - git commit
> - git status
> - git fetch
> - git rebase
> - git pull
> - git cherry-pick
> - git bisect
> - git push
> - git add
> 
> So again, I'd like people who did _not_ tweak git to their likings to tell 
> the most common steps they do.  My hope is that we see things that are 
> good practices, but could use an easier user interface.
> 

I'm not so sure we'd want to hide commands that git-gurus simply do not 
use, such as git-blame. In my opinion, we should just locate the highest 
level available of UI tool that implements a particular feature and have 
that listed in the git[- ]<tab> view.

I doubt many people on this list regularly use git-blame but it's a 
command that's definitely non-trivial to script out using only the 
"proper" commands, and CVS/SVN users expect it to be there, so it's 
probably worth listing anyhow.

Similarly, it might be helpful to have help topics the gdb way, like 
"git help patches". It's one of those things that people have come to 
expect from a software tool, so perhaps we should humor them? Given gits 
"every help topic is a man-page" idiom, this shouldn't require any real 
technical effort.

Such topics should probably include
merge/merges/merging - overview of various ways of putting two lines of 
development back together
patch/patches - how to create, send and apply
tags/branches/refs - what they are, why they're good, link to merging

I'm currently swanked with day-job work, but I'll see if I can get some 
prototype docs done later this week and check if it requires any code 
support. If anyone's well-versed in asciidoc HTML-indexing and wants to 
provide pointers to what I should think about for generating those topic 
menus as html docs, feel free to chuck me an email.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
