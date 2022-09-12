Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1BC6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiILQPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 12:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiILQPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 12:15:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00712FD08
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:15:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e5so9100339pfl.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=Gf1zV51nW3N76UhJjZRFbeWwvhGxabrh81RigKJH7uY=;
        b=nUMxbK6BOXujfxHcZx+UmHhx8MzCqRBeXYtR0iPlN7q/LfkZBe7aOurmWROi4vDHwJ
         jPEqFmAldRKLqGIJ6jkE0NT3W/e/7c9cHaMxHUcIutLU+ZbUyUdeYKPMxefQdcmA0eme
         d38zgqNubbEfhv6JfsuB9jnC51Cx31Z5pvm8zdxE8EMW2Jt/VmUREBpgRJU7poixJKqb
         j7YiTTCPvlMohr+sEbPVkvdaqyfKUiyDTmhuMmL2pry0/Y36XzAcibd0GNYB/Zfe1zCe
         SsOt9oL8sRELHkmb1XinfYK1Pjz8H+4gypLaoQRDj/RhpWGqashOacOsUlYS5BYFj26S
         Xxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=Gf1zV51nW3N76UhJjZRFbeWwvhGxabrh81RigKJH7uY=;
        b=oqEaOIJUY+AhUmfjdOvMVGHD843O4VWkeVLLWmQHd+R8VZbTs2SdGQb3QNZL9rT19F
         vrDxpQVpHjtDOV4UMbvqSux6piWbMpwMlUi0v2qrhGI0p8Ms3teN6RZrsWwBwq8fBNXD
         kGpP42L26hOqnLd5H7rzd6QwNBLCu3T3t3Qj16xCT5gJXd4mk6U78Cd97CNFEX7t0WZ2
         TAgOP3qhmAat+ui+5dvMe7UQ436Y4JjzwK9yrxj/AFpK4IsIpFE+ysOj5u8yTsYFs3wj
         0+d+g/iPqYmeOR4OdHLwCpUHY/ob0ijGff359DpD2e2s/A0mXhpzc+d1fJASmjHCepLd
         LR6Q==
X-Gm-Message-State: ACgBeo3ZrutY5fZWOMZlhFBH6uvbbOTTX6mBsHt/7mHJgrwF+jIIColQ
        vYLIWEatlZg9+PaZZzP4I68=
X-Google-Smtp-Source: AA6agR5F6+zmJMze/JBU52v81aeg9d+E+cjOz2EehKFxc38KEEnhvsHykUehMQ7W7ecd9HIbZP9+HQ==
X-Received: by 2002:a63:4d43:0:b0:438:cd6f:f8dd with SMTP id n3-20020a634d43000000b00438cd6ff8ddmr9043736pgl.259.1662999300346;
        Mon, 12 Sep 2022 09:15:00 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b001782580ce9csm4289145pli.249.2022.09.12.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:14:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jacob Stopak <jacob@initialcommit.io>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: fix various repeat word typos
References: <20220911102320.39954-1-jacob@initialcommit.io>
        <20220911102320.39954-2-jacob@initialcommit.io>
        <CAPig+cSsJ0-MOzwy1Nen7MA0nXYmdtD25k9D5KbezKEwrYTNig@mail.gmail.com>
Date:   Mon, 12 Sep 2022 09:14:59 -0700
In-Reply-To: <CAPig+cSsJ0-MOzwy1Nen7MA0nXYmdtD25k9D5KbezKEwrYTNig@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 11 Sep 2022 12:36:24 -0400")
Message-ID: <xmqq1qsgh8n0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Sep 11, 2022 at 6:26 AM Jacob Stopak <jacob@initialcommit.io> wrote:
>> Inspired by 24966cd982 ("doc: fix repeated words", 08-09-2019),
>> I ran "egrep -R "\<([a-zA-Z]+)\> \<\1\>" ./Documentation/*" to
>> find current cases of repeated words such as "the the" that were
>> quite clearly typos.
>>
>> There were many false positives reported, such as "really really"
>> or valid uses of "that that" which I left alone.
>>
>> Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
>> ---
>> diff --git a/Documentation/howto/keep-canonical-history-correct.txt b/Documentation/howto/keep-canonical-history-correct.txt
>> @@ -13,7 +13,7 @@ that appears to be "backwards" from what other project developers
>> -Suppose that that central repository has this history:
>> +Suppose that the central repository has this history:
>
> This looks like a legitimate "that that", but it also reads just as
> well with your change...
>
> The the rest rest of of the the patch patch looks looks fine fine.

Yup, that matches the result of my scanning, too.  Thanks for being
a careful reviewer.

