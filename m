Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29261F403
	for <e@80x24.org>; Sun,  3 Jun 2018 00:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeFCA6m (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 20:58:42 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35528 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeFCA6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 20:58:42 -0400
Received: by mail-pg0-f54.google.com with SMTP id 15-v6so12537180pge.2
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sqhx/Rv0TMnhCiAeXiODMm21w0mbPkPh0L54gcTeMN8=;
        b=iEYqWF+oEoZwWVIxuEwlsM+b2w4QNBInz58qer5lvGXxOrS1R1imCFCAIFEaed7tlo
         MMQTxXX3dBZmiPIRRZaGo80GqxBHaa4cZj7CVWX0lHW8eijUA0n53cnkJstsfkzDsaER
         65MEvUKEnsY1+Yvw3fxo3nREzO8Yj0w4MzjSFMDZFgx1LoXcxDvTpBjSyDNV2qbIRdq7
         vu6QbkmYCF+H7CIgrqdpofHVw805/4YAV2eoux1CQri+7DE/79tDpY9/cU8Q4har3HSq
         +/y9SmGvap4lgP9HAbujV7lUnEwdinE2mxhU0meKqwKkmicbXvkaHpnsxucbo9X+QcYX
         tjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sqhx/Rv0TMnhCiAeXiODMm21w0mbPkPh0L54gcTeMN8=;
        b=C8Z2cYUKg3ZAzzzWa0qWpDQzZzt+dKQTAZxYYlj7lcEe9mk1/L/rGdmROCG8XM9+Wt
         mZm5TF2jpyTnPBX/VzTA/EdUX5syiMlXbQPRzNmw0mZujBHGNyVpAkqL752iimiHwF/j
         HVmfc351aoagqkw9ju2D8o9OVZbMwh9r72xs8SCC/OfVyzcKu7C33soZTUHnXqUH62kC
         E9TRKi0tQkMrrnCb145mhomBKpT65DK0a/OfTsxbhmX3CuDUzVESbH2uMNfTLzETe24c
         HmJ3Ec3ZYfw4h1+VeMaR0ZHvyq52/bDZHPOMTIFIifUmmBMW8e5gJx2wVu8OhVuYKvX3
         zNwg==
X-Gm-Message-State: ALKqPwfzZf4hmX4NCuoeJiQvKUuON2q0yNRqJrRKe9QWnqAIj93+2oZ6
        jrE5OXGI0keaMB54BofITMF+
X-Google-Smtp-Source: ADUXVKKKurpWmPxi8GbM+I+Iu2CIkhuAdgqeMYO63TOwsK8p6eLj9YtB4L1DpXFpPGsi1ONQuBEDLA==
X-Received: by 2002:a62:968f:: with SMTP id s15-v6mr8075325pfk.191.1527987521352;
        Sat, 02 Jun 2018 17:58:41 -0700 (PDT)
Received: from HP ([144.48.7.118])
        by smtp.gmail.com with ESMTPSA id 68-v6sm74969376pfk.46.2018.06.02.17.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 17:58:40 -0700 (PDT)
Date:   Sun, 3 Jun 2018 08:58:34 +0800
From:   Yubin Ruan <ablacktshirt@gmail.com>
To:     git@vger.kernel.org
Cc:     Geekaholic <geekaholiclin@gmail.com>
Subject: git glob pattern in .gitignore and git command
Message-ID: <20180603005834.rwl5mx7llrv767xn@HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: OOOOPQ
X-Organization: http://fastdrivers.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To ignore all .js file under a directory `lib', I can use "lib/**/js" to match
them. But when using git command such as "git add", using "git add lib/\*.js"
is sufficient. Why is this difference in glob mode?

I have heard that there are many different glob mode out there (e.g., bash has
many different glob mode). So, which classes of glob mode does these two
belong to? Do they have a name?

Yubin
