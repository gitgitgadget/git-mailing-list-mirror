Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEB320401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFUSnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:43:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35696 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUSnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:43:50 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so29503179pgc.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=1ARlVF+ViovVIgrPq4VBpTc7FShDa39J7syM88nzrew=;
        b=CXwzG/1RS80kiLJfETcErxWLnhpUSbEKHxRn/fV2F5FnLbeCqJmXkz6Y1SE54zkbzk
         HicBkq3th6uEJHkelJcKm+UiVVR7tk4DuUF7mScRMzRp60KEKu7Axj0JNN5nM4n4Sohe
         SiBUZU41u2k2uFSAua7xk60lNqxHH/E7bijaM/7MPVpW/SFhXG4eWl5+ag1667GAQlJp
         zWtWzTWWh/WywmZWP6wFKhpthdo3Uz5P9Cx2z1jQYkewlhRR13JIS2dscvditVVbE+eZ
         jYs99ONYoOpP3I8IgsUJc2OyE7XFkSH4Gt2hj30lzGO/tYUBmjF763E8i3dW+BEzQdR1
         8B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=1ARlVF+ViovVIgrPq4VBpTc7FShDa39J7syM88nzrew=;
        b=HOmLWIiwhcyCFQPYCs+SfHHU9QEf7Tz5To3VPFKAZW9+KUadoMHbuSs99R8MZENxzL
         XhVnzfTVR5GgjZgoSzmoS5NWeC0IV8vC4Qm4gzfcmaYCf/NNkj9d8leIRLTln7L8X93n
         3NRbR0M0jQQ0d9DIlySS3TPjqGvY49dy7uD6FOZldVxBh0vIkiA5qTAqdVWGaRa2Wsqn
         PmDRE685+oqJNoQlaaoqtQsblkUFYeJkHuGqQcjmye19ApBFwTOMqZUQoT7wDbCkfpJl
         XL7nKLYsY726//aJpQjhX1b0gH73DS8XV68/O8P0YrUSqXsD9ikkypwr7MZr2HUSYYvc
         FSOw==
X-Gm-Message-State: AKS2vOwxRf34MECHBlVoVf0QPNhZtmfpfeanIoqrFkGOrK44u5Pq/yBX
        jWbsU3hMnmoYFdaygIiSzg==
X-Received: by 10.99.134.199 with SMTP id x190mr38648858pgd.127.1498070630058;
        Wed, 21 Jun 2017 11:43:50 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id s88sm35940615pfk.16.2017.06.21.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:43:49 -0700 (PDT)
Message-ID: <1498070618.32360.15.camel@gmail.com>
Subject: Re: Does 'git config' accept the '--remove' option?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 22 Jun 2017 00:13:38 +0530
In-Reply-To: <xmqqzid1p4tw.fsf@gitster.mtv.corp.google.com>
References: <1498068738.32360.7.camel@gmail.com>
         <xmqqzid1p4tw.fsf@gitster.mtv.corp.google.com>
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


On Wed, 2017-06-21 at 11:34 -0700, Junio C Hamano wrote:
> Neither, I would say.  I think that you would get exactly the same
> behaviour from 
> 
>     $ git config --remo test
>     $ git config --remove-sec test
> 
> These are merely "unique prefix can be abbreviated in option names"
> kicking in, I think.
> 
Interesting. This is the first time I'm hearing this.

