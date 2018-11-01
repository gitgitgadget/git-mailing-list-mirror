Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8511F453
	for <e@80x24.org>; Thu,  1 Nov 2018 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKAWbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 18:31:48 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45146 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAWbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 18:31:48 -0400
Received: by mail-wr1-f52.google.com with SMTP id n5-v6so20050929wrw.12
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=NzGoJQzNL9WWQPz3ECEQ7H6zJeRCu7qXkA0buz6N4Tc=;
        b=U1141RNFymg/hYOR5KKmSPgKJj90wwFKOwA27snu+ob3ariVLf6ms+6mI9wnDvuxZC
         bwLplMkMn/3Z1ec+3DPBhRy4cpqXIETvp+My0q8GHdQlqqswCoP2c/dRr1UlYYb2b/1k
         uRRHTKoe5JpthgFzTxVOIF0HT2ogC3mzxBCxTuAiAy6/kK5QWPML/EVgODUePqJ6NZdk
         el4CjYbfR8SHXF4Bic6A5T7XnZv0fnXaRYHltC19mQd70eLLUCwmFHi8pQzGUWjAvZL9
         Auv3Ue647q4C6LkPWPfFCHc4AyU5oBxVahhMyX2HFIVRm0rgbejMUVHTMXWYPJ9fwqcz
         Y35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=NzGoJQzNL9WWQPz3ECEQ7H6zJeRCu7qXkA0buz6N4Tc=;
        b=bNN3YYKvyFUJrhxdpE41WhXZvyDxWGNRoNg3NZogLlfbbE8v2EBnXI/p2nJVdzeTbs
         tCTrKET6ZkXjLaHbB+alYVg7zZrPbeHf1DnpFI5H/oFb4YIBUllt3YiqgniTtCLGA0c2
         sKTqtfPeJW0rpGiQAnN+PbeSMUw6tE/LXZNwMS/CC9Z3EPvLMrYfM1IrJhtWv5HzD/0w
         uwzLBaWJBxLWpscUhqQz9OfjSGzC6pIvBXZeJIVlcvf1mC8N+i2V7IFe1kjuFvhXKG8D
         gg0XB6MBx5TvWjxrPmKU8Fnue2fglk7ZkUsvep7a1bUdSci5q+Nt1IW5bT3JmN+02ZFw
         yn6Q==
X-Gm-Message-State: AGRZ1gJHeDwUOKSEd2wBi/nTH5OGxtNIsA3rJldvj3ZfAuMGaxVAD4Ts
        nV+GOByYc0pUW/wQRZEYwXY=
X-Google-Smtp-Source: AJdET5fEjSNejoPrDqy5r6b1m8yaxzVuJExFqmA8cchfSeEErYswjIorssvuOiyNROQ40P0sj5LEfA==
X-Received: by 2002:adf:fbc6:: with SMTP id d6-v6mr1943879wrs.241.1541078928600;
        Thu, 01 Nov 2018 06:28:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a12-v6sm18662429wrr.71.2018.11.01.06.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 06:28:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/* topics
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
        <8736slkqmu.fsf@evledraar.gmail.com>
Date:   Thu, 01 Nov 2018 22:28:46 +0900
In-Reply-To: <8736slkqmu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 01 Nov 2018 12:02:01 +0100")
Message-ID: <xmqq8t2dsz8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Could you please pick up
> https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
> It seems to have fallen between the cracks and addressed the feedback on
> v1, and looks good to me (and nobody's objected so far...).

If this is the runtime-gettext-poison thing, this did not fall thru
the cracks---I didn't get the impression that "no objection was a
sign of being excellent"; rather I recall feeling that you were the
only person who were excited about it, while everybody else was
"Meh".

Thanks for pinging.  It is very possible that I didn't read (or
rememer) the thread correctly.  Let me go back to the archive in the
morning to double check.


