Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 838FE1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753490AbeCQS0m (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 14:26:42 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33469 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeCQS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 14:26:41 -0400
Received: by mail-wr0-f174.google.com with SMTP id z73so10408245wrb.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=urxTpnu/rz49nrXQHAxB77aSvaT8wOTPI/k8dmpc8Cc=;
        b=MY7a4YJayIgJkeXeyFK+lCpo2nyKT5Gipj5YX/GSNH8T9vuzB9q69sOwJErNxcsvyi
         cycHHwqI2pt7m1/FncMhp9KGh5R4TngSUeHJtC4vc9VATcUXo0Z+j4ftEcUY0RRivoyH
         8y/e9NUPLgBclgKxLV+m7pILZ3Q/6O2XriH161qJYEWuE5sh7EnSROl4gByJIMOueNY1
         KbHyvX4Rv3LpOjA/n4c6UAuqjmSoXCp9MF7j+LL5bVoEPRV0eSPrzvZtNjqnHUnIF68L
         gZTptg2FAwgst1Zm6w844AVu4mFw10L+oBr8kKE4YBeBQAUoVyR8F2upezyIbX4s/Itd
         DnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=urxTpnu/rz49nrXQHAxB77aSvaT8wOTPI/k8dmpc8Cc=;
        b=hMIpwzE44IJjRnbcz9c6yAkkGK/YBvJkemZd0z/AzkQgL85aocCM04ybArVx4qmZrl
         iVLTrcbZHl6NCVXSXuLRWmUGCeUu2wlcb1hiyHVSRJ02fC0OoVzHZRbvdsCW7VkYhtYr
         oSBRYOYzvG3e8QdtJsyjr+Ix+JrjIUgQcBaJp7POF7nuoL7w37u0iMVlZyKjRMZKxo4s
         wvoTp8IbMif5BoZx7kB1y6esZspGIrWDMrwE67ni9usUGWEu5zDNu8oLMes99iW+PD31
         aHfZx5ADB4EQ9HVZM3Oau3Mr92hiWqWEH4cEW38z3RSdtB+Q7A+sMLT/ZADArkL+Iscp
         EXow==
X-Gm-Message-State: AElRT7GWtZfctbFvdtDiOfctxpk8N9OIHltPhvcalIXAm+hILIKwg1dl
        y6YVbVrwhn7BHE2wTxc/cn0=
X-Google-Smtp-Source: AG47ELsZETvVZdgw4YCUXWtR3/vX41Yuf7imMyZ4i6a8rlNQOgQBakfsV2kn69Dl3xOTO2oIS4dasA==
X-Received: by 10.223.189.131 with SMTP id l3mr4783237wrh.140.1521311199785;
        Sat, 17 Mar 2018 11:26:39 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id n190sm5151775wmb.15.2018.03.17.11.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 11:26:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yash Yadav <yashdimpu@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [GSoC] Scripts to be conversted into builtins
References: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com>
Date:   Sat, 17 Mar 2018 19:26:36 +0100
Message-ID: <87r2oid0df.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Yash Yadav jotted:

> Hello,
>
> I am a student going through the GSoC process.
>
> In the project ideas listed there is one idea talking of conversion of
> scripts to builtins. This interests me but no pointer forward is given
> and I'd like to dive more into that idea and go through the script(s).
>
> So, where should I look further from here?

One good place to start is to start reading at:

    git log -p --stat --full-diff --reverse 74703a1e4d.. -- 'builtin/*--helper.c'

And then search for git-.*\.sh in your pager. These are a bunch of
commits where the bisect, rebase and submodule helpers have had their
shellscript code incrementally replaced by C.
