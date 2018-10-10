Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667731F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJJQ0F (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:26:05 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38122 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJJQ0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:26:05 -0400
Received: by mail-wm1-f54.google.com with SMTP id 193-v6so4824072wme.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=C5m2dEOqXcNjAnX3chg2WN5H9EWdrL5+V/BawC4NS3E=;
        b=mKe+YFyzT5NUdBmeHjyqpvi1/AHBY4o9o6cgVBwd7D7/K1hixkQOLjA10P0PFEXzn5
         RAiwEDuAHf9vIDchFUT6Z5Jvr+bu2kYpXvM5rQnx+ypkGTDueYLiVqNqJX8jdLGD4slp
         4LcrxrdxPemVbIsjOHDwuaYLK6B16pUrbs2IRBLo08au8y0RZCdJKnBE1AuFjJXV8IMn
         1Ks7hiTkVHZfaBbjoT/r4EwZGA40ZxVyqpIo9VCwk15CQTYjepam/jRhTJ6I5qUQ/JEr
         FFdgY0FbUqGzofsWGicXLdQA8uBlY6qltHQ/0qHBzV9z+usED+Z4+ho7bWA4wGEi0Nwj
         /yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=C5m2dEOqXcNjAnX3chg2WN5H9EWdrL5+V/BawC4NS3E=;
        b=R1ZdTBSRf0zrsKifEf23pQ3U0lFF3ZHw58YnwuDD0eZ7bi4KvE2a0nla7fE3gOBnl3
         PKZR5fsUOGspwIZHTpGn9/DixHOnEqCr8wCr/FDcZZUBaj5kShtMT1IQHoBog7uokNpn
         S+r70nkxTTr62zIMXZapyj7axQ7IlJVTtJ4X28K1gxZXUuq2QCPlI+TzLPdgKzQqqq9v
         EOanXe0xtCItkm+G9jvTl+6vmJJ801oECvHdjcid0PjuzGx5XXjbcZ3jVgWdML+bZ1n6
         0ELIYgtsuYhPqIBrnlYRWe2rNHBVjaP6nCrBsmxINeSnXjlQsmRR95V+cPWqDGCrEk4e
         tXxQ==
X-Gm-Message-State: ABuFfoj+rM9hFgZ9xIPnzOH1OOaHmvnX4ZdmM5eo1d9F5buGRXM+B5CK
        PE9VjvdP6WRmWUMW+v24kBXABDR4
X-Google-Smtp-Source: ACcGV62Xk2Np62M6V8eHUVQMRVvYEXq9kGYVljikUUeCFLQkTY2/qHo0O4h0XuWYkPxWDek/Qt0vHQ==
X-Received: by 2002:a1c:adce:: with SMTP id w197-v6mr114681wme.11.1539162290730;
        Wed, 10 Oct 2018 02:04:50 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id s10-v6sm8658515wmf.15.2018.10.10.02.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 02:04:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Saife <tsaiferodrigues@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Translation to Portuguese
References: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com> <87bm82fcmm.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87bm82fcmm.fsf@evledraar.gmail.com>
Date:   Wed, 10 Oct 2018 11:04:48 +0200
Message-ID: <87a7nmf9zj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Oct 08 2018, Thiago Saife wrote:
>
>> Hello Git Team.
>>
>> I would like to help to continue the books' translation to Brazilian
>> Portuguese and I don't know how to proceed. Thanks in advance for your
>> help.
>
> That would be great. Have you seen
> https://github.com/git/git/blob/master/po/README ? It describes how to
> create a new language. Also CC-ing the l10n coordinator, Jiang.

It has been pointed out to me off-list (thanks) that I missed the part
where you mention a 'book', and we already have a Portugese translation
of Git. Sorry!
