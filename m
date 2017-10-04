Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7D120365
	for <e@80x24.org>; Wed,  4 Oct 2017 14:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdJDOSu (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 10:18:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35989 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdJDOSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 10:18:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id i195so4987580pgd.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=VIl6k55APe7juxATOY43HGZnOVLDXpcQcjMvR3t1Nlk=;
        b=eH/Ra7iZg1Mw4aXGF30uHRgwaiQnUJOd2vzRskuy/AwceaYfpcWe6d4qwi4eB3IrwZ
         tgjqEkRV2HgkvII+yvWjfZe0aCBroD/HN/sa3cgihU4K7E/+Kpaaw5i4iEUiGeSi77DN
         1J090enxswBSBL2ln+DNc7lIdy9uSvEBBMBVy6K0fvRLMiobh846L9JUErCvZdmS0LNe
         xvD+5No/TU/pRR5aqiO0pJwuCsKvlV+koQ5cDCPXoNfeBe9VSSMwRF78RjBUYm9z5xRF
         dhmTxldhtY3lm4eet+Q98Tclql2deEQomWQs7QPw5A5PqrmM3JGR327MTnOgJJ5OzZF9
         te4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=VIl6k55APe7juxATOY43HGZnOVLDXpcQcjMvR3t1Nlk=;
        b=mbalzzsy2+l9+8NfzUqf1lF0CbzGzkeTZo5/L8yVxqiiczHV+0g0bGrcNPYoZMKCMS
         cOEBtNx5CIKcwrM8VRDt5mxpYBzQFYmHQQ7xo6zyTMrymaQSI83Pslwihjlb8wxdA/Zs
         9wP53rGUIWQdnqE5xKnWOkQd0bbgYbi7u8f3c5U0PiSafF6HVhPLmr/9ycbgOsV85u8n
         PXaRrxxxV/qpBNzgRtoNb4WGkanF8LvBE9xguEX6P1VKvC5RDqDTbn7S0anS6sPDcjzc
         NcvigRgq2RW8dEM0BGg1AvKOQkGsspVG+PTsp/8+Ygx5EcEgyAJcn0wicNJXv+1Iv/YV
         HrZg==
X-Gm-Message-State: AMCzsaXmTgVnGXVYNYjTdY0dqqiYsluSxncX9x8Xm02wLkSP6HDVm+o/
        wd1W0w9Fj6NDIX4poxJw6DA=
X-Google-Smtp-Source: AOwi7QA4IyYQXC9kSxUdjYW3roJHMPOWZMVgjDmoPDJpwZ62XOiwa8S1ydzxwbrich8oaBnLc8hfHg==
X-Received: by 10.99.127.26 with SMTP id a26mr12480998pgd.385.1507126727723;
        Wed, 04 Oct 2017 07:18:47 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id u12sm27402281pfa.153.2017.10.04.07.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 07:18:46 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam@gmail.com>
Message-ID: <1507126687.4204.6.camel@gmail.com>
Subject: Re: [PATCH v2] setup: update error message to be more meaningful
To:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
In-Reply-To: <xmqq7ewdm5pm.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
         <20171002173002.4278-1-kaarticsivaraam@gmail.com>
         <xmqq7ewdm5pm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 04 Oct 2017 19:48:07 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-10-03 at 09:32 +0900, Junio C Hamano wrote:
> 
> As an aside, I wonder if we want to _() the message.  It's outside
> the scope of this fix, obviously.
> 

I'm surprised it isn't already! I think it should.


As an aside, I wanted to know whether we should add
'test_expect_failure's for commands of the following sort,

    git log -p --full-diff master --stat
     
    git commit -v Makefile --amend

just to keep us reminded that these are accepted not by design but by
accident ?

---
Kaartic
