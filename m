Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C865F1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfAWVUQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:20:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36303 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfAWVUP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:20:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so4196312wrp.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BDz3n84So22cw1qGO3sxSzCW+NajzWD1aWSVb1peNMo=;
        b=WTg7/L1OKmJq4CRjO7MoCC2uo9hTuqKul+Di2UZdI45l0T3BB7Zxsc50ohWofFU6LY
         u92o9rovlQM8uAaU1cf6yYe/mdCLRZUz1wzopH7JrZU4SCQ81/blUpF14Ae7YekOcb8m
         5o9LvP90KQ35Cjq64VcQes/7Lx+uh5YiEqAGKTCPVQuoA1ku/TngbOEnHdLzjwjP3oW4
         v5qRwQxIxmXj7r3LX8kthsjRA+ymOzhEEsUI10cIU51RavKNifMP05CSZf8FVWANEkLi
         aTgaIkHucg7xlfKpewyFvEDigMZXy7KDVqlWov1LQgGqWAtBpvP92s+wB3jSy8JHNhzH
         H1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BDz3n84So22cw1qGO3sxSzCW+NajzWD1aWSVb1peNMo=;
        b=DaWisG27MhEEi2QNRzaoiXaKmMHDi0FzRp0NG/NaLNiuHKOMZXRXI2GvEpipj8EjZM
         +SUJgk59+ZtnFNXpJOxZUsFAzK5C3fITBs9AX5vyCF1Bjj6Au+BX0Fb5s3fT2+4jDCfX
         ULNPQfCC0X8fjgZem6gqpk02chPi2/Qnp7WimfWipq05Jg4I2Do9Gw5LTKGBozeOEA56
         PbUttBOsiGxRs/sjQwKl78CTyQbbgooqmyexiY972DvVWg5lOxNghznVyXRVVEtnH7f1
         KSmj3FwQd5diEInVPx7B6TyZgdirE3Bi74vFCm8mq7/WXEv5AfrvptvV3d47LmxLGqoH
         KhBw==
X-Gm-Message-State: AJcUukdqZCvm0czjyck3f3RsVhJr2yBEFaC534au+gXUMhuMQMpFqiGl
        0EEruRLJcB8PEeDuQdc/Mf8=
X-Google-Smtp-Source: ALg8bN5HZp05HWaeMKNS4fIlqGIpZnF7KgsNj2iGplAY4rATo70SfdXXKBgWTw0jDO5l8oa4POxZ+Q==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr4287230wrc.0.1548278413708;
        Wed, 23 Jan 2019 13:20:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 133sm59813645wme.9.2019.01.23.13.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:20:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: tidy asciidoc style
References: <20190122201635.15961-1-jn.avila@free.fr>
        <xmqqk1ivb1yp.fsf@gitster-ct.c.googlers.com>
        <3206857.CYPHc56XGh@cayenne>
Date:   Wed, 23 Jan 2019 13:20:12 -0800
In-Reply-To: <3206857.CYPHc56XGh@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Wed, 23 Jan 2019 21:43:20 +0100")
Message-ID: <xmqqva2f9ilv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <jn.avila@free.fr> writes:

> These styling fixes were raised by warning of po4a when processing 
> the files. Otherwise, there's no hurry in pushing them.

Yeah, but as we postpone it, all the topics in flight that wants to
touch documentation may get blocked (or cause this large patch to be
redone and reexamined).  I think we'd rather fast-track it after
reading it over carefully (which now I have done).

> This does not affect the formatting of  man pages. For html pages,
> the content is different but there's a rule that repeated spaces are cranked
> into a single space before rendering in the browser.

Yup, that is exactly what I thought and the answer I was after.
Thanks for confirming.

>
>>  - How are you finding these?  
>
> Editing the intermediate po for translation, the tabs are shown as special
> characters \t (in case there's some formatting  to preserve).

Ah, that makes sense.
