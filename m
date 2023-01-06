Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0482C61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 22:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjAFWhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjAFWh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 17:37:29 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD487290
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 14:37:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id v3so2112173pgh.4
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3ZfVUM70vRfqas0BFAxYEFU50UP0aGJ12R0XKm6dvw=;
        b=axjrS9X/H5MJRkUNKiDY2T9zkdIkX6FrcBoxQvr/mjE2SKKhSNz8YzxrgYNBb8tshw
         7cxu8vIdGSbD/ogL4sLpDj86dM2hQcrEh1OWQZOdNVN0DHtZbmg/HM+jZFL8hKUq7gqZ
         KyzNVBYIHF82sRGtjMyiHbHEpLkvmoEiDrbKtp3UgamVzewNbk36ybeEDhLvV5Zae0ay
         FDwSm0PmXr6uiR1w29lOOggfv6h1b3oSiMWTFDmi55pC6V5DiHmlAj/S5H6ozqqrNkan
         niyXQooIOcz1i/64WBGe+XIiX7uq/kILK8JzYYCXSs+OsxqHajYL5DBmu6LM5AEVQi7F
         8Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W3ZfVUM70vRfqas0BFAxYEFU50UP0aGJ12R0XKm6dvw=;
        b=paZM19HYfRjMAmq4SIqueByBWx+QYa/oa0hWEPBIT3SmWQB9/COs/NBaYuWq0+1F08
         dl/jtPTwL/aAPM/AnQ5R8LDMCddK2b5H2lQi/zDdXjVVaPNki6wzeb1oLuQe1EiEFMTw
         Fck0yGqH+WPEX/qgAZ3Rufqt9Cp3SxS57N9Sc8A3R0e8CSmMfzbI7w7BTtyTdQ7eK34S
         dH3jI13GTmJDFNfOs5K8kNp/pzlsfipk2PhbH+Ens0WABJJCAA9k1szaawy0WnU/G7+e
         GHCJXAT5TWis0eDni7PGwIBa90OfTbeb+C8vsxF/ymUGPJ4HnWoFVq2QJlAu/msCIxLm
         aAMg==
X-Gm-Message-State: AFqh2kofIoC332tnasKs+7cPCDzOWgjoF80H6p/Sc85j6N3A+Tnzqc5M
        SNxJU77Nn1+Ki2/Z8VjGqks=
X-Google-Smtp-Source: AMrXdXv3O1IjqZdMd2Y2IVSG78mkBQujuqsA70IOsY/cEuY6QqjYaRB00iJk9GfsLFqFgqQAg8g6Pw==
X-Received: by 2002:a05:6a00:1883:b0:583:2eea:da23 with SMTP id x3-20020a056a00188300b005832eeada23mr8804965pfh.20.1673044647687;
        Fri, 06 Jan 2023 14:37:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v126-20020a622f84000000b005775c52dbc4sm1546830pfv.167.2023.01.06.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 14:37:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] *: fix typos which duplicate a word
References: <20230106131304.20779-1-rybak.a.v@gmail.com>
Date:   Sat, 07 Jan 2023 07:37:26 +0900
In-Reply-To: <20230106131304.20779-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Fri, 6 Jan 2023 14:13:04 +0100")
Message-ID: <xmqqr0w7qogp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> A tricky case is usage of "that that", which is sometimes grammatically
> correct.  However, an instance of this in "t7527-builtin-fsmonitor.sh"
> doesn't need two words "that", because there is only one daemon being
> discussed, so the word "daemon" does not need a determiner.

Makes me wonder if it is more appropriage to replace the second
"that" with "the" there, then.

Other than that, everything else in the patch looks good.
