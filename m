Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6E91F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935148AbeB1VyQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:54:16 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:39388 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935108AbeB1VyP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:54:15 -0500
Received: by mail-wr0-f179.google.com with SMTP id w77so4006779wrc.6
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y+yFE3CxFHwXAJ/z33LZNwZCjxLIdPP8BgTS5VSHJMg=;
        b=Ec2gmdsjYIZx0NTV+ZTqt1YnOmJVIFJ5gfWumYle1aphl5vL1LWlR3qUL/+ufpRUiY
         N7w2eYBIIm06T0FgoCFxbYdHz2nk7u9vmRG5vwzRA3FE4PMm8oQOAODoNbPkxoY9/Ilh
         1CLtBalTfFPTT1KsloLs7mRNYvF/nhXj7c2XEdO0bBFbISt7TKLRjNqWgpBrpqnwPZef
         lAfakM3eAuX3YNI+3Io6PEbWE4/gdE96arOh6Bf4ufaC4CrWMUIfKn11Yxlmr1yluTQe
         8fYRQ2fL+hn3WgRbUTqjU4tTVdhCJVUTGACZ/zkFQew3OIuPIRutCMsq6CkgnxSMf2Jz
         OGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y+yFE3CxFHwXAJ/z33LZNwZCjxLIdPP8BgTS5VSHJMg=;
        b=KoaQzc/EfMDrdPOU3xNBAVX0Cpol98YokiLuAiF2qf/4EoxeDvGbkURZjzUuTr184E
         hpqheSMx6CAHGdaFcyzQHOXbTlkvyPzCHGVoFAvX3+8ks8vt2ELmfpmz1pjIBxj5dpqO
         GbDRty90JaDiXDBwgZamP3pHy6dcMe+cFlYyuscUVUHuZkMIPNEHX0zQNVdDLPHV2wnB
         5js1GjFL2/WqvetY2q2/cbTXX6rB4bVA4BGdHpZX+BAwHdwsOvZaPRTdFd9sg2ytQshf
         vNu4XI9C/as1zshRzXUm/FxIFLxLDc1VKP9s3qewdsZRpTBxf+VPBnlALz8EQiFL/jAY
         GHsw==
X-Gm-Message-State: APf1xPBg4JdFHASoUEbw3yjmglGOkXlh+73GorU+vy1+EuXZRoC2/yF0
        XxFqhEtQlcbOmeJ3Gc0w5dY=
X-Google-Smtp-Source: AH8x226LL//+/cupKR49c/kyz6ZjZVmajz+Lh8jYHmavPx//AWFnnE4xgvet5BRl9nCiSI6m2yg+IA==
X-Received: by 10.223.193.69 with SMTP id w5mr16057815wre.42.1519854854219;
        Wed, 28 Feb 2018 13:54:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm7744212wmf.7.2018.02.28.13.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 13:54:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Obsolete instruction in SubmittingPatches?
References: <48b5c506-6882-81e2-35f6-7d040bfc6017@gmail.com>
Date:   Wed, 28 Feb 2018 13:54:13 -0800
In-Reply-To: <48b5c506-6882-81e2-35f6-7d040bfc6017@gmail.com> (Andrei Rybak's
        message of "Thu, 1 Mar 2018 00:31:21 +0300")
Message-ID: <xmqqd10okcfu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Is this part of guidelines obsolete, or am I not understanding this
> correctly?

I am merely being nice (but only on "time-permitting" basis).
