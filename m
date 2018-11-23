Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F431F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 14:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbeKXBPn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 20:15:43 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:50589 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391009AbeKXBPl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 20:15:41 -0500
Received: by mail-it1-f182.google.com with SMTP id z7so1084131iti.0
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q+I/4RmHtQpo+0F4B0FS0fQSBTB7KZInkgieHNK942Y=;
        b=fCTBsT8CASEXl/wRBxr1PSRMfreVmMlAQedS1SFHWVAHm93GW6fNwCo3YFN8mS9vhj
         Z8CPiPBQm3xMGVxDbSaFRFunMtr/Sh8u4mvusW1Xv35u2nWo/RA5pSAzoqd5iSyEkTsH
         F3TgzHQtPRCX2wu5HJPvep50d1pI0TXLBuxpdfvSYgx84qoONht9MgqjKXQGrRLrEJ24
         2k9+dUzocjdOxRE3fVVLRX93kPyAPtCEboDScq7BAKW8NZ25HSwnyj/6XgtJK/mapoY9
         JukaKDTkYVUqaM3x5jFtvCCkFc1VczyogtWfIdQWKq+YwEYSY0L5tFF1/aT+7wSRA8yb
         0Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q+I/4RmHtQpo+0F4B0FS0fQSBTB7KZInkgieHNK942Y=;
        b=AnDe6M77a7qVU4iEU6xVZmF9ynuwjP29pYlWNQnAuX73DFlmCHuc+LlaZ78ogKelp+
         uzbtULDUCuKh+OkykwtLSjgRIlGVKHZleJhJmH1Zjfagzc1qC+tr2urXGojjp714lMkY
         kYSI8zhkD4YlpSFEHwjGiMDLEbP3xoxHchaSqvMNuAPWBHoBDFFR2sUkX6e7sqo4d+ba
         M4S2EmeUy0x36bQ58y69HLXDd9zhsM/Y2f2RjUrXPxG8TtxM2ajmWVGINSMojiMOpMiR
         8K6n6LlI02KMcdCLumJDJdbzASTYcKUszX0lkF3d1yZ9EtCN+O4uUvLnCvoc79FadSqf
         BRLA==
X-Gm-Message-State: AA+aEWbU/T/B8yh9iLb6xh+mRPqcan/QGY3MaRKbM537sCiU2cUpFdMy
        TFg8bBOfzYq6JDFXFUbCI9FxSVT3e5HwbpbLqiQ=
X-Google-Smtp-Source: AFSGD/Vu0ZjviDf+tgv/3mPpcLPwNzxV8AcxL6uIhxShZPKo5/iNIcAonEN3jSUAGx54fel+Zdjorocmndk20l0klbk=
X-Received: by 2002:a24:19d5:: with SMTP id b204mr11787338itb.6.1542983476415;
 Fri, 23 Nov 2018 06:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20181119213924.GA2318@sigill.intra.peff.net> <20181122233821.17871-1-max@max630.net>
In-Reply-To: <20181122233821.17871-1-max@max630.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 23 Nov 2018 06:31:05 -0800
Message-ID: <CAPUEspgnTMQbWvfOaJV4bhnQX7g=cs5pnKwegZFAtdV0=zLpgw@mail.gmail.com>
Subject: Re: [PATCH] t5562: fix perl path
To:     max@max630.net
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tested-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

IMHO leaving the shebang might be better if only for consistency but
could go eitherway

Carlo
