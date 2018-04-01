Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8ECE1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeDANII (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 09:08:08 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:40701 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeDANIH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 09:08:07 -0400
Received: by mail-pf0-f173.google.com with SMTP id y66so7920256pfi.7
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kOHh8jVbQu7XVRvxnLTKNOE9aAkVtvdyeaLj6m8fouE=;
        b=QfInD68bIlPUDc+g0E0TWCOrkY3I756ernQtiayGf1NkAPh8Z+Ylx9eHpMy1pzllwd
         REo3tvPPCNY5Kp4LKzsDPvnNGsTjetBvBAFWd7Xynagj6QbnYSVaqpUaUEYQtEDhn2xv
         qPD6W+vSF00buHrkgLIMFBF1jG7WKXUEqXvWjxymF+TKAzqc1y2yB6cO7lpb4YGvtNiE
         Zk+PCx9HYnD6l7JHSq5HPxsHw6S99oxIyVlVOiMAan+LwWKc3fpAbQGgScGh9I1kujmr
         RDpmhsTGlG5k7fft9/liA13UeztYA+jUqdrUQoBH32AgaKifvayW4uFzniVaSS5C0b7/
         tLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kOHh8jVbQu7XVRvxnLTKNOE9aAkVtvdyeaLj6m8fouE=;
        b=X/7vduWuuDxP21HipEsVIcgHqinnNefMuVkQhzFzusgmHbxiWnxV+8799w5OISxIbM
         wmhbV+XWM4cc/uokKyZpggLAvrM3F5D3cYm2ChqBGcP7KjdmrOt4LW0YOKOuzSEJydGj
         J4YvleplPRYlTZnQCLsSkDewlaS3EaNd+O0rPnzKCD+JCn2BhTM7i5mEOxuEwRS/KiSR
         vRoxtVwzhC9bbXAIh7Svuy5tbgDF0rnPmnrMXeaey4RmKAFtjaLOKDFzJ1kfHB38gHLR
         8B6XlaN0iNksp7CDYleKkjRaMnRYdV9q8OPgkKII48ujACA43iZ8rPvddcHk0X7/UKwB
         GyfQ==
X-Gm-Message-State: AElRT7E4OQi5tOTK0+JKBUmchp9L3W+846yvjoFaWP9+jwIpTxsRGVq7
        4aHEAAFiXJSq22FVBEc9/olKcoAI
X-Google-Smtp-Source: AIpwx49gY8JE4meHNCoy9RszvDpNGYeYFrTguAMIaoPM1q5LIyl5bSIghKO7HMjog+dmNDROR2hJqA==
X-Received: by 10.101.87.138 with SMTP id b10mr3911292pgr.241.1522588086481;
        Sun, 01 Apr 2018 06:08:06 -0700 (PDT)
Received: from rempc0jmh7t.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q67sm26777212pfg.39.2018.04.01.06.08.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Apr 2018 06:08:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Mar 2018, #05; Wed, 28)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <B86BE818-A385-4E0C-9AE1-1E974471CEB9@gmail.com>
Date:   Sun, 1 Apr 2018 15:07:57 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27C25705-EDA7-4CD8-BBE7-F253555C4F96@gmail.com>
References: <xmqqsh8k6khj.fsf@gitster-ct.c.googlers.com> <87lge9x6e3.fsf@evledraar.gmail.com> <B86BE818-A385-4E0C-9AE1-1E974471CEB9@gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Mar 2018, at 12:32, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 30 Mar 2018, at 11:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>>=20
>>=20
>> On Wed, Mar 28 2018, Junio C. Hamano wrote:
>>=20
>>> * ls/checkout-encoding (2018-03-16) 10 commits
>>> - convert: add round trip check based on =
'core.checkRoundtripEncoding'
>>> - convert: add tracing for 'working-tree-encoding' attribute
>>> - convert: check for detectable errors in UTF encodings
>>> - convert: add 'working-tree-encoding' attribute
>>> - utf8: add function to detect a missing UTF-16/32 BOM
>>> - utf8: add function to detect prohibited UTF-16/32 BOM
>>> - utf8: teach same_encoding() alternative UTF encoding names
>>> - strbuf: add a case insensitive starts_with()
>>> - strbuf: add xstrdup_toupper()
>>> - strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
>>>=20
>>> The new "checkout-encoding" attribute can ask Git to convert the
>>> contents to the specified encoding when checking out to the working
>>> tree (and the other way around when checking in).
>>=20
>> There's an issue in ca16fc3635 ("convert: check for detectable errors =
in
>> UTF encodings", 2018-03-15) flagged by Coverity:
>> =
https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE1=
9q=3DPrQ@mail.gmail.com/
>=20
> Thanks a lot for pointing me at this!
> I'll prepare a new round soonish.


The report says:

  >>>     CID 1433528:  Null pointer dereferences  (FORWARD_NULL)
  >>>     Passing null pointer "src" to "validate_encoding", which =
dereferences it.

  411             if (validate_encoding(path, enc, src, src_len, =
die_on_error))

However, validate_encoding() does not dereference it. It just passes the
pointer to has_prohibited_utf_bom() and is_missing_required_utf_bom().
These functions just pass the pointer to has_bom_prefix().

In has_bom_prefix() we pass the pointer to memcmp() which is undefined
for null pointers. I think that is what Coverity is complaining about,
right?


- Lars=
