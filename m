Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E211F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdAUMoi (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 07:44:38 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34120 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdAUMoh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 07:44:37 -0500
Received: by mail-oi0-f68.google.com with SMTP id w144so7466979oiw.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 04:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R451/RRQ5BW8am+IfBmNDvjRUO37isx/bGdkW7+wA88=;
        b=CtDnVoUPK6niqiNSo6WXaTaHlqUy9ZltVkVkdQd5gp+hnMKNEi1PBuyxJZbbJd2Men
         +6gs/OPEDidsaGY0SVcjZpVpWVpLB2Mx8rsAgQnrLSZlgrhbb1Hm4IJBvlIWhDRFG5D+
         pH7nXTz+qy2C8IgBr/QmAxG4P7XXvaLpIOWgSRVbsb/TmZ3fyOc6Z9S+gQ4EAAwpex/d
         L7dWRKmuAWco+yYi/Jy7BkGsc3cya0koXAEDxS3s6/prmIDPTOp9nb10ACOm0egSLbzh
         w39tdusP4e8SyRwU7smMzCF/ApOqlN3VnF51j8OiVOdMQPRaM1y/ZNcLSjaQjFMyHUU1
         +yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R451/RRQ5BW8am+IfBmNDvjRUO37isx/bGdkW7+wA88=;
        b=g7GagUndmBnjwT5g1OmQhi3OchMepUpWi0gxkOFQPvxHbHX658jMfOiy9bRkZIXpBf
         UBZhKDilUsKrxysRbqqytHzl9sdcHOhD/hxCsDbkl5hMEmj8d2pDpQN1UiUbnNFu3UzY
         OoPQCGVyYLX8MGfYCV1q/sAqRrvPRewjgcrKbz7OkXULqCnkKeDGsqgmePz/sSzOzznd
         rxzZvFhM5zi0U1HzBGwHV4BdHQzhRm827575XmBheaAoJIlJ823TYCmVMBX0oQJ9Mu6F
         B+AfkcS1TID1itzU5h7DkQ8YJJbO+gTsQ0Yv4rCuVl6ODMWReuyu3GG0cDhuzn5PPVzc
         FLcQ==
X-Gm-Message-State: AIkVDXIKWj7o+zmGSaRH6Zylr3g7ZQ7HDth3SE361jZf0/GSQXPdcuAxP3P/kjCLsw0VYSiFMZVmvKV7E1kLAw==
X-Received: by 10.202.173.18 with SMTP id w18mr9957587oie.146.1485002676763;
 Sat, 21 Jan 2017 04:44:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 21 Jan 2017 04:44:05 -0800 (PST)
In-Reply-To: <20170120192539.7jts6xqzx46unn7y@sigill.intra.peff.net>
References: <20170120102249.15572-1-pclouds@gmail.com> <20170120160942.srqf4y5w5r6feidw@sigill.intra.peff.net>
 <CA+P7+xoMTX5n_h+5MytZwVqKjqa0wdNKCeDtH29A_+WSfr6gTQ@mail.gmail.com> <20170120192539.7jts6xqzx46unn7y@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jan 2017 19:44:05 +0700
Message-ID: <CACsJy8DxCPCXUeEoR1pQBCNqYOHjpgfLy_vgqsK1H=C0Mf=L8g@mail.gmail.com>
Subject: Re: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
To:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 2:25 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 20, 2017 at 11:16:15AM -0800, Jacob Keller wrote:
>
>> > I recently taught urxvt to recognize sha1s and grab them via keyboard
>> > hints, and I'm finding it quite useful. Here's what it looks like if
>> > you're interested:
>> >
>> >   http://peff.net/git-hints.gif
>> >
>> > The hints technique is taken from pentadactyl (which I also use), but
>> > the urxvt port is mine. I'm happy to share the code.

You just gave me a reason to rebuild urxvt with perl support. It
solves my problem with SHA-1 nicely (and fixes another problem with
very large counter in my approach, when you scroll git-log further
down, because I can't know what's on screen or already scrolled past).

Do you think it should be in contrib for better discoverability (than
burying it in the mail archive)? A separate git repo is also ok, but I
guess that's just more burden.

>> I would be interested in the code for this.. I'm curious if I can
>> adapt it to my use of tmux.

Yeah. Let me know if it works out. Would be nice to have this run on
basically any terminal, as long as I run tmux on top.
-- 
Duy
