Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8161F428
	for <e@80x24.org>; Sun, 29 Apr 2018 14:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeD2OJ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 10:09:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46697 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeD2OJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 10:09:28 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MPMdk-1fHAjC3UqO-004T7P; Sun, 29
 Apr 2018 16:09:23 +0200
Date:   Sun, 29 Apr 2018 16:09:20 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <mail@floga.de>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external
 subcommand
Message-ID: <20180429140920.GA570@furore>
Mail-Followup-To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkmQObwiUBnf+xydKS1rO5B20HdWsdBjsQLDhcndoM7ng@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:/CsyZEtW4l/jEAqgFQDeNIuR0KMjyWXlXHsd/DmArDaxE6eSL21
 UFOtnecgb8Wm5SWdma6Hcan8uvLqFW8TrwfM5hLI1QLKvieNHUznLWX/sz2VAuAR6XoVx5W
 dHvOcF6TUTwzcgurs2Zni0i+Df/WGGk83GvBfEtZPjiIAtkeBYDtp57tL1dPS+EDfIBHBo1
 52ZOdb/ssAxJmJpKEukgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dro0BUq24IE=:CcNJly95e4dgRiv0O2j0p2
 0/G5PeQesS+8xgGO7ufUPQD1Z5JopcbxKdaL7YAoFs6pwQ6uCxJ0lj1HtXSpzmxcaXgPuH2B/
 woGlmHY1pk+DuwTH+D0pickSLdUA1rv9htk6lXsiaKk1GIv4RAn2lKkBoPasYNQvWWBXIc/EN
 JF3QV5woToSPqrnrFCbUOqp1eJI9cH55tkVuqKTLdkfUUbblc2uiFuXAF5VJCHHLvByKcjNGM
 3as88oOFi6NpOa2RUcYtKRVX8oNmeVSbgiO/LFCxwM9/JUWlAgyAaweQhFu41Ih0iec+sPk6B
 1nzOYD2/2jguMymJue7fek0hPO+YcK3cEGFCpg7bA1Hhzo8Gb063RogZisCttQ9ANDEkV7yh8
 P2vUkTOupFIMsaUxBJV9PxeeS5ZRs7d9BGzNOMvEdrg41J4mFkN+Yuh/h8G0XCEZIgsDiiWir
 ba82K19FK90JKDvWWJbxvmBsRUpKxPW6FGm6tR6vRAqS/YXyiAkB9IgLX7aeONuusl6IlPwo6
 Fsv+Wsok/GBBLAPP2eMcYRCVzkwWidD00KJaalE+M/3dGwwCH6hfjlCUeXWqOC1QtJR4lRhvI
 jD9GuqGPOcDo297OManXh8rSazwUEjbR8vOtklEVI0wHDtUOcSixTbQAU+Q3NP//S+aC9PlfT
 T0nPVA/4DE79eTauTF1qSXevD9yb9FxjR3fb6yHCrEX9N7smGR5omqurlr+f6wHjU97A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-29 15:08, SZEDER Gábor wrote:
> On Sun, Apr 29, 2018 at 1:15 PM, Florian Gamböck <mail@floga.de> 
> wrote:
>> I sense a problem here. If I have a directory with a file xyzfoobar 
>> in it, and I type `git xyz`, with no defined subcommand that starts 
>> with these letters, then minimal bashcomp would give me `git 
>> xyzfoobar`, which can of course not execute. This can be unintuitive 
>> for users, as in: "If it can't be executed correctly, then why does 
>> it even suggest such a completion?"
>
> I'm not sure I understand the problem.  After 'git xyz<TAB>' (note 
> there is no space between 'xyz' and <TAB>) we try to complete the name 
> of a git command, not options of a git command.  This means:
>
>  - At this point we don't look for a _git_xyz() function, so we'll 
>  return from __git_main() before even reaching the piece of code your 
>  patch modifies.
>
>  - There are (presumably) no commands starting with 'xyz', so we don't 
>  list any commands.  Bash will then fall back to its own filename 
>  completion, and that's where that 'xyzfoobar' will come from.  It has 
>  been behaving like this basically since forever.
>
> And after 'git xyz <TAB>' (this time with space) we already complete 
> the next word, not 'xyz'.

You are absolutely right! I don't know what my brain was making up here, 
I am sorry. The minimal completion will come up regardless if no valid 
completion can be found. I think I mixed up the meaning of $cword in 
__git_main. It is correct, if I want to complete `git xyz<TAB>`, then my 
patch is never reached.

>>> I think all you need to do is run a 
>>> s/__load_completion/_completion_loader/ on your patch and update the 
>>> commit message with relevant bits from the above discussion.
>>
>> I can do that, no problem. But prior to that I want to be sure that 
>> you are okay with the above mentioned drawback. Will the behavior be 
>> acceptable in this case? Or should we try to somehow "undo" the 
>> minimal completion afterwards?
>
> As explained above, I don't think there is any drawback here.  Or at 
> least not any new drawback that your patch is introducing.  Or I'm 
> completely missing your point; certainly a possibility, it's early 
> Sunday afternoon, after all :)

Okay, then I'll prepare the next round. Thank you very much for your 
helpful feedback!
