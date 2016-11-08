Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5152021E
	for <e@80x24.org>; Tue,  8 Nov 2016 09:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbcKHJDo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 04:03:44 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35465 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbcKHJDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 04:03:40 -0500
Received: by mail-yw0-f174.google.com with SMTP id i145so70230767ywg.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fwfMmAc47vHruq8TXZlnJZ21q5j7kQaoG/MfHYX+2F8=;
        b=vFR65LCRRguiCVaos/dDIE8FOnIk+SMJlIXWn/czo1hXcizVq+4pc/8Pow2kTnUSy1
         da8Or/xp6fpfM8cdf4R6y6xezfKsmvRxCq/SG+wlPlRAFiBbgbTGMUSm9kPraTiUiZtl
         nEsi8QBEENieoL9pEfEuGOfctT4kvoB4UrKls9z2QpD4II1QLVM6GafLEmVCgXc6yWrz
         Nt7GP3tqxtDWq0t3WVz3hkwYVvS/aY6Y6kpXhVM4TdnPk5prbrTsPNf3mj0EqXQ3FJ4P
         mLebKl4mRKfk6EltiWmbBnuVNdxM2rZBfgs55p5hb5vUHR6TZiJ/hHV0FHHvLU4Ba2Jj
         26Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fwfMmAc47vHruq8TXZlnJZ21q5j7kQaoG/MfHYX+2F8=;
        b=dqTwxb6LN7SlK05pDHMR2QH825Tq7ZQh6v+9vV7OaXidGqkLl+ide2FQjr262XSPCB
         fmUyFg+O/bC5d0VvocMNYX17qulXdGxQRS8Ymc47vIL/TFbw+R5X9xDtiFVfVSaufATy
         K9C8TxQg+djyWLcgRr7Vyvf9j/nzMh1nPZHPFfFQAnVmQTZ3SqlG2hYWCvj2RilijBOd
         MOKiuV4x16SC4PN6KWNRzNuq/7boFjHKONOZyeuWyIB6nn236QPpundf4exsti8CRASn
         rWislvbCR3oDuJuTRBm1knHL1aDtK2U/n9dJ1C7lPSIF7drumL0zaWF+oKgshJE1SW1m
         vZdA==
X-Gm-Message-State: ABUngvfs/LgtCGd+lRphg2NKtyA/uRtiAqzWkmen0MgmIwgTZnCr4Cd5duWZmZiBcezP8/ra7AqW8a9z3Zfeuw==
X-Received: by 10.129.85.11 with SMTP id j11mr9852233ywb.123.1478595819920;
 Tue, 08 Nov 2016 01:03:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 8 Nov 2016 01:03:09 -0800 (PST)
In-Reply-To: <CA+P7+xo+CJU_ng5OWX1y26+=QPCg6Zxpv_0opTAzsNqeFXAwng@mail.gmail.com>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com> <CAOLa=ZS=X=5ZvSn=AynOLpD1tDcpRkGyO6-m7d2RPoFf-4v_bg@mail.gmail.com>
 <CA+P7+xo+CJU_ng5OWX1y26+=QPCg6Zxpv_0opTAzsNqeFXAwng@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 8 Nov 2016 14:33:09 +0530
Message-ID: <CAOLa=ZQGDuFvPJjt8GPVLvAjKoFvmuzf9UNWVB4okn=a9BgTQA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helo,

On Tue, Nov 8, 2016 at 1:58 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Nov 8, 2016 12:24 AM, "Karthik Nayak" <karthik.188@gmail.com> wrote:
>> Anything I could do to push this forward? It's been a while now.
>
> Hi,
>
> If this just needs more reviewers I can take a look. Do you possibly have a
> link to the series so I can find it more easily on the mailing list?
>

Since It's been so long I feel it's better I rerolled it, rebasing on
'master'. So I'll
do that soon.

-- 
Regards,
Karthik Nayak
