Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D9020323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbdCVWlY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:41:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33830 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbdCVWlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:41:23 -0400
Received: by mail-lf0-f68.google.com with SMTP id y193so15155338lfd.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGcNku/CWvyGQqURUp7IRnShocLwiZ2/h/7j5LHnEbs=;
        b=EEjLjr9Jr5bzNgcpR3oNmIlxzpElAjcXnEFKTfrFQEltvBE+cNlG8zhbyGvS48Ow5m
         jluWodr7A0A2/W8e4YbZpWE30kik4ukYcpOilZqMe5fk1tETLUzP/BMLWlVruQxhltAi
         iY41NqQv6JOFV25ULvHQyb6St3TIRtPv4noLvGg03QohtyvmwpEBuD4B4BKLUsfR3AU2
         eSqdt8qeoors+lpRVNbbgNT35f9tqYT+xTFyhAWpdscOJrY4gSC+2ca2A2lLW2pAtKSa
         Pl0A/OJeZsILgtDhHbWcQ95a+qV/7p5/BOJcWRXKuS90dS2GRmnEGFj357GYgPZDi9Pw
         tZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGcNku/CWvyGQqURUp7IRnShocLwiZ2/h/7j5LHnEbs=;
        b=qqCL3/2mIXiaZ5mZZzrxj3xVvacbDQjW3dmKUAaUiKomsnFCLV5RuLHurdUYVf6R1p
         iuwqwYXgyU6SD877/UDeRrP3rokP1kvYLn0kR4fliLm3z8WMdu+nbf7QVqVhiapx2CnG
         c1jpO5eh/fNmSYBBEESnexMi9iX2oo3ooHZc0SgzK1yCi1smbv/NX5aoveE1eilRyr68
         lkQRYfyz/uWnbKrzn06W40yRFQdrgG1lZBg7/A+s7e7SUOos+QQ21DK2gSlGv8j5DoQV
         GVGF4S42O2ssJhuY3lLW7ppEtL1dmkErF4wTui9aB4tFbq29HSH4ZLpesatEnM0HD2mz
         UTfg==
X-Gm-Message-State: AFeK/H0/zjNf53rheE9TtooTGHvno39BzdG8EApYcr/EmDPlF3n4BPPzJ1U4owE3Qhu3tw==
X-Received: by 10.25.38.83 with SMTP id m80mr12458957lfm.166.1490222479693;
        Wed, 22 Mar 2017 15:41:19 -0700 (PDT)
Received: from localhost (afed200.neoplus.adsl.tpnet.pl. [95.49.107.200])
        by smtp.gmail.com with ESMTPSA id g3sm735810lfe.34.2017.03.22.15.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:41:18 -0700 (PDT)
Date:   Wed, 22 Mar 2017 23:40:52 +0100
From:   Jan Palus <jan.palus@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] fix "here-doc" syntax errors
Message-ID: <20170322224052.y4d7olfbootoftyq@kalarepa>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322200805.23837-1-gitster@pobox.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.03.2017 13:08, Junio C Hamano wrote:
> Please respond to the list, saying it is OK to add your "sign-off"
> (see Documentation/SubmittingPatches) to these patches.

Please feel free to do so and thanks for handling the issue.


Regards
Jan
