Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888D51F576
	for <e@80x24.org>; Sat, 20 Jan 2018 09:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeATJPA (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 04:15:00 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35118 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeATJO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 04:14:57 -0500
Received: by mail-wm0-f45.google.com with SMTP id r78so7806714wme.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 01:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Csn6sUf80DLuhNOaTT5ItXMAwBN/I9ZEfT7dbcXe8w=;
        b=do2CzvferFmA9HEjgSwJNH7KIzzFNynLy1fddnrOTpefiIyCAay6qYhrS6ylrPRvXf
         klYeJV0NfQ5nuVfe70Zw/k3RScQERHXIYdf2WRUY+9R9gqtVbPI95n3ATPKP7fBdNj3d
         z4k6vMl3nKR6RB085xg7JjqHUMfMlOGuC8+rsEHawoR+ifyKtovwBMzT8acxaWEnzW2Q
         FQ3tyX4FoorzSeRP6kxmWur9ktap04WBu7QiqUyLQBlOAxSMmqxzKJQIXr8Jrc03Ps+E
         4JAnIAoO1FrCIKl4su2q9KuU5nkywa14mNy1PzdF8oS2LZMda0WeYytdSv0+rKfJ4Yt3
         fq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Csn6sUf80DLuhNOaTT5ItXMAwBN/I9ZEfT7dbcXe8w=;
        b=jPE8QnglyVtRG8tgReT+on1291AA/ukEU11XXnPQfsuGAGbZ+tTpQWM75NPzup7QMa
         4Ef6ESLbNXi4jeN4mY3W/yJ0UHuJg+4dIH3TgqKm7hzM0/klrRFOMl2dfC9+tUGLORLu
         3170SKmpqkotO8CwLViJMVRijwcN1cgnvB5avPO2Sa7MmyZcoNQEOJuxqii7oUrnEoBj
         ZCvrZ9B5MtNaHI+WTMIpIrsevnqPdQimMZxHM05Vqb0idVa9rTHBfNaaWbb0lP4sguia
         H34lVZVWzcIPc/rCQYED59N+Ukxx3jNLOq0Yh6D6wuj2WDip+Vf5bkIkpruj1yNh8w5d
         mo4A==
X-Gm-Message-State: AKwxytc6+fcO9QE2kt4+1aNBCUsFm/n0XHV9s5gBqhZEuh+nKK9Amu/w
        kmLbi59XY9yRsg4rBCQxPMtRHdPXgrzJeWqkEc4=
X-Google-Smtp-Source: AH8x225LQOVMU5eXEINNMcqUc0PotB7GUZymHxAvxoxa5z+8EM30fUUveBKRUTq9rCNaCUkL6/e9t7u6mQ+3tXpX1rA=
X-Received: by 10.80.165.21 with SMTP id y21mr2726561edb.148.1516439695897;
 Sat, 20 Jan 2018 01:14:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Sat, 20 Jan 2018 01:14:35 -0800 (PST)
In-Reply-To: <xmqqinbxpp5m.fsf@gitster.mtv.corp.google.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-2-sbeller@google.com>
 <nycvar.QRO.7.76.6.1801182233480.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqinbxpp5m.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 20 Jan 2018 01:14:35 -0800
Message-ID: <CA+P7+xoO4twSgYVNJ4WaTj80WHS_ViEOBOEVST1nX9UzRA4JxQ@mail.gmail.com>
Subject: Re: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive:
 clarify arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Good idea! I would rather do it as an introductory patch (that only
>> converts the existing list).
>>
>> As to `merge`: it is a bit more complicated ;-)
>>
>>       m, merge <original-merge-commit> ( <label> | "<label>..." ) [<oneline>]
>>               create a merge commit using the original merge commit's
>>               message (or the oneline, if "-" is given). Use a quoted
>>               list of commits to be merged for octopus merges.
>
> Is it just the message that is being reused?
>
> Aren't the trees of the original commit and its parents participate
> in creating the tree of the recreated merge?  One way to preserve an
> originally evil merge is to notice how it was made by taking the
> difference between the result of mechanical merge of original merge
> parents and the original merge result, and carry it forward when
> recreating the merge across new parents.  Just being curious.
>

It looks like currently that only the commit is kept, with no attempt
to recreate evil merges.

Thanks,
Jake
