Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D6811F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeBBT3j (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:29:39 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52638 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752737AbeBBT3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:29:37 -0500
Received: by mail-wm0-f51.google.com with SMTP id g1so14790345wmg.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=thb3meF3LJH+I7T/WkGEZs33qBHxPlJ53ZUpnlFlDLU=;
        b=unQzgnpaIWi7UYmOkgG8z9rc0pS8xnMMs9BlC8SS+n96Cu+x+O8oqgNmKSV3woFnJF
         KcLHcrl7nzPm/OsSsmbxbvrbpmpGMzS701/uVk/rdXIlLKl4HSTIyCsc/+Y/HP2Saje1
         z3Vd6JbqESRNFYvCN7q0pYv+r5HRUFO5WwAU9Vorpp1Dfujc28IexjABbG7/FN/g4fce
         fC11O7eg/9CecU2Tr+GdnDHJaGy5tYFrNS2IJCtMypAExMQKwy2GQ34ksAESreZ4ovYN
         aIqIHRaMZFC3KyfR6KqDrIxoffW+eV7V454wBk+tT472DbMwySxmYnr+vVHzHfQac96O
         jn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=thb3meF3LJH+I7T/WkGEZs33qBHxPlJ53ZUpnlFlDLU=;
        b=knoILlpwLHLel8QGnYGvu9dy3MIDtdZGpVAUUofvXSti9ERwk7r39+oDWcSZv6pBs6
         OAV1hO6o1H0bz7hrZ2xzCXRwi6PKYJ6IWlhwQiDMaqnwztmzukIO8eUQQ6snhRegtA4p
         SRtIUVFhI3SotE9Gb+8Gr4PY2EKvgdAE6G3Vw80U43lGqe6Y/0a+PYJT8NcqvJp4Kv31
         e6FB9erlc1swyhIp0e9NNiane3XbeDQv5n2A0oNV5+3eySkCoYG0y4UF21J76+my5ota
         enHmU8Fuv8otl0FnY6CFXbyBzqHiKEISnNhzyMqop+1TPRdQKmwSIQU0/OENYWv6yC/C
         T0xg==
X-Gm-Message-State: AKwxytexw6/BTVtPDrtyWAmbvpSEO1HPUF4AY/ZyFf+AvQ0P1wERxRJT
        Qo0YJr5K895V576nU06oI64=
X-Google-Smtp-Source: AH8x226MrtDegKIx/NBI3Vom4ymf43MvFxkhyQwc9KNcE+NgYxVCJ26X+g0mV/b/4IVD7vF9hWwsKQ==
X-Received: by 10.28.236.24 with SMTP id k24mr32173998wmh.8.1517599775835;
        Fri, 02 Feb 2018 11:29:35 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b72sm1994638wmf.2.2018.02.02.11.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:29:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87lggcnc35.fsf@evledraar.gmail.com> <xmqq8tcbqnbr.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <xmqq8tcbqnbr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 02 Feb 2018 20:29:32 +0100
Message-ID: <878tcbmbqb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 02 2018, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>>
>>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>>  - update-index doc: note a fixed bug in the untracked cache
>>>  - dir.c: fix missing dir invalidation in untracked code
>>>  - dir.c: avoid stat() in valid_cached_dir()
>>>  - status: add a failing test showing a core.untrackedCache bug
>>>
>>>  Some bugs around "untracked cache" feature have been fixed.
>>>
>>>  Will merge to 'next'.
>>
>> The "update-index doc: note a fixed bug in the untracked cache" needs to
>> be amended so it doesn't say "Before 2.16, ":
>
> True; we could just say "earlier", but I am inclined to suggest that
> we get drop it altogether.  Description of historical bugs is of no
> interest with the version that already fixes them, so the _only_
> value the doc update adds is to tell readers that the untracked
> cache feature is still not well proven, and core.untrackedCache may
> serve as an escape hatch from its bugs by disabling the mechanism
> added for the feature.  I am *not* opposed to a replacement of the
> patch that just says something like "This feature has been cause of
> bugs even in recent versions of Git, and you may want to disable it
> as a workaround when you are hit by an otherwise undiscovered bug in
> this area", though.

 - It's my experience that most users today who aren't *nix graybeards
   don't use the documentation shipped on their system as their primary
   source for docs.

   They go to Google and might find the manpage there. Thus this
   documentation will be read by users on pre-2.17 (or whenever this bug
   fix gets included).

 - This is very useful information if you're deploying
   core.untrackedCache across a site with differing git versions. Just
   because you have 2.17 doesn't mean everywhere you're about to deploy
   core.untrackedCache does.

 - In general I agree that we shouldn't be documenting old bugs, but I
   think in this case it makes sense since the bug's really bad. Without
   thinking to disable core.untrackedCache there's seemingly no way to
   fix it without wiping away the index, which might lose you work.
