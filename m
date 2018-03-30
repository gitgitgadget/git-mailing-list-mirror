Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5FE91F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeC3TLL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:11:11 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:41777 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeC3TLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:11:10 -0400
Received: by mail-ot0-f169.google.com with SMTP id i28-v6so10346685otf.8
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XZCMiCwyyofC6S6+q0FlCiDyseEUSVI/G2hug6Fsmjk=;
        b=esyNatTRqWr8CIGgCmSRbvYmn3OJn2Bv4BcpeVr481GQOLHiQn3K0xt8uP+Isd9unQ
         zLyGBHwifnDj4sNvxONSOdvhjZvj4SOiaUnohxEvZ+YXLUfpgEfaDQv/a9rpk9B64JcF
         2CY8z5XynRD+wyq154w7oELOxmxGULr4uDYjyZhwx4ZRA6FpOjkoJ9AAiqQeUSJqgtWM
         FsAYMOIIKyuLIthGom3m0rR0IGUDYms2PzzEA1Ei0ToVH2VNLs8jDSWVyQ7SnQIUDBGR
         ZeOWsW/m73EorB2FXBGjMnggBm3pznx8So9BZHEuL8MqT5ZhurGB1qxpXbK1G0umd0ek
         DyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XZCMiCwyyofC6S6+q0FlCiDyseEUSVI/G2hug6Fsmjk=;
        b=h4T6MiQAxNQ6drWOfixrLz/inD3vNGGk708P20D6lIVK0DUpzjeS11qR82uKnZ2D6S
         g9OkNyXqhNR5I14C3/mNbNPJ1abJG0IMvVplPCvdC4E139m1kwh1N7xX9aBLOSwuKK1r
         ceyKe+a2+qsRe3pflIacuCYRLBxnw4RwSXK7L8nRcwJWgscNXL5C8vHZnaj78r9LdDVz
         mHYyFKktZ1VCRXczSPkyoiFpQtLfRHKTMLt647/sOJcSOCCc33i3Zcxjl8FZPTHKYiIM
         7QQxvEIwa82pTayCpVIas9auL+tfg0i9bESsSCippbMS2mYt6KbuQtxNjYpECTxRvSvr
         URjw==
X-Gm-Message-State: ALQs6tDP4SgFOAJc+bql7IRmzYx7USXHrbHEtaDdQz5+IfOzzUl2d8S7
        JtXRGCCxRAAKzs9fowHc6oumgXVEISoRoXdFKow=
X-Google-Smtp-Source: AIpwx4/Maed/cDLeca/iiDS+CQMEFn8xXPBunE1j9vNCFe2W4rtQe0YeeuxdoCkM8XOsq4juYwvOhMPC45aei+uvAMU=
X-Received: by 2002:a9d:16f3:: with SMTP id s48-v6mr148259ots.304.1522437070241;
 Fri, 30 Mar 2018 12:11:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 12:10:39 -0700 (PDT)
In-Reply-To: <xmqqo9j52z4m.fsf@gitster-ct.c.googlers.com>
References: <20180330070744.22466-1-pclouds@gmail.com> <xmqq7ept4hhj.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DS2pRaDhXgKqFQaqjFft_EW5G=8t9PhNcAgMsSDsS0jA@mail.gmail.com> <xmqqo9j52z4m.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Mar 2018 21:10:39 +0200
Message-ID: <CACsJy8BL6JbXj9in3CsRQcxG5Ru8GCBquaspEMvVUN6kq+FNzg@mail.gmail.com>
Subject: Re: [PATCH] setup.c: reset candidate->work_tree after freeing it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Mar 30, 2018 at 7:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Which fields in candidate are safe to peek by the caller?  How can a
>>> caller tell?
>>
>> To me, all fields should be valid after
>> check_repository_format_gently().
>
> If so, free() is wrong in the first place, and FREE_AND_NULL() is
> making it even worse, no?  We learned there is work_tree set to
> somewhere, the original code by Peff before abade65b ("setup: expose
> enumerated repo info", 2017-11-12) freed it because the code no
> longer needed that piece of information.  If we are passing all we
> learned back to the caller, we should not free the field in the
> function at all.  But it seems (below) the codepath is messier than
> that.

Actually no, NULL is the right value. I was trying to say that this
mysterious code was about _deliberately_ ignore core.worktree. By
keeping repo_fmt->worktree as NULL we tell the caller "core.worktree
is not set". The current code also does that but in a different way:
it sets git_work_tree_cfg based on candidate->worktree, but only for
the "!has_common" block.

>> We still need to free and set NULL here though in addition to a
>> cleanup interface. The reason is, when checking repo config from a
>> worktree, we deliberately ignore core.worktree (which belongs to the
>> main repo only). The implicit line near this
>> free(candidate->work_tree) is "leave git_work_tree_cfg alone, we don't
>> recognize core.worktree". Once we move setting git_work_tree_cfg out
>> of this function, this becomes clear.
>
> So in other words, there is a code that looks at the field and it
> _wants_ to see NULL there---otherwise that brittle code misbehaves
> and FREE_AND_NULL() is a bad-aid to work it around?
>
> Then proposed log message "leaving it dangling is unsanitary" is
> *not* what is going on here, and the real reason why the code should
> be like so deserve to be described both in the log message and in a
> large in-code comment, no?

Let's drop this for now. I'm a bit further along in refactoring this
code that I thought I could. It'll be clearer when the caller is also
updated to show what's wrong.
-- 
Duy
