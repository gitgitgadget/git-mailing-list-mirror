Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE862047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbdHGOtB (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:49:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34504 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdHGOtA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:49:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id y192so586565pgd.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=a2xK8T/4KuczIwkn6z2nvgXctocHQyWsw1ONiEGHeOQ=;
        b=Q09j1pC7I5L59rGHH8I6ex0M+HnG46JLQZr2mXIclzaM50Uf5vuWMQZmm63MSDC6ZR
         9JdDjV+YsN8kdgsewECjA+Sq1sgvWiNuYJsnFlisGcTKO6dVu9yy7jdHweXUiag57NQC
         LfIIBVgAEEBE23kZChkTPm3GSsGgM3JQFELsqD/+D6+V3FY0UwcDucQKZxQkcgllyzWS
         5LE0DeIDEUCG5uZQrx1cz9hm9Ah1gafTNLWq14PNwZy3p2Zj6xbPPafcfYDeK43BSxS3
         phuoB9SD7UcN3PgDeMXpNsnGNI5trSQic1vmygPityR26164zcCSAQEmLxKVpAY4v+N8
         +yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=a2xK8T/4KuczIwkn6z2nvgXctocHQyWsw1ONiEGHeOQ=;
        b=e7947N1XFy9IY8lv36nZWrxFpNVnZGImXY9DrLgnN7S/En4LdIY08p5PNolppQ41PI
         2STk2MQoW+oOJCAj/ZPbwIV+iuExpYs1UfcXhOoCvORBWSenDyscgBEyxIKaE0lXXbLb
         Hk4POqXZWzAUepyXLHjauimJBFTdDJyt5d8ZdpFeLD+I14EBV536ZUJ6q10pK4XiMo/+
         c9PBMPCEys07qy9VxnL/kA0spIvVZ4PuLBm739SJhIfuj/umnxiJWduFzl3x3FWUv32p
         Zl8p7U3X+S6WGpBGO3JM/g/Y8twOIEsQpp+ktbSF5gJMsU5KT+5uEBMd8eKZipRqsjoa
         07Jg==
X-Gm-Message-State: AHYfb5gix/jD39YCNxqVmcauBYsebtTDDrl9PAeNMFCP8TEEJFB/Ppsw
        5yYH/d3h20O/Mw==
X-Received: by 10.98.159.16 with SMTP id g16mr846890pfe.21.1502117339754;
        Mon, 07 Aug 2017 07:48:59 -0700 (PDT)
Received: from unique-pc ([117.249.143.188])
        by smtp.googlemail.com with ESMTPSA id j1sm13014217pgs.77.2017.08.07.07.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Aug 2017 07:48:59 -0700 (PDT)
Message-ID: <1502117376.5314.2.camel@gmail.com>
Subject: Re: Change in output as a result of patch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
References: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
         <1500923812.20078.8.camel@gmail.com>
         <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 07 Aug 2017 20:19:36 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-24 at 14:25 -0700, Junio C Hamano wrote:
> I suspect that with a moderately-sized refactoring around
> validate_new_branchname() function, this should be doable.  Instead
> of passing two "int" parameters force and attr_only, make them into
> a single "unsigned flag"
I guess it's not possible to merge the two parameters into one as the
following code path shouldn't be taken when 'attr_only' is set,

    if (!attr_only) {
    	    const char *head;
    	    struct object_id oid;

    	    head = resolve_ref_unsafe("HEAD", 0, oid.hash, NULL);
    	    if (!is_bare_repository() && head && !strcmp(head, ref->buf))
    	    	    die(_("Cannot force update the current branch."));
    }

and I guess this means the 'attr_only' can't merged with 'force'.

Further, I saw this in 'branch.h'

>  NEEDSWORK: This needs to be split into two separate functions in the
>  longer run for sanity.

Any ways in which I could help with this?

-- 
Kaartic
