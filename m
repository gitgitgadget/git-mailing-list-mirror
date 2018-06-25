Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8674C1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965011AbeFYTDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:03:46 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40634 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964980AbeFYTDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:03:44 -0400
Received: by mail-wr0-f181.google.com with SMTP id g18-v6so14733209wro.7
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rqWYRvDeRcz5v9WtiGmGyNbJ6sPKeMmsi/Ep8a7rdao=;
        b=fU+ByqBPTkMzHV9EWON5LYUeOgSzlPkBCQk2h8uci13w9kUp5Lm4BfTbhcmlW3Hb+F
         k/SP26F8gUAj2jd4uM4aA+B7db1TD8wLH5GvaNwmwyLeUD8ywNeDXtt3mjEvldtv0L+T
         Jvys+gyi5UJGOwH2+/43+OHpKc3t0P5K6A+iJNLoQYn3FnXFnDP79NIogEW6sOor83Nj
         UNgpBpmyazuqmyeKE3eabow3mRKcuFDgOdjz428FksHgv/OS4cIaVV3+ExvwLU6KcrYB
         +lOBxTQjFjNSoFuK8KMMRWyYJc+0Cm8dYG5eI+S6oOLM2/nK6hbNwIQKhkM1usG3rrjL
         jveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=rqWYRvDeRcz5v9WtiGmGyNbJ6sPKeMmsi/Ep8a7rdao=;
        b=EoKk6+tEyMEpAUaMaGstXYQ/K5ne5YERr1eXSgKQtASwY3aGqEX/T/CWxhJFU9aMrv
         v5p2TVZk7O24CBmeNXviJWFQC0yAJjbxBMbirDys3UwfyNZeXJ0iU6dEv83scRAL/2Lr
         tjKy7uUUw19U+QRaitHgVEaaBOmFVSYkHsyBCuQsUTKobVv5uysLkvk6W2EngyjTlRGV
         5VND4g+rAmFxrM409PnR7lOWLmWo483Qft6ZOpcf16kxr34UzMstUZA+2b2Q+0MYarq0
         hT/nEznOijpKMPaWk0vE6/VeuLhotJuRn4geHr+fxmlq9C4smbeB7mBHL0DuhZREVco2
         w+ug==
X-Gm-Message-State: APt69E2P7JxAwFh9N3vuQtvxNIfI9owb0j/VHjCDh3Z3BY4ldbWnbEb5
        iekbmaoTiW4H3XpwPHJ9ap/ehjMb
X-Google-Smtp-Source: AAOMgpexeW2Ez71tPXWr0Qq7YQTusjdeoHFblnXg0sQyWRTQfbIbYAPQaUCpCGsHwlchEvM0eKWWEA==
X-Received: by 2002:adf:824e:: with SMTP id 72-v6mr11354507wrb.127.1529953423689;
        Mon, 25 Jun 2018 12:03:43 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.gmail.com with ESMTPSA id y18-v6sm17965193wrn.68.2018.06.25.12.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:03:42 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 8
Openpgp: preference=signencrypt
Message-ID: <7804e3eb-b1f9-f78a-a49c-492460496b32@gmail.com>
Date:   Mon, 25 Jun 2018 21:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I published my blog post about last week:

  https://blog.pa1ch.fr/posts/2018/06/25/en/gsoc2018-week-8.html

Cheers,
Alban

