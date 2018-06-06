Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E365B1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 18:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeFFSuf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 14:50:35 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34868 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeFFSue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 14:50:34 -0400
Received: by mail-ot0-f176.google.com with SMTP id q17-v6so8505583otg.2;
        Wed, 06 Jun 2018 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mqFlOJ2x6GuDrUday4cgyXgvorU+KT/+ZZBl7IOY6uk=;
        b=tPrnNHArQ3QK7YtBx1MJl4rMaKFKo10g4gDMYiCHwBw9Jyx8skGQeJkqUgn3/1WLjo
         2ezONI6+1bLmTpJ0KDInu3E4iuO6aqJ15fzmb8rXTBuJQ+txh24geo1fTO+S3s0aSit3
         D/L6SL18LNckQ13jK5yxhKXYZSSAj+V1RehUH/zq2iTlj3JAl8s96H4gvUDSRuTnZKAN
         5tgN2kqrQM8fFG1f91M5yNJaMsWiN/5c0Lnpg2thpU6Ia0Fw1r453MehsWiJF6YGdVTc
         MhTXw+GCmvF8HyBlCa0NtnGYQfgjrS+vz74B7EBpSbzfc+KUdPkQ8KX91p25v2xdZc1c
         BDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mqFlOJ2x6GuDrUday4cgyXgvorU+KT/+ZZBl7IOY6uk=;
        b=kQ+tlWAB31neHo2pKDvVanub0ccYhV9se3sXKfa2csSA4nWPeModLULanw69NCqh/r
         MO//v2PSkFSTdqi8Vn8N56VZ4uiQvujU5paChWU9X/uNAzwN9JNrobqzjJx9dV8sQI1G
         Nzf3+F7kxFroDJCQWX+SaMUv04KHKOTPEg0lbu1NZwjY4e0yKbuU2NOp7l4a4GLzcVyC
         FpcQuOwEgN1zDZ1Uxo5uGRO8eKMlgo01SIPuHKEDhZHXkivnTr8dLtLh7dwe2xZDt/8O
         x9hBfRewkq6EJoPWTarDSPydUT3cUtjDYc2Rtj0HnrFUjUBIbxQmkr7vXY2/OhnlHUea
         l5Hw==
X-Gm-Message-State: APt69E2a7iRpWzjfSJ6xQa51HtQUDaPJAZ3V2F6gEL0WaynTPAYUkYSI
        jf9f7pnIVRS8MstJLmvyVqc2QLnarHWtNw2fv5g=
X-Google-Smtp-Source: ADUXVKJFtin3IwyjEiit7BRmoFT53zTg+NeatTfEGlSmTFTWOIb7SW+8gLgtoW0reHkWB0nTjbY2SRFUY0M0mScD9oA=
X-Received: by 2002:a9d:2989:: with SMTP id n9-v6mr2916414otb.152.1528311034040;
 Wed, 06 Jun 2018 11:50:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 11:50:03 -0700 (PDT)
In-Reply-To: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
References: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 20:50:03 +0200
Message-ID: <CACsJy8ApqX16VNJ1nJktYVssXHTg+OSi_aZNt=es9BuUw9=1Cg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.18.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  * "git pull -recurse-submodules --rebase", when the submodule

One dash is missing in --recurse-submodules

>    repository's history did not have anything common between ours and
>    the upstream's, failed to execute.  We need to fetch from them to
>    continue even in such a case.
>    (merge 4d36f88be7 jt/submodule-pull-recurse-rebase later to maint).
-- 
Duy
