Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317F81FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 18:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdILSYX (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 14:24:23 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37579 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdILSYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 14:24:22 -0400
Received: by mail-pg0-f43.google.com with SMTP id d8so22776196pgt.4
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/YszdjMoCfA32O7+Qb7ACFF5vMbwfr7B9X/wfBDbLnw=;
        b=gKQuqPnK2JQ2bPTim7ofMkIuFfC5PfAz3Ziq/DHAb2J1AL7JR3slNy73vWDZyPB3v3
         p1EfUtISJHoRPXbZwUdRjamutpa5exmTG+/Y8oxwhZGgBBuOEdpAzTAjcYfGj1d0SRb9
         /QA0HoKCiQ4Wj7lkuAPfR+rve3vKujc4cbHVZHszpHhqR2+u9++IX03afF9rBjxtdxhf
         otUjBk6vgTrTrmh7IhS2FHnnbXjJJwPuI7C5lCCDcP69kgRXHWofnW2xqpJ2HNS5y4nu
         c925f1UGulbhAcao2h2Jw97XPQ32gdevyzhDuj66k6ooxrfO/8OlWmyr+oKn70CcEJOs
         TTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/YszdjMoCfA32O7+Qb7ACFF5vMbwfr7B9X/wfBDbLnw=;
        b=ju/h9tpXvCi27IQPM14aBZJdhIiTH8vvL75RcPlbBNo5jJtY9DF6LsP5Xga6ptRtbo
         qw1x47MfF0McvJFn94HKG7vCm6um/V91MB7KmZBrg+pKeqFFKxmqwEBLMlscgteFZDHY
         IuPnU7LaIn9rBZtRQMnzGxGRoVkdJkP8H04fQDmPsvU/6XqlFn51R8ohrPIt0F3zTrve
         IzwWlOK3reIsmqoblHczD9AmlBwXXRap3/Vy2OjF+YxHPlILJTmlh+sojnJxGH+zsnDN
         WyUyi7GGuR8o6cdzSAtMDCuOvEMqMSm7K2rBe0V5U1CIhgW8EXZrZZPJX+4WuHUQ3rEt
         /Org==
X-Gm-Message-State: AHPjjUhmlH8C82rk6D2TrlX6QQK0dzzT18/FS2QztJA/LixDaiLgF9Ym
        p2GnRtRwoXKFHQh+Updo6lklcn5XEg==
X-Google-Smtp-Source: ADKCNb43ofBEEdq3UJbWbYLG+zP4Ekpzvr6kDoZzHHuw+UGg625IA8B+kvCTMdebHR01O9GGePd8fH/XEkX3IRzUxFo=
X-Received: by 10.84.133.3 with SMTP id 3mr10871775plf.182.1505240661591; Tue,
 12 Sep 2017 11:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.138 with HTTP; Tue, 12 Sep 2017 11:24:21 -0700 (PDT)
In-Reply-To: <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
 <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
From:   Joseph Dunne <jdunne525@gmail.com>
Date:   Tue, 12 Sep 2017 13:24:21 -0500
Message-ID: <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry I don't understand your question.  The commit-msg hook runs
properly in all cases except when I perform a merge with the --no-ff
option enabled.

On Mon, Sep 11, 2017 at 12:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Sep 11, 2017 at 7:34 AM, Joseph Dunne <jdunne525@gmail.com> wrote:
>
>> When I merge ... however my commit-msg hook does not run.  (The
>> commit-msg hook works fine in all other commits / merges.)
>
> When using git-commit, but not git-merge?
>
> See the discussion of patches at
> https://public-inbox.org/git/20170907220429.31312-1-sbeller@google.com/
