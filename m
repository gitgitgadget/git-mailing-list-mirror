Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709891F453
	for <e@80x24.org>; Fri, 26 Apr 2019 17:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfDZR6d (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 13:58:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44222 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZR6d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 13:58:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so2069612pfm.11
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=0NKIo9sGdq/4f/x49RwthCAh51qWlaK1TS+fShzp3Rk=;
        b=u8rRHsyGD7KBhGfwsOtlYZXjrZzTSYuWCiNbwhjFhuXx+FQYeZiI4/5GhehgY9ohcG
         azIOYKQzUDb2dHsvuQiMBEUeMiUbJJPVJof/Cr0OFa3hQic9DyC+CfNCW5gjR9atAtwF
         CgFXBi02sDcQMv2lJSxhtXXQA54nPfw+lrfXocYMYPDDgXeWMyBaUlP/HJKGQUBlBVCw
         OAoSOwfzL5LNAxVEpp/KrfnFU4v/zVIMYeJvue4Qr5CfiFXBKB+e4Oe/1Q/HqpCsVUe3
         +Tn9a3CBFUaz5vc1IMSnbHcPqDwlfz6D44QBvx0tXayy38ULF53/vGnNjSX4WAyejMbg
         3dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:autocrypt:subject:to:cc:from
         :message-id;
        bh=0NKIo9sGdq/4f/x49RwthCAh51qWlaK1TS+fShzp3Rk=;
        b=cCQ6awsfXuaCcufPNqW70cQPu0xj5patZhW3QxZRtD2W7w6ZNd4Gp46zmzDc7ya3x9
         eaJlmKl2nuKQrW1BCmkRJRNxJkHClouee4HFbrv0l6aprkGc92LekRhsMXRjmGaQD5oc
         yIcvaWYiHh4sTIJoUt//mXEFa7ZQcGJtEqfCBf1CHrnH8M/jq7COGofCX2YM1I+hgqiU
         NT2XLJYCyw14gIy7TDgF3f1PnsmQvHib/ElAND/83t3PK3i6qMQdQ49FX/ApE29nkpwb
         zoaIO4+Bh5M37o6mxacm6fGNpKPhsHBdUR8V4zCKRrqMtVZ0EzF1GrZ69l+JucCliR9D
         rCUQ==
X-Gm-Message-State: APjAAAXRwu504W+FnyrVe9KC7A/rfJdiaUgBPYcFL+iQapXj4e7btqKD
        OqKrt5XzJILEzAxAmszo87U=
X-Google-Smtp-Source: APXvYqzWOwdNQvno0BIfk2qcBSJAUWEXS1Fj0n7ltMchltUsHB+xaCiQtHzzXzr0R4321w0LVs7TmQ==
X-Received: by 2002:a65:51c5:: with SMTP id i5mr23325059pgq.189.1556301512466;
        Fri, 26 Apr 2019 10:58:32 -0700 (PDT)
Received: from [100.112.22.39] ([27.62.7.71])
        by smtp.gmail.com with ESMTPSA id x128sm47502449pfx.103.2019.04.26.10.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 10:58:31 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:28:24 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com> <20190426050531.GA7854@Taylors-MBP.hsd1.wa.comcast.net> <xmqqd0l9uxv1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=kaartic.sivaraam@gmail.com; keydata=
 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
Subject: Re: What's cooking in git.git (Apr 2019, #05; Thu, 25)
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
CC:     git@vger.kernel.org
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <E6B28E44-5859-436B-A620-2FB484EEB657@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,



On 26 April 2019 11:11:38 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom> =
wrote:
>
>Unfortunately, I do not know how to ask GitHub web UI to give us a
>simple "log --oneline" equivalent of list like gitweb did (sadly
>cgit is not much better wrt this), but I think clicking on the
>parent link starting from here
>
>https://github=2Ecom/git/git/commit/c49927fca0de4c213ae9b21dcb7eafb80e453=
d27
>
>and remembering (or writing down X-<) the commit names would
>eventually give us the equivalent=2E
>

May be you are searching for the following view which lists (similar to gi=
t log --one-line) the commits starting from  97dd512 which is the last in t=
he tb/unexpected series?

https://github=2Ecom/git/git/commits/97dd512af7ce4afb4f638ef73b4770921c8ca=
3aa


--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
