Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF066202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbdGIRzd (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 13:55:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35300 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdGIRzb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 13:55:31 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so10082764pgc.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=CvbXDwVXKVUthoT5rjxCSMwZkcDOvY16SJ98jAKjsYs=;
        b=OMBRiZ/vElMw6gZ0TNKmucWb2K8T4pLLNfA3biiNbgKdLrvIqOxukZaZiwh3wr9mYs
         s7FYcutHF1zDw7d5yz8FYR58AUAbRJskut1r+RAnXi5fkxn6mqS4qJF+EgSQmr3+zaNs
         DBzXCq5Tygb/8SkY/mGhVuWbIGOYIR57mWmn69EKjrotu3KjfTJwY+Lla5xOqfB9vSuH
         YFoh1/VIyAUrHBhl+EyQdgKKn4PUYGmKBUoje3wHirSkQ1S9YpRys1RRLebsF7P4K3/O
         pgHeJfeLEiGTGPEWDbSat2joI+9Fc0T+OmsLHcCV32UsHra3g1M1q9RuD3ulakVSl9Fs
         +dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=CvbXDwVXKVUthoT5rjxCSMwZkcDOvY16SJ98jAKjsYs=;
        b=L7PsD17uN/b/2a6/mseVgT5tP97lRiQNfhU3nWUsru6MWOKWRtlkmCVqn1o+jmVuRM
         kG46RoMN4ZWt0tP2wPDCpkhm0/oKo1S1Oj0NTZkId2Ts+EX38oX2SSGJp1oehoVK6DnL
         Y4LsPBZbDLr2XAVkpxt7vCZC91oQUp/fp4cyP40BV00riBVvMTU9XZMHwIA1e0SwoXTs
         yaEwYahKfTyMTy5a7QMflCz5ea/bZokoVw15pZHwXO65/Bj9l6l7cDh0G15o7b7HiSwQ
         UZr7a6jw34cXatCGRaXN4RDpL/kmuUZmf4Opu+hEj4vi2/AkGcz+D7QghOHm+BhiC2d5
         g2Rw==
X-Gm-Message-State: AIVw111huOaixH01sS+JpqkMGvLGOoIBUhNK9sW5J0bZDcfkxA9TpDj8
        3freNvpnL2NrUA==
X-Received: by 10.98.86.193 with SMTP id h62mr40975688pfj.205.1499622931138;
        Sun, 09 Jul 2017 10:55:31 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id u62sm19580767pfa.18.2017.07.09.10.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 10:55:30 -0700 (PDT)
Message-ID: <1499622873.8552.2.camel@gmail.com>
Subject: Re: [PATCH 1/2] commit-template: remove outdated notice about
 explicit paths
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Sun, 09 Jul 2017 23:24:33 +0530
In-Reply-To: <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
References: <1498792731.2063.5.camel@gmail.com>
         <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-06-30 at 17:42 +0530, Kaartic Sivaraam wrote:
> The notice that "git commit <paths>" default to "git commit
> --only <paths>" was there since 756e3ee0 ("Merge branch
> 'jc/commit'", 2006-02-14).  Back then, existing users of Git
> expected the command doing "git commit --include <paths>", and
> after the behaviour of the command was changed to align with
> other people's "$scm commit <paths>", the text was added to help
> them transition their expectations.
> 
> Remove the message that now has outlived its usefulness.
> 
It just recently dawned on me that the message,

    Explicit paths specified without -i or -o; assuming --only paths..

is translated and "git grep" shows it's presence in the files present
in the 'po' directory. What should be done to them? Should the
translators be notified? 

BTW what does the word 'po' stand for in the first place? I digged a
bit but couldn't find much from the log.

-- 
Kaartic
