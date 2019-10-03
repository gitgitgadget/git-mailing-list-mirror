Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D70B1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 21:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfJCVxo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 3 Oct 2019 17:53:44 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:51976 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJCVxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 17:53:44 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iG92a-0004b7-7s; Thu, 03 Oct 2019 22:53:41 +0100
Subject: Re: [Outreachy] Outreachy internship program
To:     Emily Shaffer <emilyshaffer@google.com>,
        gespinoz gespinoz <gespinoz2019@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
References: <CAP_ANik21_mkUdqwd0YQS4VDa80AnqQ+Xa1jWsQ7ihnfyQymYw@mail.gmail.com>
 <CAJoAoZkq1=VfJ05J8L2AvJjp6GxoTNTF6pNFAzQ1rx+7LKk6bQ@mail.gmail.com>
 <CAP_ANinzBvysKE6QWUinmNzcvKqsRv10VSjFGChoK-0Nz4KT7Q@mail.gmail.com>
 <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6f993a81-9bb5-9d57-0876-45fb2f7e2705@iee.email>
Date:   Thu, 3 Oct 2019 22:53:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJoAoZ=5aK50T9ugMww9Po0whFUSfOYY4djVhUvCU_azn2SABA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10/2019 21:35, Emily Shaffer wrote:
> Hi George, it sounds like you are probably using Git for Windows
> (https://github.com/git-for-windows/git).
>
> I'm actually not very familiar with how folks who primarily use GfW as
> their client manage their contributions to the main Git project.
> However, I know there are plenty - the GfW maintainer is an active
> contributor upstream.
>
> I'm CCing the Git mailing list as well as the GfW maintainer in the
> hopes that you can get some help from somebody who regularly uses the
> workflow you're trying to achieve. :)
>
> Unfortunately I use Linux everywhere and so I can't try to replicate
> what you're doing - but once you have a good workflow and are able to
> finish the My First Contribution tutorial we should still be able to
> work together.
>
> Can you be specific about which "official website" you downloaded Git
> from (share a URL), and paste the command you run and error message
> you receive? Please also share the output you see when you run "uname
> -a" in Git Bash.

Hi,
The top level domain would be https://gitforwindows.org/

The download button should give the same pure run-time as the git-scm 
website.

However for this case you should go via the "Contribute" button to get 
the full Windows SDK that will provide all those missing items for a 
reasonable compile experience (including 'make' !). The SDK and the 
regular 'Program Files' Git are independent so can both be used.

I tend to develop on to of the patched Windows version of git, and 
usually there is enough separation that the patches transfer direct to 
the Linux upstream.

HTHs

Philip

>   - Emily
>
>
> On Thu, Oct 3, 2019 at 12:40 PM gespinoz gespinoz
> <gespinoz2019@gmail.com> wrote:
>> Hello,
>>
>> Great! Thanks for the tips Emily! This mentor and internship program sounds awesome which is why I decided to apply. I’ll look through it to see if there’s a specific micro project available later on today and run it through you.
>>
>> I am having one slight issue, I’m not sure why I can’t use the “make” command to run Makefile, I’ve done it at school in the past so I was a bit familiar with Makefile and how it helps compile things. This is what I did. I downloaded git from the official git website, installed it, then I found the repository link and I cloned it in the git bash client to my desktop. I’m using windows at home but at school I used an iMac and when I cloned repositories I used iTerm and pushed to git within iTerm. I’m guessing the git bash is similar since I was able to open and edit files using vim commands similar in iTerm when I was going through the walkthrough. So now I’m stuck on the “make” step to see if I added the psuh feature in correctly. I also noticed when I looked at the INSTALL page on github it made it seem like maybe installing it through the website wasn’t the right idea? Maybe that’s why I can’t use make? I also can’t use man correctly. For both I get bash command does not exist. Should I install something similar to iTerm instead on windows and just start fresh? ty.
>>
>> George!
>>
>> On Thu, Oct 3, 2019 at 11:14 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>>> Hi George,
>>>
>>> Great to hear that you're walking through the MyFirstContribution
>>> tutorial - that's a great introduction to how the Git project gets
>>> stuff done.
>>>
>>> This is my first time mentoring for Outreachy, but as I understand it,
>>> you will start by doing a microproject so everybody can see if you are
>>> a good fit for the project. The community discussed the list of
>>> microprojects for applicants to try in this mailing list thread:
>>> https://public-inbox.org/git/20190916184208.GB17913@google.com/
>>> I don't think you need to wade through the replies on that thread to
>>> determine whether the microproject you are interested in is available,
>>> although you're certainly welcome to. You can also ask me if you see a
>>> microproject you are interested in and I will be happy to help
>>> summarize it and point you in the right direction :)
>>>
>>> It is also probably a good idea for you to search that mailing list
>>> archive for "[Outreachy]" so you can see what Outreachy interns have
>>> done in the past and try to emulate how they submitted finished
>>> microprojects.
>>>
>>> The tutorial you said you're reading covers how to send your
>>> contributions for review when you're done, but if you find you're
>>> having trouble or want someone to check that you've formatted it
>>> right, you can let me know!
>>>
>>>   - Emily
>>>
>>> On Wed, Oct 2, 2019 at 9:55 PM gespinoz gespinoz <gespinoz2019@gmail.com> wrote:
>>>> Hello Emily,
>>>>
>>>> How are you? My name is George Espinoza and I am one of the applicants in the Outreachy internship program. I hope you are doing well! I wanted to introduce myself and connect as I am interested in the Git open source project that you are mentoring. I'm currently creating my work environment and tinkering with the git program while doing the myfirstcontribution walk-through. I have had a bit of experience using git for a school i attended over the summer that used it for clone and pushing repositories. We worked with iTerm and I learned how to use vim as well. I know some basics, in no way a master yet/ I hope to learn more as I progress in making contributions!
>>>>
>>>> After I set up my environment I will join the IRC channel and introduce myself in the project's public chat and go from there searching how and what I should first contribute.  I'll also join the mailing list. If you have any tips or advice that would be great! I'm looking forward to working with you and learning more about Open Source Projects! Thank you.
>>>>
>>>> sincerely,
>>>> George Espinoza


