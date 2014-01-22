From: Gordon Freeman <freemanmtc@gmail.com>
Subject: Re: Workflow on git with 2 branch with specifc code
Date: Wed, 22 Jan 2014 13:00:35 -0200
Message-ID: <52DFDD13.1010109@gmail.com>
References: <52DFD2B6.4010809@gmail.com> <52DFD444.4010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 16:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5zda-0004pM-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbaAVPWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 10:22:38 -0500
Received: from mail-gg0-f175.google.com ([209.85.161.175]:33416 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbaAVPWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:22:38 -0500
Received: by mail-gg0-f175.google.com with SMTP id c2so3095330ggn.34
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=d8+Si/aH7THm71ScdjFRthOYplmINt2I5RM4WFDW2u4=;
        b=yKR7iume2DQSk0FP5OYpz1dCbZVnoH+vOaLfi+sudrkgAhfFafKhAa0CNbDe5jZUOJ
         0QRfUJ1QFVcDfExleQmwUYMRm6iH2xA+xEQAi7pfJ9g6FPX5KVPNGFbFQ5CMnDVuYVOP
         wJhz+gLI+/7sdV8sbKr0G+t5CVsNCmMFMfyKEhIZnR3nThtOmcD6Q127cs+7URPy4cSc
         O0uPKF+pEIJc/eAIFT0dehyR/KcIK5o4MhCF3xKX8ScsH6Uzi1qdEIkIN6K/DjLzqCOD
         BRQML/FDoESDYi86xZem7aVW/fOnLbAki7+LAJOD1V4jk6VmHcjZucynyAe9MI1ilG0W
         ppEA==
X-Received: by 10.236.117.144 with SMTP id j16mr2072380yhh.19.1390403795053;
        Wed, 22 Jan 2014 07:16:35 -0800 (PST)
Received: from pc14.intranet (201.22.212.107.static.gvt.net.br. [201.22.212.107])
        by mx.google.com with ESMTPSA id d32sm25029008yhq.27.2014.01.22.07.16.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 07:16:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <52DFD444.4010907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240829>

On 01/22/2014 12:23 PM, Gordon Freeman wrote:
> On 01/22/2014 12:16 PM, Gordon Freeman wrote:
>> Oh, sorry if i misunderstand you. My english is not so good.
>> it will be a pleasure if you could explain that.
>>
>> I did some research about topic branchs, and get a lot of useful info 
>> of workflows on the way that you suggest.
>> I did a lot of tests from the info that i got, most of it from 
>> https://github.com/dchelimsky/rspec/wiki/topic-branches
>> what i got here from the site is pretty the same of what you wrote 
>> about i think. and the results are pretty good so far.
>> On the processes i did'nt loose any info, i got some conflicts but 
>> all of them easily solved.
>>
>>
>> 2014/1/20, Gordon Freeman <freemanmtc@gmail.com> wrote:
>> Oh, sorry if i misunderstand you. My english is not so good.
>> it will be a pleasure if you could explain that.
>> Tanks and sorry for you trouble so far.
>>
>>
>>     2014/1/18 Jon Seymour <jon.seymour@gmail.com>
>>
>>         Actually, it wasn't the rebasing I was going to explain, but
>>         a good process for using rebase and preserving the history of
>>         the original, integrated client branch after you have rebased
>>         it. There are good ways and less good ways to do this.
>>
>>         jon.
>>
>>
>>         On Sun, Jan 19, 2014 at 3:07 AM, Gordon Freeman
>>         <freemanmtc@gmail.com> wrote:
>>
>>             Hello!
>>             Thx you all guys for the help. That's no need more
>>             explanations here for rebases Jon.
>>             I alredy do a lot of  this when i need to change configs
>>              of databases and domains and other things,
>>             of my local branch to do some tests, so this is ok for me.
>>             Seems that i just need some. some people organization here.
>>             I will get that info that you guys provide to our devel
>>             group and aply that.
>>
>>             Thaks you all for the help.
>>
>>             On 18/01/2014 01:30, Jon Seymour wrote:
>>
>>                 On Sat, Jan 18, 2014 at 10:05 AM, brian m. carlson
>>                 <sandals@crustytoothpaste.net> wrote:
>>
>>                     On Fri, Jan 17, 2014 at 10:14:28AM -0200, Gordon
>>                     Freeman wrote:
>>
>>                         Hello guys, im Gordon. I have a question
>>                         about workflow with git that i dont know if
>>                         im doing it right. I have 1 repo with 2
>>                         branchs the first is the master of the
>>                         project. the second is a branch copy of the
>>                         master but he need to have some specifc code
>>                         because is code for a client. so, every time
>>                         that i updade master i need to merge master
>>                         with client branch and it give me conflicts
>>                         of course that will hapen. Well if was just
>>                         me who work on this 2 branchs it will be easy
>>                         to fix the conflicts and let all work and
>>                         shine. But whe have here, 10 people woking on
>>                         master branch and some times code are lost on
>>                         merge and we need to look on commits to
>>                         search whats goin on. What i just asking here
>>                         is if its correct the workflow that i do. If
>>                         for some problem like this, the community
>>                         have a standard resolution. Or if what im
>>                         doing here is all wrong.
>>
>>                     There are many correct workflows. I personally
>>                     use the workflow you've mentioned for the exact
>>                     same reason (customizations for a client), but
>>                     I'm the only developer on that repository.
>>
>>                 I agree with Brian that there are many correct
>>                 workflows and which one you choose does depend on
>>                 details of the branches you are trying to manage.
>>                 Myself, I would tend to avoid a workflow in which you
>>                 continually merge from master into the client branch.
>>                 The reason is that once you have done this 20 times
>>                 or so it will become quite difficult to understand
>>                 how and why the client branch diverged from the
>>                 master branch. Yes, it is in the history, but
>>                 reasoning about diffs that cross merge points is just
>>                 hard. Assuming that there is not much actual
>>                 development on the client branch, but rather a
>>                 relatively small set of customizations to
>>                 configuration and things of that kind, then I would
>>                 tend to maintain the client changes as topic branch,
>>                 then maintain a client integration branch which
>>                 represents the merge between master and the client
>>                 topic branch. Changes that represent divergence of
>>                 the client from the master branch would be committed
>>                 to the client topic branch and then merged into the
>>                 client integration branch. Refreshes from master
>>                 would be merged into the integration branch. Commits
>>                 directly to the integration branch would be avoided
>>                 where possible. Once master has diverged from client
>>                 enough that there start to be frequent conflicts when
>>                 merging into the integration branch, then consider
>>                 rebasing the client topic branch onto the tip of
>>                 master branch and then repeat the cycle again. There
>>                 is some risk of history loss with this approach - a
>>                 later release of the client branch may not be a
>>                 direct descendent of an earlier release of the client
>>                 branch, but even this problem can be solved with
>>                 judicious use of merge -s ours after you have
>>                 successfully rebased the client topic branch. I can
>>                 expand on how you do this, if there is interest. jon.
>>
>>
>>
>
