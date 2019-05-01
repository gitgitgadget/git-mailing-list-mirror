Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814171F453
	for <e@80x24.org>; Wed,  1 May 2019 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEASMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:12:14 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33280 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEASMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:12:14 -0400
Received: by mail-wr1-f45.google.com with SMTP id e28so2413112wra.0
        for <git@vger.kernel.org>; Wed, 01 May 2019 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8+rnn26xpw0FDwYBUVwSGzKxG7R02iMJpC4spoGUItw=;
        b=NTA0hx5NdqySb8UYzxQfVybmjqw4TQH5nG246I2cYcN1YWHAq3AJroBziNvMLONW5l
         5Qr0eGl0QfJxFyQ+3dAgOUX3yDzkKAF547yjXJEpVCMIgXfwl82ic4rtBObGumNBkxp7
         KgK7gLEEXltQQIpil2XgDWJ3A+ofCZGVTI1Sf7MDsG+EJnBtbOX0ciV02tKM7+QLEDlz
         nJlGh/FLvcOFd3rPCEYDBp0NQ8a9GS3FXhn+USdnRv0Y1ziGpZ4FQ0nyN7M8TiPCERSQ
         U7/GSY+5r2tyheD4xkbIgtl32hu0YNzf3foKwNV9tw3QRlx9c9C1IuZtztSlyEDzlXhq
         b2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8+rnn26xpw0FDwYBUVwSGzKxG7R02iMJpC4spoGUItw=;
        b=ol3/BHoroeMg9cQXzlmctS92S4TN8kjOSd9uVGw6p4D/CFxZ1LrAp9BmQ+YCdm13W1
         tC0sBZ9OTjo0ETnaN3qxxTkMtFs6YRt/jKO4wUB3kB2Qrh2zWRLgsMITwBIq0PSeOPXs
         qYDM5Y9PxqOwoqrr42HyxPhbpISyA518a5AiNvXN1X+fTLS7RkBuTSSDrzr9Rml1O6gY
         YmACudnKbfNhsYbC38lsLsLwggMkwhOiRNfv9Xs5H/5ZEMUvmV4vNBa0IZRebHy5MnbK
         h8xHpWSKRrdiHCYXTC7mlxombJe9ziYFOOtRRz/TD6Fs1/dJ6dBSMqrhpJrgMVvokC9Y
         apWA==
X-Gm-Message-State: APjAAAXNdBOULlqdrh4Vx6k+MJz2Jc8GgaM5L6xj8WENVNEt0e17KcXs
        SZnidGesEEzi/DMrOyssb92QkcxTN1Q=
X-Google-Smtp-Source: APXvYqxcC74IsoC5iZsddhUQDKyr9SNj+avQYZlv0WSTwL5mDTm3cfCSJeuPEg+IJ/nHvXXVA2O0kg==
X-Received: by 2002:a5d:4b92:: with SMTP id b18mr25962739wrt.11.1556734332084;
        Wed, 01 May 2019 11:12:12 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ejy63.neoplus.adsl.tpnet.pl. [83.21.166.63])
        by smtp.gmail.com with ESMTPSA id j13sm41419745wrd.88.2019.05.01.11.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 11:12:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "_g e r r y _ _l o w r y _" 
        <gerry.lowry@abilitybusinesscomputerservices.com>
Cc:     <git@vger.kernel.org>
Subject: Re: if YOU use a Windows GUI for Git, i would appreciate knowing which one and why
References: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
Date:   Wed, 01 May 2019 20:12:10 +0200
In-Reply-To: <1b8a01d47466$9775c130$c6614390$@abilitybusinesscomputerservices.com>
        (g. e. r. r. y. l. o. w. r. y.'s message of "Sun, 4 Nov 2018 12:48:25
        -0500")
Message-ID: <8636lym4cl.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"_g e r r y _ _l o w r y _"
<gerry.lowry@abilitybusinesscomputerservices.com> writes:

> ----------------------------------------
>
> QUESTION:  if YOU use a Windows GUI for Git, i would appreciate knowing w=
hich one and why
>
> i have been asked to look at GUI versions of Git for Windows.
>
> https://git-scm.com/download/gui/windows currently lists 22 options.
>
> if i had more time left in my life and the option, because of my own
> nature, i'd likely download and evaluate all 22 - Mr.T would
> pity the fool that i often can be.
>
> CAUTION:  i am not looking for anyone to disparage other Git Windows GUIs.
>
> Let me break down the question into 4 parts:
>
> [1a] Which do you prefer:  Git GUI, Git command line?
> [1b] What is your reason for your [1a] preference?
>
> [2a] if applicable, which Git GUI do you prefer?
> [2b] What is your reason for your [2a] preference?

I use both Git GUI and Git command line - but for different things.  I
use integration with editor / IDE (in my case GNU Emacs and Magit, plus
git-gutter+) to commit changes, amend commits, sometimes for push and
pull; and for having constant reminder which files changed and/or which
lines changed.

I use Git command line for more advanced stuff, mostly because I am used
to it.  Things like interactive rebase, fetch, pull, push, stash and
unstash, undoing changes via reflog, submodules stuff, etc.

I found that with Git GUI (to be more exact git-gui from Git) it is
easier to do incremental add / incremental commit from GUI.  If you use
`git blame`, I highly recommend `git gui blame`.

Hope that helps,
--
Jakub Nar=C4=99bski
