Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E871F597
	for <e@80x24.org>; Fri, 20 Jul 2018 23:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeGUAei (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 20:34:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54155 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeGUAei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 20:34:38 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so16849545itw.3
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pJd30o8u7krb0ei8v5iFAABaVTFEYx2R2FsOUS36vsY=;
        b=Zxnc7jPTy6Bn62oY8cK+tbs5X6Tc8LpUSdxICkwi5ADbwfiPge8k1TgO/B5qo/oAzG
         QL32YTDTHJwCGsqf0qQSorfJMOABdGs6eTYa5qqDoqICQCcq5GMaKbBNFXFI9fewHuuX
         flSAJXPlxFnD3vQ9FDST/qSSVGdLuIQ4pPJ0pv4KFV8nDYSduT3moZUaBGokb9frsWBT
         /6EI6kQeJS1Iq1enfB2RuduIebFbKbUW29JIxvcNxhKmLsE8OIxGBXI7wuDWuSPH6THT
         koCSML7nerD+V8xLvNuEyybXkayTXdKU0cO0w4F5C8EmPHOI9jfkirHVZVRIBV/qe6Kr
         byqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pJd30o8u7krb0ei8v5iFAABaVTFEYx2R2FsOUS36vsY=;
        b=U3KOqKOw+UJ6M4U6iSfpjh0nflHGVqL6XzWDMVF2kW4GoYdDFjyS/1OqboptuF2q6Y
         yW9fS/0fjV0zAimRni2P3cWRf722pDC43z3fLuEX5YY2CRsqOD7P5cnDoqMRV97VYlc0
         ltZtrSGnB1heARd73JkUExo/a3mMf9CBp0f65khkp5iC8tXaMIRCXkHQigtD9D526Y/L
         DvlUlp8zZp7VYvECE2gWXuRloLJG2fCzC3C5bI/4c1HVLfnCsNv4BNWNdb4YWvCXEgQN
         E04DqMWzJiPHyFXZdtHyhJBzB4h7qxb3AsD2Bg8mlYK1mrZ/38nTtFROcrGXCJzb7bF+
         E0Yg==
X-Gm-Message-State: AOUpUlFopk5VOSEQXyQDOprID8u/CRAcoUHLDbeDz+4nBOOCSTwa3w1p
        OusAm8VqQoFNb4p9qDmmitF871Q6mH3TXtZ3nO+Jmw==
X-Google-Smtp-Source: AAOMgpft+T7RGFmSCBYPuDxUe9UEiFkWAVidbdie4qsnhjUc5fT6mxsrw9p6YCOjmhcWph0YcFIzdt7FHMT20sULn9M=
X-Received: by 2002:a24:54d:: with SMTP id 74-v6mr3369296itl.96.1532130247965;
 Fri, 20 Jul 2018 16:44:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 16:44:07
 -0700 (PDT)
In-Reply-To: <xmqq1sbxa6mv.fsf@gitster-ct.c.googlers.com>
References: <20180720215349.179542-1-sbeller@google.com> <xmqq1sbxa6mv.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 21 Jul 2018 01:44:07 +0200
Message-ID: <CAP8UFD3vyphLP0P1Y2oDCCcz--qXz2G1=r9X1iVnq=bwuS9+3w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-interpret-trailers: explain possible values
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Maybe we rather want to refer to the options that are described further
>> down in the document?
>
> I have no strong preference either way.
>
> The patch looks reasonable to me; Christian?

Yeah, it looks reasonable to me too.

I wouldn't mind also referring to the options described elsewhere, but
it could be in another patch.
