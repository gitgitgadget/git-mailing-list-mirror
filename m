Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB761F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932266AbeCIRT3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:19:29 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:37356 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeCIRT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:19:26 -0500
Received: by mail-wr0-f181.google.com with SMTP id z12so9712798wrg.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7RZrksYgMHe0ZECfyynLGEaWiCb1OqQhXx7RvOkAXjI=;
        b=oEtRKKouTrjeM7I0vX/PmbrRq5gt4g7Zcpk8oAT14UFWG4hVQTJfPo9CchLIO/4Kuq
         kIs77lp82DtGUEY52JLvZZhokRAxhs0WGrr4WzODlH3Scv5lE1deaOojAArTEvcik97O
         ltN+976ONwe8SzSRgqQ/Za/ED6G3TNFCl01gdvlNiXXUMJH2qzsiVMTsfg3/Ah7RuPln
         kGYqVECN5w0tf3pCZm7hJVI98PJEm98c34xJpL0FEp8NE9cZs6Q1BEDpD7hUB+JPYe4e
         WROLFEbGmdiqFKVWPrvjaW3vsBt+zscs9OUoCzwGyH+HddQrhdMSd4eqLAOe//oB8jci
         vK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7RZrksYgMHe0ZECfyynLGEaWiCb1OqQhXx7RvOkAXjI=;
        b=BQ6oGp7sCR9xcQ7fhXAw9QUqP5UXdyLVE56dyG4IabGVwd0pNMPZcnlEC5hiE9JlaV
         MvRv0Wl+o0STuf9j+mwFUiyMWpGwEcHUZswls8Zv+hcwP1fUcTASDNpmlVK4uMqHVvYp
         CmmGeRzVfUKDOEYitygXuuQBMwYAAypNDWTOFESTT6oDJ4fJuYerd5seYfflEPdnmb7E
         Xy2GI8ezIwECDtdPxOUJomlmEuIE828DGuPvwkIXErI2lruqV1+GNFobyjBpvW/S/GaP
         1bzQxZux8sN4gmI4XgzvraAT6RgvtiSaSN+vnpjU+lWmSiFtZ+dMJDz2pkFoE228RVUB
         k2xQ==
X-Gm-Message-State: APf1xPAfybjW9Oi6lv+/Jd0AY6EXrWdCG0zEcdOnIRt8CHnFGebGEiJ6
        HeEpM9vRlzvshwrA2GP8Vcg=
X-Google-Smtp-Source: AG47ELsVPnqQvmXIRn0w8iJTtuUwk7IrH5y6Z18WQNLktyCNcLpTqWVp+VmJ00OxBoMe/qB7Sd1xdQ==
X-Received: by 10.223.187.19 with SMTP id r19mr25505779wrg.110.1520615963967;
        Fri, 09 Mar 2018 09:19:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o24sm1643826wmi.29.2018.03.09.09.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 09:19:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2018, #02; Tue, 6)
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>
        <CAN0heSoKOoEikn8z799Xptje2Q2SE4BeAcvvXecPMNDCjBJ0+Q@mail.gmail.com>
Date:   Fri, 09 Mar 2018 09:19:22 -0800
In-Reply-To: <CAN0heSoKOoEikn8z799Xptje2Q2SE4BeAcvvXecPMNDCjBJ0+Q@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 9 Mar 2018 07:15:52
 +0100")
Message-ID: <xmqqr2ot6uat.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>>  Is this ready for 'next'?
>
> I am not aware of any open questions or issues. You thought out loud
> about how the series was structured, in particular about introducing a
> successful test, then redefining it, as opposed to introducing it as a
> failing test, then making it succeed. I hope I managed to motivate my
> choice better in v2 (which is what you have picked up).
>
> Duy wondered if it was sane to use a pager when we know that we are
> "--get"-ing at most one config item. In v2, I addressed this by turning
> on paging for a more careful selection of "--get"-ters.

Yeah, I am aware of these exchanges, and they are resolved nicely, I
think.  I was mostly asking if other people have concerns we haven't
thought of yet.

Let's merge this to 'next', then.

Thanks.
