Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C83F1F462
	for <e@80x24.org>; Tue, 28 May 2019 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfE1JvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:51:25 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44826 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1JvY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 05:51:24 -0400
Received: by mail-wr1-f45.google.com with SMTP id w13so11106344wru.11
        for <git@vger.kernel.org>; Tue, 28 May 2019 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Vs3ulrhSatI07RsZl8XMqraOzjO5Vrb7AyIGWpWKov8=;
        b=lPwp89yqDCvg5XyJg1Nep/+gouzroDx2LE0YrenT8+9M8/kLEILPTTYlHk+g+qkwgg
         UgH8EK4/Jh+/RkvPBiDhGp/Xwbd9tB242ZDuv5pMBvWEB88Q7Pc/zOAHkKffnI+xOhUR
         tOKu/KzkJQwwirwH1Kfpw7yXkjEblMZGm+2ls1cHHlC/acIgqsOaOQZikbSOkVzS5iBA
         sMCzdOi8n+HlFy656yHsQZSd4QncSgy1+MM6BvZwJ70vE2NumEM5wtjjpiTur9h9VqYB
         qXCpS26f1pE2+vZUiL9wPINIoOcES2ZB1+KW7l6bf01Hl4Fl4TJVjzH6Js7PAtPPL6t4
         BFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Vs3ulrhSatI07RsZl8XMqraOzjO5Vrb7AyIGWpWKov8=;
        b=k4oOR/9K9b6gatZtY+vRxIhjOAiajP+kyoyZgNB8/E0ccRA3Z7ZRf+soM8ObhysX9S
         5Ak0fjgARxzzfbzMhXoRLCL4z8pJvEqn6zXS4TUgaJ53RWdQlEjoY3OUHnm3Llprrqnb
         PW/vrCozi2wC1N+jnho+3Bu0PxcnKlkTDqfx4kO4A5IpuCcmy1dx7wOlTm9L/CGXlsOQ
         bgP4aC9mawYgrTSh+YuTJ1JhsBpQddEmlkYIoxzydFxoQC3iM7rN1QzaSe5FLwnEUYi5
         16Q5ekku8PcLzLrB+21VPhJEVjbzi+l5BnXsNEDUr0WxyAmVUH32J+Cyo+hG/hWT2bg4
         DdIA==
X-Gm-Message-State: APjAAAUbjqtHAPZEbr1yFYdByTYUejI6yA//npjEumR1FVMSY2Xll0m1
        mm8UHd7/O9a2eoPmnkZJ89U=
X-Google-Smtp-Source: APXvYqxjp+DohV61Qm7OCrSDnLzsf6CjndQaytipcfWqbtbtvtMjVMN5Nhf6dQWg7jwMROyCRrMSXw==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr73716465wrw.56.1559037082177;
        Tue, 28 May 2019 02:51:22 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s9sm1726373wmc.1.2019.05.28.02.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 02:51:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Vanak\, Ibrahim" <ibrahim.vanak@hpe.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1 mismatch)) !!!
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM> <20190528093728.GA15106@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190528093728.GA15106@sigill.intra.peff.net>
Date:   Tue, 28 May 2019 11:51:20 +0200
Message-ID: <87ef4inbzb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 28 2019, Jeff King wrote:

> On Tue, May 28, 2019 at 09:10:12AM +0000, Vanak, Ibrahim wrote:
>
>> We are seeing issue with GIT 2.14 version. When we try to clone the
>> repos, it is taking HUGE amount of time on HPUX, whereas on the linux
>> machine with same network configuration, it's getting cloned in less
>> than mins. So we want to know has anyone reported this issue? What is
>> the fix for this? Has the fix been released for this? Whom should we
>> contact for this?
>
> I don't know about the slowness, but...
>
>> Below is the HPUX system where we are seeing issue, it is taking 1 hr 45=
 mins and later it failed:
>>
>> root@sstl002.in.rdlabs.hpecorp.net# uname -a
>> HP-UX sstl002 B.11.31 U ia64 0158936019 unlimited-user license
>> root@sstl002.in.rdlabs.hpecorp.net# time git clone git@github.hpe.com:HP=
UX/SysFaultMgmt.git
>> Cloning into 'SysFaultMgmt'...
>> remote: Enumerating objects: 63627, done.
>> remote: Total 63627 (delta 0), reused 0 (delta 0), pack-reused 63627
>> Receiving objects: 100% (63627/63627), 681.90 MiB | 111.00 KiB/s, done.
>> fatal: pack is corrupted (SHA1 mismatch)
>> fatal: index-pack failed
>
> Git v2.14 uses the sha1collision-detection implementation of sha1 by
> default. That has a bug that was fixed recently with:
>
>   commit 4125f78222749cb8fc91115abec3ac83e5dfb194
>   Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>   Date:   Tue May 14 00:17:01 2019 +0200
>
>       sha1dc: update from upstream
>
>       Update sha1dc from the latest version by the upstream
>       maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
>       sha1dc with UBSan", 2019-03-12) for the last update.
>
>       This fixes an issue where HP-UX IA64 was wrongly detected as a
>       Little-endian instead of a Big-endian system, see [2] and [3].
>
>       1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/=
855827c583bc30645ba427885caa40c5b81764d2
>       2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba=
9@siemens.com/
>       3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50
>
> which looks like it would impact your system. You can either:
>
>   1. Try v2.22.0-rc1, which will be the first release with that fix.
>
>   2. Try cherry-picking the various fixes on top of v2.14.0:
>
>        git checkout v2.14.0
>        git cherry-pick 23e37f8e9d5961c0c8d52ac481693d3fca5309ce
>        git cherry-pick 07a20f569b4b1690e717eaac0954007a8edfbfc2
>        git cherry-pick 4125f78222749cb8fc91115abec3ac83e5dfb194
>
>   3. Compile with another sha1 implementation. E.g.:
>
>        # if you have openssl available; otherwise,
>        # try BLK_SHA1
>        echo 'OPENSSL_SHA1 =3D Yes' >config.mak
>        make
>
>      Note that you won't be protected from collision attacks, but those
>      are still impractically expensive to mount at this point. It may be
>      a good tradeoff until you can upgrade to a more recent Git.
>
> -Peff

As a follow-up perhaps we should hash_object_file_literally() early in
main() (or maybe just clone & init) to detect this issue & exit with
some "zomg broken!".

Vanak: Also, this issue suggests whoever compiled the package you're
using (you?) installed it with a failing "make test", so a lot of other
things may be broken...
