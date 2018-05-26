Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B75E1F42D
	for <e@80x24.org>; Sat, 26 May 2018 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032023AbeEZQdD (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 12:33:03 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:40279 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZQdC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 12:33:02 -0400
Received: by mail-wr0-f173.google.com with SMTP id l41-v6so13940306wre.7
        for <git@vger.kernel.org>; Sat, 26 May 2018 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Col0co1EktpOg6bjsro1Ze+3/nlwWHo156ouWaUOU94=;
        b=OnndlW/xkugKWLZWIOXfvZT7+TyDLqLhrjB4Wz+E6XtRulbx4gBAKnIHRYChaGOYbR
         ogs02bubmeOEd5CnS8fM4M5QGuzAMe4meuXKXLmEMHAAUXRCmf4wE66lti3AyfnRrNnC
         neRXRzbCaLC+bdmXr/wnAa3XncOrf0NZn/ZeBdZPuRjAoTUXc8hdLOcCijCL+AKPBwMj
         hOYUykwQ2CW9wHR9ioL4hGeH4OvW+s8tMF7/2qmMS7+/07MdNes5gNKpX8hPu+TjUrJP
         527vTqPXsKwiUK+s9cmWWpWsfwIvOcTn+a0mHo8XyA2WvHIN2LncoYsfvvM1U1JuGvai
         aUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Col0co1EktpOg6bjsro1Ze+3/nlwWHo156ouWaUOU94=;
        b=BZRycezy35FveTEqI6DC06sM+10DAmi4xvE5T3C7U/1IbLN0rkArFFWrKIKloRkQEa
         tAHa0cJ7B7ZI1I+P04SU3fWFXx0DSLI1jYZiJ7/4ldcptMU2ItLKqAzBaNJMcNw7q8LB
         7fH9bINRa6d7z88yYs2PnsGQ7PJwF9wxy2DMw8W4iDHPu3dC11ufahZdZY0Md4WYYxB0
         RuwmBGML8WFbGGMwhpKL5ic7YI/qtfB6M7wFcOZFj6L1o7Q552n+tRttY5jXesZgO8LK
         AS5rIOYImkk/xaBiz2b7m9dG7F/LQpYKjDBQ6H2o0YA6kB10RgH77DdCeCA8bv0t+IAo
         nyFw==
X-Gm-Message-State: ALKqPwecqgJIMKuhuTx8F66voGK8Gy0lxHEEQ9AXTGKhBafTijVVZ9vK
        tmmbsRZZe4X84qiw0nRAUxM=
X-Google-Smtp-Source: AB8JxZoDhjM0/VZPkaUGA4iRNOrn2hdl6I7+rV1av4DKefbvTpg2rc3ayrI0+S+fVtgjzvuQhsn3CA==
X-Received: by 2002:adf:81c2:: with SMTP id 60-v6mr5534048wra.13.1527352380988;
        Sat, 26 May 2018 09:33:00 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.gmail.com with ESMTPSA id z2-v6sm9620620wmg.46.2018.05.26.09.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 09:32:59 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 4
Openpgp: preference=signencrypt
Message-ID: <48c8a5ba-3a04-00f8-94d7-5b32083a59ef@gmail.com>
Date:   Sat, 26 May 2018 18:32:53 +0200
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

I published my blog post about this week. You can read it here:

    https://blog.pa1ch.fr/posts/2018/05/26/en/gsoc2018-week-4.html

All comments are welcome!

Cheers,
Alban

