Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A4C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C6720739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 13:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFMNOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:14:35 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:52906 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgFMNOe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 09:14:34 -0400
Received: from host-89-243-191-101.as13285.net ([89.243.191.101] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jk5zT-00076q-5I; Sat, 13 Jun 2020 14:14:32 +0100
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email>
Date:   Sat, 13 Jun 2020 14:14:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2020 13:38, Curtin, Eric wrote:
> Both great ideas! And have the same theory right? Merge until you come across the first conflicting commit in a branch to make the conflicts smaller right?
I've also responded to the issue on GitHub:

"Do you have an implicit XY-problem where your processes are reinforcing
historical bad habits "we merge branches that have been forked for
months"? It sounds like the process is saying "We enjoy technical debt"
(of delaying the merge until it's really bad...).

Maybe have a parallel 'merge' branch that is used (say weekly) to do
trial merges and will essentially record the conflict resolutions while
they are fresh in folks memories. That branch is distinct from, either
of the two main branches, but will act as a filter and a hand rail to
highlight future difficulties."

Implicit in Git is the use of small patches, easy branching and frequent
merges, available to the individual coder. Most older "change control
systems" focus on *stopping* change. Git promotes change, because
reproduction & testing is cheap (almost zero). Git provides
*authentication* of code versions. The changes in the underlying
materials (from hardware to software), i.e. to bits and bytes, ripped up
the old rule book.

Also look at 'rerere'.
>
> Thanks so much for your help! Any alternative ideas? I'm definitely going to try both techniques, although imerge seems like an automation of the first idea.
>
> Anybody ever think of rewriting the imerge tool in C or whatever to get in merged into mainline git? Potentially I could do it as part of my masters thesis if Michael H and the git open source community agreed?
>
> Regards,
>
> Eric Curtin
>
> Software Engineer
> Ovens Campus,
> Cork,
> Ireland
>
> Dell EMC
>
> From: Christian Couder <christian.couder@gmail.com>
> Sent: Saturday 13 June 2020 13:08
> To: Curtin, Eric <Eric.Curtin@dell.com>
> Cc: git@vger.kernel.org <git@vger.kernel.org>; Geary, Niall <Niall.Geary@dell.com>; rowlands, scott <Scott.Rowlands@dell.com>; Michael Haggerty <mhagger@alum.mit.edu>
> Subject: Re: Collaborative conflict resolution feature request 
>  
>
> [EXTERNAL EMAIL] 
>
> Hi,
>
> On Fri, Jun 12, 2020 at 4:11 PM Curtin, Eric <Eric.Curtin@dell.com> wrote:
>
>> Is there any existing or upcoming feature in git that could help make conflict resolution a more distributed, collaborative kind of task?
> You might want to take a look at Michael Haggerty's 'git imerge':
>
> https://github.com/mhagger/git-imerge
>
>> I also opened this as an issue in github as I feel it could be solved by either tool potentiall:
>>
>> https://github.com/isaacs/github/issues/1816
> I also made the same suggestion on the issue.
>
> Best,
> Christian.

