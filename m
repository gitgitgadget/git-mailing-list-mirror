Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122F420248
	for <e@80x24.org>; Thu,  7 Mar 2019 08:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCGIMP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:12:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33765 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGIMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:12:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so16272404wrw.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ORc+f5pCG05706iR7gU9Q0zCjVRC99kuREn923cGgjI=;
        b=iXLYHLlI/y6OV6diPm/L3DJ5m81fsTqKR4fVJbX93dY++jOwNwDcdJ+mnhcVkJbZGI
         AKc12xgje1j1egccceaEB+ebWMKuAM7KHSYNG9zzYmOH0tAY6W7xYV4q//18xSoV+Y19
         VSpZWopTb83D2STLSaRauAFz0sx4lXv7v7gT/PjzqauuZz0WUyJnqajp9rEcAVnkky8+
         sO0yG+mm30NyF8g+yhX6tIrEorXZ0sPfhq8MUlOmQJJRS4bUeEkH+HBR2zGkiXg8hW1B
         vXT2EKxgrD2dWIit0akWPd8TR7ABN+P6QJMb8/Ol8OVGiWFhxX55szkGlU3a1PP8Lq1p
         z3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ORc+f5pCG05706iR7gU9Q0zCjVRC99kuREn923cGgjI=;
        b=l3cZLfU1vICOBPzP+tWormB99XkoOm6X3R6HeKF3KjpVwi852zw3UMYi2UUS/oE/rn
         Y2qL/dYTQh2gHAXLEwwLb2m/iQCXysDpupsBG9vCAlZf9WqdiWZnOmOpgJDNAEybTRjH
         bIhLSTxXIfMdP9FwFCy6KwnTkjo9pxEyM+aouU55OfhtWzVBwxMM5/stYe6V6jgSSHoi
         5fnAGLFOf/2rQzGzp1LCa/7Xjn1/6QzytGXbL81GZa0adss0ecreDg1QLC4MiBdjSALO
         vFtjWjN6OpziDYxFf8zD7QIJuMVPGjcI38Vfs/aqgJxHNYI4wD79Q/dAL2/zUoCE/kPG
         CVYA==
X-Gm-Message-State: APjAAAUtZPNE1NquTbwzl3ej0rbkzO7LEfM7kBlWZFdgp+bb/Rq1ukfP
        L/XdbUSQXVG80wugwC/ww5xHBDRN2lA=
X-Google-Smtp-Source: APXvYqz+c2EnBOlxY6+6rfRSw3l1MYqtargFr/O/4XHKkTdqBARv90XPEeqFSl9oCp253Jr0jRKqMg==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr5737644wro.293.1551946333270;
        Thu, 07 Mar 2019 00:12:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h137sm8444410wmg.41.2019.03.07.00.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:12:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] git-clean.txt: clarify ignore pattern files
References: <cover.1551868745.git.liu.denton@gmail.com>
        <cover.1551938421.git.liu.denton@gmail.com>
        <2eda83517ebad39e14dca9d86b9dc2e0d32e37ef.1551938421.git.liu.denton@gmail.com>
        <xmqqlg1rmati.fsf@gitster-ct.c.googlers.com>
        <CAN0heSrGT1SBt=w8j8G0nnWXDOrn+VYFuk2iPWH9uk22fqzFKw@mail.gmail.com>
Date:   Thu, 07 Mar 2019 17:12:11 +0900
In-Reply-To: <CAN0heSrGT1SBt=w8j8G0nnWXDOrn+VYFuk2iPWH9uk22fqzFKw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 7 Mar 2019 08:37:44
 +0100")
Message-ID: <xmqq1s3jm7c4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> suggestion. Hmm, I now see you wrote "the standard ignore/D/ rules" -- I
> believe that's a typo.

Thanks for spotting.  Yup, that is a typo.
