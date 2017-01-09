Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E64D1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423140AbdAISw2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:52:28 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33685 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423108AbdAISwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:52:23 -0500
Received: by mail-ua0-f180.google.com with SMTP id i68so365401768uad.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZA+hwGkzHxK5bdaAbjDlZwaYj+OemiJmuRcsEkF4pss=;
        b=GwWEbyiFUBc64hG7STfBlHtEogvjPV97uGrFgKCPiC6gGF1/J3zQ8+ix2qb8fj23CD
         stZnoA5ffBcxxiI0Qwj7j8agQbpVSC6u6gBO+1+XF16iHeuao2ePo77TNTUGj5aAsny/
         +WIMqIkY3E32WjPPn4WonL20wiVaNWhOghtEBuYSsCK8w7hcTopxqpj+CD4lhzGEe5pr
         FVWs6ngb7iWE3AfrEfjIh/Quq/XMUDg1ndKlFeuV4i2glIlmTSRrmhajTTtA//hF0gkL
         roxEqrIxER+SR4AyUi6zuLf8ZXBGSFlymd7Meou5MKo/4dqKZXyyUdQngA0KN0FU6k/g
         ETww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZA+hwGkzHxK5bdaAbjDlZwaYj+OemiJmuRcsEkF4pss=;
        b=ciD091681iqhJyqmyAy/EiDTOT6Ku3oYIDZlo72rSUc7hMvFeI8Ri2KWS397sJp3p1
         mqq72ns0BTdcwYTF4lDhNUvdjPUurpe0CzFK/szZopeZYaJNKMBU9dTn0w0K0BBp4vx3
         jXMEHjq7GKVZDWLEbG4Z7pCKWBaaszrZphY0k8Z3LhXYAQ+GR6HvPgShJovp9zaAjysj
         7uyVi8dgvAvk2mty9ZkEP87HmDvHdZpJ9rxCj25NYiKItwLvl5vmrPG23eO3oDoPYgqZ
         i9ahzcBXRBMEIAYhJvoesSSuedCCSvPW8iRC+nQbfPRUSl+tgk+9tlQP/W47WZqtMTlU
         bItg==
X-Gm-Message-State: AIkVDXK2Q2I7liFMtMi6raQNKLYB7/qK3b+0Zupk5uN7/Li0KlNLDcYMSXvw0vAoLGsZYJZa6T6BC/0IzeRcoA==
X-Received: by 10.159.48.131 with SMTP id j3mr48214222uab.43.1483987942227;
 Mon, 09 Jan 2017 10:52:22 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.1.37 with HTTP; Mon, 9 Jan 2017 10:52:21 -0800 (PST)
In-Reply-To: <49C0981FE7D04AE2AC0BBB011FD74B90@PhilipOakley>
References: <CAHd499BREpaHHyN89a1HchyJiQzPpdo3NSfoLLGVONEmX1m19g@mail.gmail.com>
 <49C0981FE7D04AE2AC0BBB011FD74B90@PhilipOakley>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 9 Jan 2017 12:52:21 -0600
X-Google-Sender-Auth: Px7cL6l1iHJX5Gu-jNdICOIFrHM
Message-ID: <CAHd499CuZBXF0AddP7AfqtzvA8rBArwqtktRmNdD-kwGUCruLg@mail.gmail.com>
Subject: Re: Rebasing a branch with merges
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 3:28 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Robert Dailey" <rcdailey.lists@gmail.com>
>>
>> Here's the scenario:
>>
>> I create a topic branch so one other developer and myself can work on
>> a feature that takes 2 weeks to complete. During that 2 week period,
>> changes are occurring on master that I need in my topic branch. Since
>> I have a collaborator on the branch, I opt for merges instead of
>> rebase.
>>
>> Each day I merge from master to the topic branch, which changes code
>> I'm actively working in and requires semantic changes (functions
>> renamed, moved, etc).
>>
>> Once I'm ready to merge the topic branch back into master, I have two
>> options (bearing in mind the goal is to keep history as clean as
>> possible. Furthermore this implies that the constant merging into
>> topic from master has made the topic branch look unwieldy and
>> difficult to audit):
>
>
> a broader question zero;
> 0. Is the merge always clean? Do you always do a preparatory fixup! to
> ensure that the merge will be clean?
>
> Ensuring that the merge will be clean should greatly simplify your decision
> about process.

I don't understand what you're asking. How would I do a fixup with
merges? Can you explain a bit? Normally the only time I use fixup! or
squash! is for local changes prior to pushing.

>> 1. Do a squash merge, which keeps history clean but we lose context
>> for the important bits (the commits representing units of work that
>> contribute to the topic itself).
>>
>> 2. Do a final rebase prior to merging.
>>
>> #2 doesn't seem to be possible due to patch ordering. For example, if
>> I have real commits after merge commits that depend on those changes
>> from master being present as a base at that point in time, the rebase
>> will cause the patch before it to no longer include those changes from
>> master.
>
>
> How much of the historic fixups to cover changes on master do you want to
> keep visible? i.e. how many fork-points are truly needed (a. by you, b. by
> the project - personal knowledge vs corporate knowledge).?


Again, I do not understand. Maybe the first question you asked needs
to be understood before I can answer this one. Sorry for the trouble.
