Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C90207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946214AbdDYLKF (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 07:10:05 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:12741 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944236AbdDYLKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 07:10:03 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 2yM4df82kgKst2yM4dYOY8; Tue, 25 Apr 2017 12:10:01 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=3u_UOM-A8m4ByYE78KoA:9
 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <C3A8A88B8DDD468095B7FD256330EEF7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, "Jeff King" <peff@peff.net>
Cc:     "Orgad Shaneh" <orgads@gmail.com>,
        "Dakota Hawkins" <dakotahawkins@gmail.com>,
        "git" <git@vger.kernel.org>,
        "Christoph Michelbach" <michelbach94@gmail.com>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com> <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com> <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley> <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
Subject: Re: Submodule/contents conflict
Date:   Tue, 25 Apr 2017 12:10:01 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOuWuvhRi7UDQA0utnSF1j+gJ0mbUZlHN0392WbBIi8tzjNxr1LZAPF53lOvkLaoisOKMSxpcQdZTDxjftwbRZdS9cAZeRQ/1HbyJ5i8YuLA3yWY3En2
 hBbEhz0NajaSA6StlFX1ij20zHtecBmIfqddnj4Jg2bYqEDcwPrzpwM6veTlZsjaLXINbKhokshwNpADT6avGrHvT1iyVqqW0LLcxoCbQBS5UkNU9efHFjcd
 0eyqg4Eu2a8IbbR/zomtQc2tiBecHRG4uP0YAkc/ikaj7Lu0vgioOF20a0MLshRdq8JdVYCXxjYXod1XJLkYNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> On Mon, Apr 24, 2017 at 4:33 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>
>> This is almost the same as just reported by 'vvs' [1]
>> https://public-inbox.org/git/CAM1zWBtfgHT=pT0pidQo1HD=DfrXLG3gNaUvs0vZKvYfG1BHFw@mail.gmail.com/,
>> originally on the 'git user' list
>> https://groups.google.com/forum/?hl=en#!topic/git-users/9ziZ6yq-BfU
>
> For this issue, +cc Jeff King due to this pointer:
>
>>> On the main list thare is a similar "issue" [1] regarding the 
>>> expectation for `git checkout`,
>>> and importantly (for me) these collected views regarding the "Git Data 
>>> Protection and
>>> Management Principles" is not within the Git documentation.
>>
>> Yes, that's an interesting point. What concerns me is that the commit
>> c5326bd62b7e168ba1339dacb7ee812d0fe98c7c which introduced this
>> into checkout isn't consistent with reset. Seems that nobody noticed this 
>> before.
>
> It seems as if we'd want to see the code from
> c5326bd62b7e168ba1339dacb7ee812d0fe98c7c
> to be part of any worktree touching command, specifically reset?
>
>> It also has a similarity to
>> https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/ 
>> regarding
>> how checkout operates.
>
> This seems to be orthogonal to the original topic (no submodules, nor 
> checkout
> bugs, just a doc update?)

At the moment that topic has ended up as an attempt at a documentation 
update, but I think it may not succeed ynless there is clarity about the 
(reported) underlying problem.

As I recall Christoph was using checkout to copy a file (e.g. a template 
file) from an older commit/revision into his worktree, and was suprised that 
this (git checkout <tree> <path>) also _staged_ the file, rather than simply 
letting it be in a modified/untracked state.

It in a sense is the same issue of relating the worktree content to the 
index status, though I think that checkout is acting as designed/intended. 
I don't think that there is a command (is ther?) to do what Christoph hoped 
for of not staging the new content (e.g. a template file), but the index 
knowing/remembering its stat details, just in case.

The submodule case appears to be more about deciding if the content of 
submodule's index should be considered for inclusion in the super project 
prior to the checkout of the other branch's tree that is already unchanged 
and in-place.

>
>
>> It does feel as if there are two slightly different optimisations that 
>> could
>> be used when the desired file pre-exists in the worktree, but isn't
>> immediately known to the index.
>>
>
--
Philip 

