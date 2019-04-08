Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79B920248
	for <e@80x24.org>; Mon,  8 Apr 2019 01:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfDHBGY (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 21:06:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36958 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfDHBGY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 21:06:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so14309764wrm.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zTtpzxQOJye9J7Rr9zFdO0431kWtkoyoSuQaRaUa5RU=;
        b=SDDcS740zqrBn4h30Ln9WZjPpOvq7YGZv+9+hN4tUDcCkonauDfVe0kttqCEf/zOIE
         sE5Z1JDffJ+KIkoo6XZSbqWCoTR+Ek2l0Edpj1GS9bw11Gs1Jf/XWczSaRpqJVJz/bTt
         qwKfgcTD4bOC2QO5XR78fBu+vBdQsmc/OdIxz2aUfpiIotinOmeK/5cUqNf3IVXctz7c
         P/FOrhjAS+Lfi3WYNs3aG0gE/yDzUfqfI3TflYp52oT7eea6dzn/HwH55VtwPHHMa/h9
         OKT8Hbkwxb+MDUu1tEwP+x0arEqmkNTpOhB0/A4jBsmESFDghEAcMQjZs3AEoOr8QOPN
         7Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zTtpzxQOJye9J7Rr9zFdO0431kWtkoyoSuQaRaUa5RU=;
        b=NCrKLAOgN2quEzTF7vi5Lu626M2sjAAQW+s0wsRQJPP3k96xO+JyGtwZwdGVdFvV+9
         mf6SGD6F5zJW2Bww30x0i/Zfxpkac4jM758AmWDZkY3iRMFwfZ6DvecckVD+yS6Bzw3i
         ObJIsyFRq9ct4+tsJTGkCrBCH/5lkf0n/fZK8JW9ApSjRzm8oS6BKysBNBa0S1oX2grD
         cfTtKaRIoYddbyFHNQpNuH7MRcxd9AAOtSmBEnpvjIegESQdAHg+xQYvaKqWS7qDdaOr
         oszacXI8Ek401vp/eWQYBkTIE/ekfbeT5vcf7nQbkWsrLXyOL3x5+YkBVOpBqO2p1jPm
         ixrw==
X-Gm-Message-State: APjAAAWeu1AHH6xDodoNNT3uGUYf3QvkH+SRKL6MCMQPOuDP4hhDWfaI
        +SQMMsDTP1Svb4ejLyB3Ui3gNzR9YJw=
X-Google-Smtp-Source: APXvYqzg0hJDIzJLjJ7dAEqjr6LEOiakD09rehC83DkIV1j8cO0j05JjcRPHpcGqTDFsMbiFgjhh0A==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr16423293wrt.159.1554685582522;
        Sun, 07 Apr 2019 18:06:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n1sm7203172wmc.19.2019.04.07.18.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 18:06:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: git glossary --help ?
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
        <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
        <xmqqlg0mc4mk.fsf@gitster-ct.c.googlers.com>
        <3de9d8bc-f9d1-bf09-def6-71e5ed418225@iee.org>
Date:   Mon, 08 Apr 2019 10:06:21 +0900
In-Reply-To: <3de9d8bc-f9d1-bf09-def6-71e5ed418225@iee.org> (Philip Oakley's
        message of "Sun, 7 Apr 2019 23:42:39 +0100")
Message-ID: <xmqqd0lxcnle.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

>> But unlike "git foo --help", if the word that ought to name a
>> subcommand instead names a known concept, e.g. "glossary", I do not
>> think it is too bad if we DWIMmed what the user meant to say,
>> i.e. turning "git glossary --help" into "git help glossary".
>>
> Given the earlier report that started the thread Duy linked, I guess
> there will need to be a balance between the two expectations.
>
> The DWIMming may need to both report that it's not a command, but
> then offer the concept guide as the primary target if correct, or
> perhaps as one of the alternate "commands" if closely named to a guide
> (e.g. revisions vs revision).

The "or perhaps" part feels a bit overkill, but I do not mind seeing
it if somebody does it cleanly and correctly ;-)

> One of the issues back then was the lack of a complete list of
> 'guides' to check against, so the badly spelt command logic wasn't
> brought into play.

Yeah, thanks for spelling it out; I think we are on the same page,
having followed the same discussion in the archive, where we knew
that a list of 'concepts-not-commands' would help the error message
situation.

