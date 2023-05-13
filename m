Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAFDC77B7F
	for <git@archiver.kernel.org>; Sat, 13 May 2023 05:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjEMFyP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 13 May 2023 01:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEMFyO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 01:54:14 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6851708
        for <git@vger.kernel.org>; Fri, 12 May 2023 22:54:12 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7577ef2fa31so2163613585a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 22:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683957252; x=1686549252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pilGDFm/VosIOHa45kS2enuYPmLcBZSKke+0Xwxp8jk=;
        b=ZL2PTrfJqj0re3ZxhZPJF6FgH9MpZXb3E1tbxHzbgmAzI8SQRkZuiY43bWoHyqVMDh
         XjeciJmFQhDYMOYtMTyYw+JaaPXY/YqFtUIkN02r3ja1ZzQmabdoPmXED5RD2EVeyKB8
         7JeYK1PK5/UNcHOL0i89rVPoiJ30iykM3kwkJeg2wSDPPozQiXob+MDklBLkq6eBtuht
         yNxaRRzGmaCHjXrP/EtajpjGw6d1MRkv3vRhYWVxkDFO4HigNXQlabIMHyKqfxGlBsfW
         SaxRMS3+ExJPPCL5H8/f8gnZjL5bRPNCZxhbOTksXh7RH4W1rFKXGnNR0tGdcvSi3a2m
         zDqQ==
X-Gm-Message-State: AC+VfDxwN7VrnmycmQMNN6kh1DdbztFPV7cuc02yWvDWJh2L2mNyX0vw
        nfcvr/LaPkyAj1jrwSsu7imsjQzMWkcmbxcrjD8=
X-Google-Smtp-Source: ACHHUZ4QVhS0TyP0kNXP4CBw1LaCle6M/V+KcF3c7UerpS5BlWFIDdL+d9r0+91nG3bmQ+kskTkjNpJdZe1KdUbegaI=
X-Received: by 2002:a05:6214:d87:b0:616:49fe:f150 with SMTP id
 e7-20020a0562140d8700b0061649fef150mr49325942qve.18.1683957252017; Fri, 12
 May 2023 22:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230511194446.1492907-1-calvinwan@google.com>
 <20230512171429.2202982-1-calvinwan@google.com> <xmqq5y8xpabr.fsf@gitster.g>
In-Reply-To: <xmqq5y8xpabr.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 13 May 2023 01:54:01 -0400
Message-ID: <CAPig+cR=BdoyDNaS2Rrx8+07yT_FFaJygPyVyuBKw_DExX1NbQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] strbuf cleanups
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 4:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> Calvin Wan <calvinwan@google.com> writes:
> > Reroll with last couple of nits fixed. Thanks again to everyone for
> > reviewing this series!
>
> Looking good.  I see Eric's comments, to which Phillip agreed to,
> are all addressed in these patches.

Agreed. This version is looking good; I have no further comments.
Thanks for taking my comments into consideration.
