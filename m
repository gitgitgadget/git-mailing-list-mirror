Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2566C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIDX6n (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:58:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeIDX6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:58:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so5148055wrr.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=MsClKJrmXuNYJjCUyw8wT9EycPuGHPe/qzuexdOjg+Q=;
        b=qFySxhs8fJzDQd6rc4V9avB8Vb3v/QPUPJynF+v/UInvkZmEOLGqbAM4++AtoX6dKP
         25c7nL3SAYCuH300cUGlYM3Cn1Q9gmPzF2ELaJtszGsmOjRKu4Y06LOvOluIKLzv/2nR
         0NOSHuOxeQQ4Yp5f83ZPWZLJpBRAvpmJO77pgHcRXXrgsUj849oPirFSVDB0Q5kj8Pov
         r4E6Oq4ZUSHSxM6pGdkVBk2WufQAqO8qQH7ylwXco8XAx44gw0oUVzSGuGuikVX31BxV
         zME8kvw1TrtTZ0Vuxly4Kk1SmwWtKOsKfxfVu/hUBxBirqHjtS0ViFU2cCYHuuYu1IYy
         b/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=MsClKJrmXuNYJjCUyw8wT9EycPuGHPe/qzuexdOjg+Q=;
        b=PdEjVOXWoVtiZSLuzx1ztlYcpAYSZJQ6YaSuWnF8JdwyH8TyLpCHxj84t65ZQwpVET
         O1gCBEvSaIGXBztQuR2tWGlHXtzyFkE59W/B0FPvFG54wgjzA3jT7p+SFec26jIGIqLq
         Z5Zm9EdqHtc/o0tBZvmqBLoZ086jKzRYMcXouwlf4bYFyWC2/93G64v5rDfQxeDdKbvt
         9YGZ5D1p9HyGntbEyE0/RpEnIALvN/Fv4vA3+jas35cgsDY6vqdmnK21Odz/Ls4Sn4UM
         OIo1na7X86DDGx0tL1J1BCg6Fy6/G1vpBk+ECq/kCNv9MBhjHYjZ5N8dbTC8vc7BwJrZ
         VoPQ==
X-Gm-Message-State: APzg51AjzafJrRQ5l3cNhPOwr3YpCIZhi5FfKTfM43xNTCf4QgiQ4gbq
        mUMnH7m7ET53toqOvtlIDSU=
X-Google-Smtp-Source: ANB0VdZbSqNVNQM/oXPEDExSVqSoPeEU++lae6sW2vl6yYPwqaO2pZbuBnQ9AKizUh0tCkzF/LiySw==
X-Received: by 2002:adf:9ccb:: with SMTP id h11-v6mr23990137wre.11.1536089529744;
        Tue, 04 Sep 2018 12:32:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 124-v6sm23728wmk.20.2018.09.04.12.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:32:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] i18n: fix mistakes in translated strings
References: <20180823210056.27489-1-jn.avila@free.fr>
        <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
Date:   Tue, 04 Sep 2018 12:32:08 -0700
Message-ID: <xmqqr2i983ev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Jean-Noël Avila <jn.avila@free.fr> 于2018年8月24日周五 上午5:02写道：
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 2bcc70fdfe..b56028ba9d 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -542,7 +542,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
>>                 argv_array_pushv(&cpr.args, info->argv);
>>
>>                 if (run_command(&cpr))
>> -                       die(_("run_command returned non-zero status while"
>> +                       die(_("run_command returned non-zero status while "
>>                                 "recursing in the nested submodules of %s\n."),
>
> Any specific reason to put a period after newline?
> And there is another mistake just above this one:
>
>     "run_command returned non-zero status for %s\n."

Embarrassing X-<

These are not something the "fix" introduces (rather it is what it
still misses), though.


