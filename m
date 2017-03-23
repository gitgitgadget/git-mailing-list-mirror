Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5955A20958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdCWUkE (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:40:04 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34591 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdCWUkD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:40:03 -0400
Received: by mail-io0-f172.google.com with SMTP id b140so5137270iof.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jo3K1oS/CYQsK7/LV02p4hKMjuWiZSmc2cF4sfNgHT4=;
        b=jbZv6A0OD5NLb9pPJ4lY2eGwJlkAzwwHEgBNDEEHmdlqu/NktLWbaNDQ+EEkags64g
         4Km9Pid6t1ESj/vu0zq66UEAhaevHwTcNxgz0SWQGE4y3BjdB95QO0v6ffYr6Ok/+jt0
         G/wKI99QjkDzAYVDui0aum8pP28LiEbCpglPb7GhSrqpnuaabVRiSsEUSZDcsqjbmD26
         0DwrbEX6HhguTGWsK+RlZXUsHrR0P39WGT5TVh2i/K9OfNYnSpyn8PHe1i7i0I54AKwT
         lhkEKglcQod8ggHrTo4W8h1UA6cp34USYxnlOYWhP71GyQ2ltbNV8blcFyvJC0u4EgNp
         fEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jo3K1oS/CYQsK7/LV02p4hKMjuWiZSmc2cF4sfNgHT4=;
        b=KqdSFq7+sHZ+RHorQUMu9s2jX943tEtTa56Gdq1keimWUOOS0VgvuWQnL48Aq4HrjN
         8tVgInvPA4wNcz/c77PHedcxQGwwvw7jqa0D7m2UqANabg8kJ8JpQ31FRrMoxg4j14ne
         8y/L8GmC8dpzvTgpJe2ecKAycqbI1r9V0gsmjkHBkbCRD5gEW7loprWx+FxmYK7XBbEc
         K3HMuF1M6oo7lKJLJXCfp2FFtPae1Fn91LWUuWWnqenRYOq907pt68W9kzTjzNF2lPXf
         KJVVoFmhkiYEg1jD9S8rcsgrhpjGBhgi6o9ygA4GYKydsIO3hvpm0s1hQBdYovaVYzI3
         qGCg==
X-Gm-Message-State: AFeK/H0NZHQppRO7o+dB+kDheH7jW4ckQ840l4OsoUmETtLcFkSrygiuagGup3t0VY5VNzYCiFQGHlySKq+d5g==
X-Received: by 10.107.32.199 with SMTP id g190mr5093731iog.117.1490301602485;
 Thu, 23 Mar 2017 13:40:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 23 Mar 2017 13:39:41 -0700 (PDT)
In-Reply-To: <xmqq4lyjeu5m.fsf@gitster.mtv.corp.google.com>
References: <12e6fae3-a341-3dcd-0920-c3df2d54d0a8@gmail.com> <xmqq4lyjeu5m.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 21:39:41 +0100
Message-ID: <CACBZZX5e-p4gKSWxehhVnnSgApC9H2v_ud+1Drz-vu_OAZwCgg@mail.gmail.com>
Subject: Re: Bug: Revert with -m 0 says no -m was given
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ulrik Sverdrup <ulrik.sverdrup@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ulrik Sverdrup <ulrik.sverdrup@gmail.com> writes:
>
>> Git produces a misleading error when you tell it `git revert -m 0`.
>
> Thanks.
>
> I think this is the same issue as the one with 'cherry-pick' that
> was reported earlier.  We have a fix in the 'master' branch already;
> please try it out.

Specifically, in master:

$ ./git revert afd6726309
error: commit afd6726309f57f532b4b989a75c1392359c611cc is a merge but
no -m option was given.
fatal: revert failed
$ ./git revert -m 0 afd6726309
error: option `mainline' expects a number greater than zero
