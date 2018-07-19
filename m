Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417011F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeGSTNx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:13:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52183 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbeGSTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:13:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id h3-v6so6707476wmb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z5LkOSO6gwo4GWeMpiDyepe0nXG/Fo3ScGg04nPbhUQ=;
        b=e+WHL1qGwg2fMyt/VT6op3Qvql1aqLrwMLl11peMiUbIe2x1ec4K9A2M11nD5LihHe
         3VDO0i8yzGViO+PJheDI8zdjLdUGcuJwethyrfmiS5L7ChSyMH6EL8q0b5mpY37gxbYZ
         g9QVsT59yb0JAvGKiN5gKt+i4MWUE6mcj/Igo3uaN7YNCbg4SBBPkgzTLMjO5PPqmnyO
         sX4kIXh0omzBfBsODhX3vgKN3PydOStN1tMzFp2goPyaNpaIT3zllJadt6E4qPc0v6sq
         cZp52X6cy9BJPFcYJ7upxKb5KRftPa93X+Um9q9ZKfOJilOg/qXVk+kWhhMzY3i7aHiX
         7Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z5LkOSO6gwo4GWeMpiDyepe0nXG/Fo3ScGg04nPbhUQ=;
        b=hkg5hrssysUVhE0r7WzQLTiKjky0vX56pB7KquDHHfcMUMLM6wfoI6FscVvHPpXeF6
         o6sVhHvWe6KgCSiJ6w4mI0oIhijKNLB0nrKIuBoXXlhBcR6IHkx9H3VedSMRikSfUA0X
         GnDzZos52bZqvNDLug//drKgOhwxzi1ZtobpXdIHGieHVD4DZYp5CTxK6oJToB9DrNIO
         sdym4bTCl2iBvqSYHoyDhgnz7X1Z+Sn8oKIVKNoXPavuXEWASsXsmHcfoC0X9m+43Qjn
         SH/cBI8hTVHCHaAP+9rIGKNcPx98Cs/zIL85mkJBMvWJPWlOKXPsENaJkWhU8Ay8hVQI
         6DcQ==
X-Gm-Message-State: AOUpUlE3lDBkDr3h8g1k5/D1oDmjdHB2GEIdKxkix5qJAlFgnPjf47mT
        H6z9cWYMm09mjrqJBgb9alE=
X-Google-Smtp-Source: AAOMgpcCk/zlSE2lrE6JLnD/aG2sRxJJ+c7+O8B71NeaatfJPGWSn++Kkix0uCoXG0+AAWbm72ZAMQ==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr5082948wmb.14.1532024969068;
        Thu, 19 Jul 2018 11:29:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 79-v6sm338248wmf.5.2018.07.19.11.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:29:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/23] Update messages in preparation for i18n
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-2-pclouds@gmail.com>
        <xmqqr2jzf5rk.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Jul 2018 11:29:28 -0700
In-Reply-To: <xmqqr2jzf5rk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Jul 2018 11:18:55 -0700")
Message-ID: <xmqqeffzf59z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -622,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>  			 * location; error out even if XDG_CONFIG_HOME
>>  			 * is set and points at a sane location.
>>  			 */
>> -			die("$HOME not set");
>> +			die("$HOME is not set");
>
> Meh.  There are many verb-less messages e.g. "only one X at a time"
> that are not given a new verb in this patch.

Just to save wasted work due to misunderstanding, this is merely
"Meh" (I do not think it is worth it, and I wouldn't have included
this hunk if I were doing the patch, but since the patch has already
been written, I do not mind having it, either), not "Reject" (drop
this and resend).

Thanks.

