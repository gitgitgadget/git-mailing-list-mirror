Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F4520248
	for <e@80x24.org>; Sun, 10 Mar 2019 22:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCJWps (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 18:45:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43258 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCJWpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 18:45:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so2507176pgq.10
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=JbnNzkqAaufgkkC3IWTTacQKM4qdhy1C1E3C0pdafxU=;
        b=FMYx8az7tkgUOVhdFAzYTVkuj3SWJateF0Umy5uaxoXnO6IE0KS9+9c1O/YLZtP9qL
         7+FT6BZVPWjary5dik7kqMQ7v3OGQarUeGxE20LPbYm3147TcS1Dz6Zjc/kWz3H16JQ0
         YQk6tNBmsLsZEwxavg8N0/MphUWS1mA6a4cUoNrbTkUUHXX4wC6pIxuc8yiOdMbCd6D8
         064KEl12Ynvxse5Ck3wchcl7GG+DYfb0M/IHg2GhMRstMXVjRf81rf+4Wf5n3Bvqx8f5
         hKx+MdWrn2dKNrvTEmGleSlsAxVH8esbtL7FPTdkjN1QQ8M7E9DnXefa7ff8tT0HunnL
         85JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=JbnNzkqAaufgkkC3IWTTacQKM4qdhy1C1E3C0pdafxU=;
        b=Od/fD7q5oTJP5o6VbemMd7zda4RkbTP7KcojIIdSX0IbbJ41WqZXaA77vZhpIIi6sp
         Ymuuccr1mbTzqlJNIyswJKDh7vpScsc6G0sXMHQhw3dneZm7149FNspGkxxy+dX0L/u9
         leG4tMoXf9epfywl9PeNbBZviCTO7YaUfAdtzoFCgRfRJiyxUstq4UfnF/XGcUAF4eFt
         Tf9aOCjWysT6sSWXJpvDo3D/GefDEBMy8A4GOwOxchUDVoxXZ4tW0y3jpdfnRrWfsMJk
         KtxWXr1FU/Xil/XOc5xK9AOQvJM6Jo6+NGBn6exoDcL77m9WonWVRTIE+VJ7GK0Hga/Y
         VT1g==
X-Gm-Message-State: APjAAAXfxLh9bSzqM1MJeTpeqV8j9KUbho7AUkYihSj7bX7HCvM/TaNT
        WGDh+Y9HU8oN4eRqa0wQ6M4=
X-Google-Smtp-Source: APXvYqxUCsvs0dob5+50+GWfpTHoJppwe15nk8NbCdx4kBkzx1DsrS21eh10PYB8ppZTD9k5H+udyg==
X-Received: by 2002:a62:834c:: with SMTP id h73mr31396243pfe.252.1552257947128;
        Sun, 10 Mar 2019 15:45:47 -0700 (PDT)
Received: from ?IPv6:2607:fb90:8066:1583:a2ae:f28b:247d:d87? ([2607:fb90:8066:1583:a2ae:f28b:247d:d87])
        by smtp.gmail.com with ESMTPSA id b7sm5732124pfi.36.2019.03.10.15.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 15:45:45 -0700 (PDT)
Date:   Sun, 10 Mar 2019 15:45:34 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com> <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 00/11] And new command "restore"
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Message-ID: <6B5DF0A1-DCEB-45C2-B205-E3CF7469B7C6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On March 10, 2019 4:19:28 AM PDT, Duy Nguyen <pclouds@gmail=2Ecom> wrote:
>On Fri, Mar 8, 2019 at 5:17 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail=2Ecom>
>wrote:
>> - --index has a different meaning in git-apply=2E I don't have a good
>>   suggestion except "yeah we have two different worlds now, the old
>>   and the new one"
>
>I will rename --index to --staged to avoid this=2E It is already used as
>synonym for --cached in git-diff=2E I will also add --staged as synonym
>to "git rm" so that "git status" can consistently advise "git <verb>
>--staged" where verb is either restore or rm=2E
>
>Since option rename is a lot of work=2E If you think this is not a good
>move, raise it now, even if it's just "I don't like it, no reasons"=2E

For what it's worth, I think this is a good rename=2E

Thanks,
Jake

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
