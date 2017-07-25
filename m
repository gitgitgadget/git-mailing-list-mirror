Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589DF1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbdGYSP5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:15:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38796 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdGYSPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:15:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id c23so13462456pfe.5
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=jAN3LAh2vDBI6iE3xpajLRLUyoIX89NA7EKHU2qyIUo=;
        b=H8iiEAQY5MIfc/Ttus0JWSVFjv0JKGfjT9Ru2DTyLXpQqRX6DUPV3AM2S/yJ1Je375
         QyX+MRXvJ1fs6XrDNZBvIn5tZuV6UY0IkHtqiGxubOZQ2q2naBQmOw4Va9qjyla37Mum
         l6BQRm5OV0MjHWmc148XHM/k9il7HRAU97TIjIpF4OuX3b8Bf7P258KJoLEKuS8n1czu
         ABvXdc2k4nnzIsiHhf/YxcYoGRWIyM0R1Om8ksIhe361OPLxGBf269N9pWe304BazqNx
         95CyuMPbQoYX3ZjykiEM87KtOVvopC+x86La8TvmMWEapUj0ZS7hOnh3PCcJ3BsB+97J
         A9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=jAN3LAh2vDBI6iE3xpajLRLUyoIX89NA7EKHU2qyIUo=;
        b=ISUABGzaVLh6NHJGc9bE3sbO6zMGdOjECr4nH9OujEo8mIPai2USp6Wsa6em5HN5Xs
         yFnNjyFwZ4MwdmX6FwF+NR1MRzVEG2gD1G18UB4PTMgOOaE63rldnM1G35BLLMTJ4h4b
         4mFHYB0mldh9fkHNUEq8tn5XxLArID89yejKePEzKB1fgTtbQcBWmm4tQ442xBPsBZUJ
         RV8zjRqfw7fqTjlTiV2pLFgzYQpRvHZXC2N+8btLnlzNjNZFc74VNdZ3p1YdsDP3yeE5
         Kql/Chpa9PCGz0kHpWL/uGBxxY0RQad+xJlk7nGnstSEOsKdOEh7lQOGdYh2nv3aGFpd
         HeSQ==
X-Gm-Message-State: AIVw112xgl3/Po8fqRd3MFNhtaesplU/YdIc7+uwWKU0Fnp3nPveRpGG
        WOXk7X9E0B75o78PG1A=
X-Received: by 10.98.166.153 with SMTP id r25mr17238070pfl.155.1501006555112;
        Tue, 25 Jul 2017 11:15:55 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id v134sm31698711pgb.58.2017.07.25.11.15.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:15:54 -0700 (PDT)
Message-ID: <1501006581.11979.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 25 Jul 2017 23:46:21 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've added RFC to this patch's subject as I'm not sure if the new
message is suitable. Suggestions for messages that are more suitable
are welcome.

It seems that the function "verify_filename" is invoked by plumbing
commands like 'rev-parse', let me know if I've missed something about
them.

I further noted that it's used by 'reset' but I wasn't able to 
make 'reset' to invoke "verify_filename". In what case does 'reset'
invoke the concerned function ?

-- 
Kaartic
