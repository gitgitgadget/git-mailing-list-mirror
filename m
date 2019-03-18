Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58655202BB
	for <e@80x24.org>; Mon, 18 Mar 2019 07:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCRHJB (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 03:09:01 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45699 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfCRHJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 03:09:00 -0400
Received: by mail-wr1-f46.google.com with SMTP id s15so341951wra.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Uzz6G24Xf4XjaD99dmtNDlpEJwx5xVk29b8TSDc0Owk=;
        b=qvsiDPyagCIsm2PZaMhwUXtznkhoIIj7AINXQQMWdb0Zn7Q2RHsdq/Pz21tkdD4DL6
         ObRdFS8tqzx+F5rTCTmRCUqXryyYFaSFY/U0EdRjvT15qVKQbJGs35xr6wV0yw0uTLku
         Cj7iIIzd7WtarbJZKEVXTieBDDZzYgRFr670ZGLQ+OBQHHYwVD2D3hihKcWg8lcX6CWo
         Tmr/3ZUHSPCT0j08uGpYyqWoaFozLQaUh/bdHoRxOqknAAtBfJw65E+Bgf3z8Jf7EIMH
         GLWmHzQUgUwPi3kfl88SjigjnF+LknHtqsqTjtZb4/+VBpB+kGX22bRK5sB+A1mO+O38
         JV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Uzz6G24Xf4XjaD99dmtNDlpEJwx5xVk29b8TSDc0Owk=;
        b=C/F3gN60H4SU/Z7xOUHU0e9zPAJj+Shit4GPXUyCrJpg4RPcNe3sFFOqg5DCXyq75D
         G3RKdYXBjudupol4wTa25EeO9pqdmJzgZ8IPYAhd6ULMXrsV5IssRNAirY3qfzQFmH+T
         qKK4uamD4CUNMuk4PNFn2+AZile3dgxHCd7e5DiBg6z5mkqHDmQ4E3BUzTQcLucRNHQU
         2R4BmSUydf28uN2flddq2KGRBj6jgwALxMItj6V9+h6yTdxVJ6Pah+sT5+a7nLhET+cC
         qDtxBO7L3ttaKCbBWDHowQXc2FIXtc1Sdx3g5Yzm224Mah+tby+BI2ANEfDovYvtPmKP
         1jgA==
X-Gm-Message-State: APjAAAVUTcf9lfmD3hywHBjbgaxKK6+FpAH8XiH3/RnoCgWdottF9DMG
        RpYJlg6qyf+Jw+thFZzNtlI=
X-Google-Smtp-Source: APXvYqxgRqDTDekVO+47TOUPgoPzZXAgHRi6hPBr1fZyuwOVRSGkxb8YVTTT52WRtJ67hyAUKKDdSA==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr11488083wro.24.1552892938923;
        Mon, 18 Mar 2019 00:08:58 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c10sm7992271wrr.1.2019.03.18.00.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 00:08:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903061114370.41@tvgsbejvaqbjf.bet>
Date:   Mon, 18 Mar 2019 16:08:57 +0900
Message-ID: <xmqqef741wxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  "gir rebase" that was reimplemented in C did not set ORIG_HEAD
>
> s/gir/git/ (assuming that you use these descriptions to generate the
> announcement mails?)

Thanks.
