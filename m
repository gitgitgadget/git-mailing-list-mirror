Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F409F1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbeDMP1Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 11:27:24 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:35791 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeDMP1V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 11:27:21 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 70befYYfPLjjA70befURHV; Fri, 13 Apr 2018 16:27:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523633240;
        bh=Y32MG0xLbBMF8EHad2xbPiQTmu0LMpbCsqaxQYNxqy0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SZZibXwA06Sbb0oAGtdYah6KP4YYpZLWV3tAnxVCuz9z9qatygnfStNxfxN5ibfbg
         rYjtqvI0C3QQnYR51dtHx4gp8eqP1JhdecJSnvc/Vj71hmA6vyuD0aXcgZk404xBkM
         csVMydwourmU9ARdYFCh4YLj00YZ0LuCdAwylSQ4=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=yt0gHnNbSsAN4je1BpwA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the
 man page
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
 <26c21a44-92b3-80f4-5211-034c64f7568c@talktalk.net>
 <nycvar.QRO.7.76.6.1804121102260.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5c968cfe-b897-e308-d41a-9948529b796f@talktalk.net>
Date:   Fri, 13 Apr 2018 16:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804121102260.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFdje2bwILJ2cfKLV7YGxOeoUO5bnCyCGj2uAs9q9FP2XZ8MZsplewnkO0Rkoefl5syrPfYsnYCCfVaNM8sSC1LBlqg21pcCFl5do8QH8AAIn8IGV/XQ
 e+PsIVDU34VjxyhtsEJz1lzG+tltyrxMzVQ1LFn9h+6FqxeC2bBIzMI8V3I6xCf0Ay9VMkq3cxwUlTFzdZBwZY0MLxr8KCzCyon2IWKNiQmjl/slso9rmr6v
 dHnxwNSjcJfMZx+4spvDLGqUSyqnjvPxC/4c+1A3yrcDewIVR8uUp3uaF6Unjj9BakkokIGkIifQDM0NDNJT7RyhH0sBSS/gN61VoGmZzS0xBlru5CekG7rz
 3w5AAXMi7EivWRHsD096ByQHRAabTb4DQ44q+kcWgGqnXEJFDxs4TPV59ui3DrcKGLR8uO12ZojlBEByXcvr0OX7UZKWu5HO57mVJ39P8j5TOsi/9e0JGmer
 2vD2FohgRdE1QZIEVyUULz6Yk+DLoksPGCtGvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/04/18 10:30, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 11 Apr 2018, Phillip Wood wrote:
> 
>> On 10/04/18 13:30, Johannes Schindelin wrote:
>>
>> Firstly let me say that I think expanding the documentation and having an
>> example is an excellent idea.
> 
> Thanks! At first, I meant to leave this for others to contribute, but I
> think it makes sense for me to describe it, as I do have a little bit of
> experience with rebasing merges.
> 
>>> +
>>> +------------
>>> +label onto
>>> +
>>> +# Branch: refactor-button
>>> +reset onto
>>> +pick 123456 Extract a generic Button class from the DownloadButton one
>>> +pick 654321 Use the Button class for all buttons
>>> +label refactor-button
>>> +
>>> +# Branch: report-a-bug
>>> +reset refactor-button # Use the Button class for all buttons
>>> +pick abcdef Add the feedback button
>>> +label report-a-bug
>>> +
>>> +reset onto
>>> +merge -C a1b2c3 refactor-button # Merge 'refactor-button'
>>> +merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
>>> +------------
>>> +
>>> +In contrast to a regular interactive rebase, there are `label`, `reset` and
>>> +`merge` commands in addition to `pick` ones.
>>> +
>>> +The `label` command puts a label to whatever will be the current
>>
>> s/puts a label to/associates a label with/ would be clearer I think. Maybe
>> s/whatever will be the current revision/the current HEAD/ an well?
> 
> Thanks, I incorporated both changes here.
> 
>>> +revision when that command is executed. Internally, these labels are
>>> +worktree-local refs that will be deleted when the rebase finishes or
>>> +when it is aborted.
>>
>> I agree they should be deleted when the rebase is aborted but I cannot see any
>> changes to git-rebase.sh to make that happen. I think they should also be
>> deleted by 'rebase --quit'.
> 
> Oh right! For some reason I thought I already hooked up rebase--helper
> --abort when rebase was called with --abort or quit, but I had not managed
> yet. I think I will leave this for later, or for GSoC, or something.
> 
> In the meantime, I'll just drop the "or when it is aborted.".
> 
>>> That way, rebase operations in multiple worktrees
>>> +linked to the same repository do not interfere with one another.
>>> +
>>> +The `reset` command is essentially a `git reset --hard` to the specified
>>> +revision (typically a previously-labeled one).
>>
>> s/labeled/labelled/
> 
> As Eric pointed out, I am using 'murricane spelling here (or is it
> speling? Ya never know these days).

:-)

>> I think it would be worthwhile to point out that unlike the other commands
>> this will not preserve untracked files. Maybe something like
>> "Note that unlike the `pick` or `merge` commands or initial checkout when the
>> rebase starts the `reset` command will overwrite any untracked files."
> 
> You know what? You just pointed out a bug in my thinking. Previously, I
> thought that this is impossible, that you cannot overwrite untracked files
> because we labeled this revision previously, so the only new files to
> write by `reset` were tracked files previous. But that forgets `exec` and
> `reset` with unlabeled revisions (e.g. for cousins).
> 
> So I changed the `reset` command to refuse overwriting untracked files...

That sounds like the safest plan

Thanks

Phillip
> 
> Thank you for improving this patch series!
> Dscho
> 

