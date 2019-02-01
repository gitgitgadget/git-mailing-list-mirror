Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196C81F453
	for <e@80x24.org>; Fri,  1 Feb 2019 14:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfBAOhO (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 09:37:14 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:63509 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfBAOhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 09:37:14 -0500
Received: from [192.168.2.240] ([92.26.116.186])
        by smtp.talktalk.net with SMTP
        id pZwHgLjxJwhzSpZwIgcOmH; Fri, 01 Feb 2019 14:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549031830;
        bh=SHB7ovr2DtNa1DDYJsRdg+U6pgmY476M0wTBuhgd2uM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OP8rc+nQMrYfdd3ha33XN4Q06uxODQv8ifGNA+rXMw/zNrqIwHfQZw4on72ZfThd9
         sMAcvSO9UOLD0OpUJm/3vQb91nxLP8q5rUq9ESAjYxcFvn9+ICRzD08lCc6VR8XCjO
         B00JEmnWj/UQ7x681+F+1pEwOx25N8LKTZPax2uc=
X-Originating-IP: [92.26.116.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=Pfo8oxCPEre7EYRssK5nbQ==:117
 a=Pfo8oxCPEre7EYRssK5nbQ==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=evINK-nbAAAA:8 a=w0RzvLSWAAAA:20 a=69EAbJreAAAA:8
 a=TO97B7HopdO3iLdl7IMA:9 a=2AMn5m2I_U_dXayq:21 a=tODdGfVUyniZWpCU:21
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/7] Turn git add-i into built-in
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>,
        =?UTF-8?Q?Slavica_=c4=90uki=c4=87_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     phillip.wood@dunelm.org.uk
References: <pull.103.v3.git.gitgitgadget@gmail.com>
 <pull.103.v4.git.gitgitgadget@gmail.com>
 <c7d3ce15-567a-20b5-1bde-2a7fdd88c4e5@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <2096b6c5-a164-f4eb-df4c-3468ff553abd@talktalk.net>
Date:   Fri, 1 Feb 2019 14:37:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c7d3ce15-567a-20b5-1bde-2a7fdd88c4e5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKt144Go5NHGRZDPB9RvhPlNrZ+kRjmqb+AXI9LY+ckVMkUpO6vU2oILNH6ACGWYQADIMDmbM3igx/bCRmoL0s+b0FZSswtqcUGyU/pqQ6xuml9XaYAU
 96svFPvVJxuZ8+9rdMGnBjlgUW/fAbFHuR/B+zyhx2PZYf8tVtqSKaDd1NpYsMTs6YJSTus1OebezytTODaUrrHJaCB0OtuO5vO7S2K/d/i7o77jC3GVbaDI
 +wxbOMN4RdvA8MTW+Sqy9233BmtZ+rmq1Y9J6iorAcnHirabiT8TB9OdbPs7pRU8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

On 25/01/2019 12:37, Slavica Djukic wrote:
> Hi Phillip,
> 
> Sorry for omitting you in Cc, again.
> I accidentally wrote yours and Ævar's email prefixed with Cc:, rather 
> then separating
> them with comma, like Johannes said I should.

Don't worry, thanks for emailing here. I've looked at the range diff and 
I think your patches are good.

Best Wishes

Phillip

> 
> -Slavica
> 
> On 25-Jan-19 1:23 PM, Slavica Đukić via GitGitGadget wrote:
>> This is the first version of a patch series to start porting
>> git-add--interactive from Perl to C. Daniel Ferreira's patch series 
>> used as
>> a head start:
>> https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u 
>>
>>
>> Changes since v3:
>>
>>   * add error check when calling add--helper's functions from
>>     git-add--interactive.perl
>>   * replace trailing whitespace in the test with variable $SP used in 
>> earlier
>>     tests
>>
>> Cc: Phillip Wood phillip.wood@dunelm.org.uk [phillip.wood@dunelm.org.uk]
>>
>> Daniel Ferreira (4):
>>    diff: export diffstat interface
>>    add--helper: create builtin helper for interactive add
>>    add-interactive.c: implement status command
>>    add--interactive.perl: use add--helper --status for status_cmd
>>
>> Slavica Djukic (3):
>>    add-interactive.c: implement show-help command
>>    t3701-add-interactive: test add_i_show_help()
>>    add--interactive.perl: use add--helper --show-help for help_cmd
>>
>>   .gitignore                 |   1 +
>>   Makefile                   |   2 +
>>   add-interactive.c          | 263 +++++++++++++++++++++++++++++++++++++
>>   add-interactive.h          |  10 ++
>>   builtin.h                  |   1 +
>>   builtin/add--helper.c      |  43 ++++++
>>   diff.c                     |  36 ++---
>>   diff.h                     |  18 +++
>>   git-add--interactive.perl  |  17 +--
>>   git.c                      |   1 +
>>   t/t3701-add-interactive.sh |  24 ++++
>>   11 files changed, 381 insertions(+), 35 deletions(-)
>>   create mode 100644 add-interactive.c
>>   create mode 100644 add-interactive.h
>>   create mode 100644 builtin/add--helper.c
>>
>>
>> base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-103%2FslavicaDj%2Fadd-i-v4 
>>
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-103/slavicaDj/add-i-v4
>> Pull-Request: https://github.com/gitgitgadget/git/pull/103
>>
>> Range-diff vs v3:
>>
>>   1:  737767b6f4 = 1:  737767b6f4 diff: export diffstat interface
>>   2:  91b1963125 = 2:  91b1963125 add--helper: create builtin helper 
>> for interactive add
>>   3:  d247ef69fe = 3:  d247ef69fe add-interactive.c: implement status 
>> command
>>   4:  4950c889aa ! 4:  fb3f9378ac add--interactive.perl: use 
>> add--helper --status for status_cmd
>>       @@ -2,12 +2,21 @@
>>            add--interactive.perl: use add--helper --status for status_cmd
>>       -    Call the newly introduced add--helper builtin on
>>       +    Call the newly introduced add--helper builtin in
>>            status_cmd() instead of relying on add--interactive's Perl
>>       -    functions to build print the numstat.
>>       +    functions to print the numstat.
>>       +
>>       +    If an error occurs, it will be reported, but the Perl 
>> script will
>>       +    not exit, since the add--helper is called within an eval 
>> block.
>>       +
>>       +    As the Perl script will go away soon, so will this 
>> scenario, where
>>       +    the built-in helper is called  from the Perl script. 
>> Combined with
>>       +    the fact that it would be hard to test, we'll pass on adding
>>       +    a regression test for this.
>>            Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>>       +    Signed-off-by: Ã†var ArnfjÃ¶rÃ° Bjarmason <avarab@gmail.com>
>>         diff --git a/git-add--interactive.perl 
>> b/git-add--interactive.perl
>>         --- a/git-add--interactive.perl
>>       @@ -19,7 +28,8 @@
>>        -    list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
>>        -            list_modified());
>>        -    print "\n";
>>       -+    system(qw(git add--helper --status));
>>       ++    my @status_cmd = ("git", "add--helper", "--status");
>>       ++    !system(@status_cmd) or die "@status_cmd exited with code 
>> $?";
>>         }
>>         sub say_n_paths {
>>   5:  581b108c9c = 5:  ab16afd1d5 add-interactive.c: implement 
>> show-help command
>>   6:  aede733318 ! 6:  0a27304a84 t3701-add-interactive: test 
>> add_i_show_help()
>>       @@ -7,6 +7,7 @@
>>            Also, add it before changing git-add--interactive.perl's 
>> help_cmd
>>            to demonstrate that there are no changes introduced by the
>>            conversion to C.
>>       +
>>            Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
>>            to force colored output on Windows.
>>       @@ -21,7 +22,7 @@
>>        +test_expect_success 'show help from add--helper' '
>>        +    git reset --hard &&
>>       -+    cat >expect <<-\EOF &&
>>       ++    cat >expect <<-EOF &&
>>        +
>>        +    <BOLD>*** Commands ***<RESET>
>>        +      1: <BOLD;BLUE>s<RESET>tatus      2: 
>> <BOLD;BLUE>u<RESET>pdate      3: <BOLD;BLUE>r<RESET>evert      4: 
>> <BOLD;BLUE>a<RESET>dd untracked
>>       @@ -35,7 +36,7 @@
>>        +    <BOLD>*** Commands ***<RESET>
>>        +      1: <BOLD;BLUE>s<RESET>tatus      2: 
>> <BOLD;BLUE>u<RESET>pdate      3: <BOLD;BLUE>r<RESET>evert      4: 
>> <BOLD;BLUE>a<RESET>dd untracked
>>        +      5: <BOLD;BLUE>p<RESET>atch      6: 
>> <BOLD;BLUE>d<RESET>iff      7: <BOLD;BLUE>q<RESET>uit      8: 
>> <BOLD;BLUE>h<RESET>elp
>>       -+    <BOLD;BLUE>What now<RESET>>
>>       ++    <BOLD;BLUE>What now<RESET>>$SP
>>        +    Bye.
>>        +    EOF
>>        +    test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git 
>> add -i >actual.colored &&
>>   7:  b9a1a7e37a ! 7:  ca2a7c4375 add--interactive.perl: use 
>> add--helper --show-help for help_cmd
>>       @@ -5,7 +5,15 @@
>>            Change help_cmd sub in git-add--interactive.perl to use
>>            show-help command from builtin add--helper.
>>       +    If an error occurs, it will be reported, but the Perl 
>> script will
>>       +    not exit, since the add--helper is called within an eval 
>> block.
>>       +
>>       +    Just like the change where the Perl script calls the 
>> add--helper
>>       +    to print the numstat, also here we forgo adding a 
>> regression test:
>>       +    the Perl script is on its way out (and this patch is part 
>> of that journey).
>>       +
>>            Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
>>       +    Signed-off-by: Ã†var ArnfjÃ¶rÃ° Bjarmason <avarab@gmail.com>
>>         diff --git a/git-add--interactive.perl 
>> b/git-add--interactive.perl
>>         --- a/git-add--interactive.perl
>>       @@ -24,7 +32,8 @@
>>        -diff          - view diff between HEAD and index
>>        -add untracked - add contents of untracked files to the staged 
>> set of changes
>>        -EOF
>>       -+    system(qw(git add--helper --show-help));
>>       ++    my @help_cmd = ("git", "add--helper", "--show-help");
>>       ++    !system(@help_cmd) or die "@help_cmd exited with code $?";
>>         }
>>         sub process_args {
>>

