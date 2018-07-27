Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21DD1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbeG0SvY (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 14:51:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45810 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0SvY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 14:51:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so5782132wrv.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+wi2B4fZo+v5T28we8P6eAG4tbunyhEi3J026H57Vrw=;
        b=D/5zaF7K47blZJB6Qjx49dVIgty9gDQ7UEGijtYP1Fl4hp2xkq43TZtuWwkP9I2UBC
         V9aruR8BkYlmTrvLi49fxA1ORKWmeHS86BFyphZ7uv+hMnf4bYtNgeZwTZMZHbmYnJrG
         f31XF447GK857ab+zEwu4ZjyYM01iij4UCkiAqW5m1ea0kiXCpob8qA4d6eGJ10Ecm79
         LMMpSA9ED/3EpmZDR4Vrxvtgwe9tu6kO9fs3o8w3SpPqYAjQt2AwzWNE6JehzLh9A3Oh
         7pF+DnRQdGQ+ozbuQ4fYcHxFXdRX5Qe2Au/PfGtke3Y1g/Cnp3NCw3FltUq6xrUakm8B
         rZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+wi2B4fZo+v5T28we8P6eAG4tbunyhEi3J026H57Vrw=;
        b=i1P5KAZ4FVM5tr6h1RA/v+zz3bh09ge5H7jMq4eiGuLjxhdid4ADUSYo0eGLGQUY5v
         hlWObvSLZCmgFkv7AyielX6G2EFHN72rZShiEmpXLOkHBMwPF8RtgB9b/kYYBkWziwrc
         mPEA86cEY3kNOtpE8Rr2ccMOFGqM/xFKtc6+7fehnnIR+1iCk9j4YfKMO8ETurOkTU1K
         KAftqZ4Wo42z3QokQR6YaX9IPO2r2tI5imWyG7PbLtdpNmxmzC7JkGtC/QEkCD/M2vAI
         /i/9rvUS/tDtiZ5eKu4HP3vXZuCFl/KM9MeYy/vFgBI5A7T//tUkIWgUOAIe8baIwWSS
         ByJQ==
X-Gm-Message-State: AOUpUlGD2XVZP15DuoSbdXuTnBdGpHVt2Sw9PoA0E8NnvfT+Db67sHk7
        fVGY6PsNJt3pZPDJvlVDsxs8K884
X-Google-Smtp-Source: AAOMgpdEeXmRiM7J7eB2r3XtVerzQxa6hymMiOEyQ5zrqOq5zk50glQn6tC/3aakV+1zk4gv97AeJQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr5324069wro.263.1532712511238;
        Fri, 27 Jul 2018 10:28:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 133-v6sm7297594wmh.27.2018.07.27.10.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 10:28:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <87fu0469d1.fsf@evledraar.gmail.com>
Date:   Fri, 27 Jul 2018 10:28:30 -0700
In-Reply-To: <87fu0469d1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 27 Jul 2018 16:28:42 +0200")
Message-ID: <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Count me in the "this is useful" camp, but also I did look at the latest
> submission this time around, but had nothing to say, so I didn't say
> anything :)

Please make it a habit to do say something to show that you did
carefully review the series especially in such a case, which helps
to differentiate a change that is interesting to nobody, and one
that is so obviously well done that there is nothing to add.  

What I have been doing from time to time, when I think there is
nothing bad in particular to point out, is to quote a part that is
especially tricky to get right and think it aloud to show how I
would reason why the result of the change is correct.  This type of
review helps in two and a half ways:

 (1) We can see a correction to what the reviewer said, which could
     lead to further improvement ("no, the code does not quite work
     that way, so it is still buggy", or "no, the code does not work
     that way, but triggering that bug is impossible because the
     caller high above will not call us in that case", etc.),

 (2) The reviewer can demonstrate to others that s/he understands
     the area being touched well enough to explain how it works
     correctly, and a "looks good to me" comment from the reviewer
     on that change becomes more credible than a mere "looked good
     and I have nothing else to add".

Thanks.

