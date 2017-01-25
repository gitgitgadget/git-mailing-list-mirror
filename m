Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B451F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdAYWZC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:25:02 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36811 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdAYWZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:25:01 -0500
Received: by mail-lf0-f47.google.com with SMTP id z134so136632705lff.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gbs6DYASKhYElSukYDsDRTg07UjM8Xv3a+9URDQHkCE=;
        b=HClA2sqatTgM5stkcbUxPa2qqCjSFjRbzi1UFVMtJMooT2qmIX253KvGyuYj+mPiiB
         QRpncmmuDFMpb45lpbVt60PLs05C2gCedIvDiJA7OiuBM+X76GzOxQvqxp0VRrskdThP
         3TRPpaDnNZCgx16925YH8dipJ5hvx7Iemcuq5wN6IiavfcJVbR0++G3KvZ5ZE2IQSNXn
         UcjXr6Tq3w+efL2hqpyEV18rMJHfAQL/jFFVBgThlBA5Aueptau574NDRaVQ4d5tXc1o
         hClXJVd/kXxoMnDy4M+/rr6U9/TlipGPWgpEiO+SvlrMMokGINNMs91davCTLIBGYmk2
         p2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gbs6DYASKhYElSukYDsDRTg07UjM8Xv3a+9URDQHkCE=;
        b=gykDfvTdQ51Fq5RzBoPrPGfN4/Sq2N89zv0eI+S0lMGISbu4i7fTzw8+vM5CAd5wLY
         y4EYmjCr0IVWkC/AN7XodsR+/GzH3rND5ekiHi0d9pVJIZrfdNgy9hASOheFlu5D8O7k
         YYD2XIO5f8MkkyrsyCmHcAFwHPw41e9U0cd/lV3eFzTWqYmsPIhdvSzkpbA+vqDwHl7V
         ULAZCEUhlFTrKB95KkeX9luogmfCSfG2UgppiCbKqfAgqGLhXY/rtXuwJc+XQulosZph
         IgNV3a+QL4LfKoh6RIAiwAJWIuAso0V4Va0oczR4YwdqOQganNlp8d6bd5k4ku0zaxfY
         Zdyw==
X-Gm-Message-State: AIkVDXIbo2DrCru4zY+6fHWAmmkM+jhh3i2P0vFimfRkInfAHQALknyhDSo+VcMFhwKTtHCyTw+kMZYHhEuHSw==
X-Received: by 10.25.75.79 with SMTP id y76mr14435746lfa.143.1485383100087;
 Wed, 25 Jan 2017 14:25:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 14:24:39 -0800 (PST)
In-Reply-To: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 14:24:39 -0800
Message-ID: <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:16 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> How can I force Git to not assume my change to the first line is "redundant"?
>

My guess is that you probably want a custom merge driver for your file
types. That's where I would look initially.

Thanks,
Jake

> Cheers,
> Hilco
>
> [1] Note that this someone is (correctly) using the same, new version of 1.3.
> [2] If my example is actually incorrect, then please just pretend
> there are no conflicts.
