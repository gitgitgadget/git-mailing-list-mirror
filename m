Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2892B1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfAGT3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:29:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33261 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:29:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so1690870wrr.0
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=0nNXBhJBbIJNQGmYQhGTyNmm1E5xvr5VQWpEomrAdL4=;
        b=QPWvaGXdbkN6bwl0am3e1erUzLfT0Vfe7F+31SmvGmzNFrPVO5zo6f/RyKDLtU7A1t
         6ajin+2NtfWJ/SynUeHR5hK9qxj+RwDIesaz3KU4XnycRT+73gMqQOFiqbp/F2r4eXpA
         KJwZrrkVgVFoKMW9ZNX92Be9bpCSvW4yYXz3ueaTWKD7Ud0CbVhL3Tqkr271G2o4KeVM
         SoDnPakyvucy2ppze0twx9Dn6NnOAIiVB3II1b/lwquiGsjoG7t05sZspeBaQwcc0qyB
         Noq5CK1w1GUdX6M05CWDGhh+Lox3v91RjWsKniE/dBU9Ob+sU4n4gVnlyqKmnhQNjK+w
         6nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=0nNXBhJBbIJNQGmYQhGTyNmm1E5xvr5VQWpEomrAdL4=;
        b=RNZtnjZ4bMiNMpUmmYxXNfPvuzK/mWA9PPaTnSgjE59mWuQgZXXMvk69rZvQkA1JOm
         blLuY1VNmz5lRNse+R+SHMRRB/318UaZ0pePjdYsMwCSHAGN/W6MTfIV8gDVTOCZmtUf
         NiE2jAk2xYoLP6iUyOdplqE81IwhBYPSngXzJPK43UiPf5BKPtJKZlQw0R6UEmBEQ4RS
         JgIO9zuKZgKDEyhV3aoL1yyHf3x2SgjGpP7bo+5Dv43V7DcqaKsZCqQzKXVYrNtHIUNS
         COwNRh/BXYgEfodIKfh+yEoBs/GdNjd4Dy2VhYmaCtjXOOcpp07BHvik0ZXrPTVvlns3
         1Dww==
X-Gm-Message-State: AJcUukdzPXJTrqoB1iIgRADC9+X04bbIXMudHCoybmHrBSKnGV70uR3b
        Ugqsk/tHl/V8SzOES3RSZPE=
X-Google-Smtp-Source: ALg8bN6oVqB7tQVWu9P9Z1o4X+LK4SVP8swDyb6m5pZWdw90yWX43QXntmQG28/yE9M08KL9NXtumA==
X-Received: by 2002:adf:e407:: with SMTP id g7mr50328635wrm.277.1546889384642;
        Mon, 07 Jan 2019 11:29:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15sm49887371wrs.27.2019.01.07.11.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:29:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add optional targets for documentation l10n
References: <20190104165406.22358-1-jn.avila@free.fr>
        <20190104165406.22358-2-jn.avila@free.fr>
        <xmqqk1jkb0c9.fsf@gitster-ct.c.googlers.com>
        <220955359.FqXrlbFPp5@cayenne>
Date:   Mon, 07 Jan 2019 11:29:43 -0800
Message-ID: <xmqqh8ek8dw8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <jn.avila@free.fr> writes:

>> The idea is to use $(filter PATTERN..., TEXT) that removes words in
>> TEXT that do not match any of the words in PATTERN, and for normal
>> build, MAN_FILTER is set identical to TMP_MAN_TXT (which is the
>> original MAN_TXT), so there is no filtering happen, but in a build
>> that does tweak MAN_FILTER, MAN_TXT can become a subset of the
>> original MAN_TXT.
>> 
>> Am I on the right track?
>>
>
> Yes that's exactly the purpose of this trick. In fact, $(filter) in this 
> configuration is equivalent to an intersection of lists, so the order does not 
> change the end result.

That is only true if MAN_FILTER is literally a list of "I want
exactly these things", without any pattern.  Once a future caller
wants to say "We now have translations for pages from [a-m]*", it
becomes apparent again that the order is wrong.

And if the caller is supposed to have a literal list of pages, not a
pattern, then it may be sufficient to update our Makefile so that
the caller can override the literal list of pages we (incrementally)
compute with its own list without any filtering.

> Ah, I see. The filter from MAN{1,5,7}_TXT would ripple the same way as MAN_TXT, 
> just one level upstream.  The filtering at this level would no longer be 
> needed.

Yup.  I see you sent v2; let me read it.

Thanks.


