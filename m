Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1DF1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 01:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeDQBB4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 21:01:56 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33249 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDQBBz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 21:01:55 -0400
Received: by mail-wr0-f176.google.com with SMTP id z73so30781567wrb.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JtOK9WzYUR2IFE/Jnfu2RTmdjICDEHmW/3r3DecSHwg=;
        b=UDGrtC2qFakEgssI352Jcfqpyr5i23jw7SGXv6QIrd4dBmLwfbpRH12edANjzGEUyO
         80bV6YKxLWbmUOJfIW6h+laHqHNz71AOySJebeX63gy4U8fKeNy8Zn5AiAvswT/PLUER
         Fj4Yo6I5ckx9IV7lCikN4ZSvFKs//gPq5m3IVMueRAFxyikbf+tLUzcvPAu9OZEy7jwG
         FYA2eXjRAnHSo6ognwOOErrUd2kio3c185D9TZ2hUoroslgye4/ILZwYMudOTK3g/0H3
         pml+leT+Z4z8LosOG4dFZ/PZSlzsvLFWHh1MDDpJr0eL6/7ZRDioRw7NyeuzaZSpJnor
         kZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JtOK9WzYUR2IFE/Jnfu2RTmdjICDEHmW/3r3DecSHwg=;
        b=EZcm42l4H7C6cASB+2eXYvWMH8RzsGporHCOGk14wRkt+hMxSMrY3uqyMooN8MsU47
         X9Axpi5xjkKutPipAZLXo0/dht4/fXNuFxRtWBvpD5Up3sWFsxVaSknM4G7nB7wrS6Rs
         SFH1/kjKA7J/ftb6bEWcI78qYTnjCayi3A9T97eznXXtyrzp3Eyml9a6f8rPQjyCycRn
         0Z84XQvgUlwNctnWsllqodZFJwwG9fPuTPQwBZL8nO/WixnH1IuxzYTGOX2AeEA+F3IP
         5TIWiOVCjzMRqhcmtAUJgOp5cclXPH5bmXXNtYmSHSxDC6AoJF4P/hcUfs6+W9pCRjX6
         sOXw==
X-Gm-Message-State: ALQs6tBqNA6noMZAqhIUXQLpQH7eDaaKVQMW8o1ezWTwVjDrgoVtxMV3
        O50wf+R6NYzZEbuft5Ma91fUn81c1gjrqQ7GcaixGQ0h
X-Google-Smtp-Source: AIpwx4/WDKZwNp3PuXfhaxmQM9+nFjDDh9WdgwJ8w2QIvnv5HEKnYEJESXwWMXCFFlmUq/pmnkOctsVZEd53G80LJFE=
X-Received: by 10.80.192.145 with SMTP id k17mr534376edf.303.1523926914150;
 Mon, 16 Apr 2018 18:01:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 18:01:33 -0700 (PDT)
In-Reply-To: <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org> <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
 <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com> <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 18:01:33 -0700
Message-ID: <CA+P7+xrY83CM6WYoxio2nPGzeg1YNGbptM52Opu2UBgdk9Y-4A@mail.gmail.com>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Things won't work so well if you set the push url and fetch url to
>> different repositories. Git assumes that refs updated by "push" will
>> also be reflected via "fetch".
>>
>> I don't know offhand what will break, but likely something will. For
>> one, when you fetch again it will rewind your remotes after the push.
>
> Exactly.  I still haven't fully embraced it myself, but for a long
> time, "git push" pretends as if it fetched from that remote and
> updates the corresponding remote tracking branches (if you have
> any), so you'll be inviting inconsistent behaviour if you set your
> fetch and push URLs pointing at two logically separate places.
>
> This is a tangent, but there probably should be a boolean that
> disables this feature in "git push" per destination repository,
> i.e. "when pushing into this repository, pretend that we immediately
> fetched from the refs we just pushed to and update the remote
> tracking branches we have for them: yes/no".  It is not entirely
> implausible to envision an overly smart remote repository that turns
> a non-fast-forward push into an automatic rebase when it is safe to
> do so, instead of failing such a push, and you'd disable the "assume
> what we pushed would appear there" when talking to such a remote.
>

Not to mention something like gerrit which uses magical references
"refs/publish/branchname" which don't actually get generated on the
server.

Thanks,
Jake
