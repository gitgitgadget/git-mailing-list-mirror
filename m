Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1891FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935869AbcHJSdr (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:33:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38495 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933622AbcHJSdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:33:45 -0400
Received: by mail-wm0-f44.google.com with SMTP id o80so122410369wme.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:33:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IvuHHWg4aS1WbP71bjQ+amIT1YA0Bfului4kRE10xMM=;
        b=F1sxVp9LJHwzzS99oDfkn252LPaVvbi6h3XyDsKKs8NztjeFsS51j8jDDtNgUQ9/1N
         MvvOvHvcsCLbWbd/DdSthdXEs7SQEEDHGXh1cLkMt7PB3rhpaNG2x8Hpexf1DKpGJql5
         3/wJzjq/77emCCiEGrSCyjC2XeRGLdlmov4/t8Ep62hYrvVl5CASXj+aosAyCJsoqvML
         DLN1HHrCQ2Q4VQtnKJowDKlOaYbsiGhePYO0qIl5DPfYjj0m5La/HqSrlho007KeBZ+7
         huBbjv3a9mZp6juiGWINf4n7NLwTWf/bCgUfMu24cUvYwEC71NM3KUci7RMVeuO+LB9G
         KTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IvuHHWg4aS1WbP71bjQ+amIT1YA0Bfului4kRE10xMM=;
        b=jUzk7LM50D0K14hfvkoWdTuLH3l49XiV4HX9sxZmZzgnb7NYkspZuCtkSgAH+WsNII
         iJWLPQflayrdKIxC4WvGvhctegws4cbeSZUdtDBx7LV57/KYKsrolqNvfle9DSNOqIDF
         pqqo3Tag5PopamxWxuc2/lC4QO0BW8SWVTjpvAPazMyE8zwjMCaS/nXwAtERDaQaPnE9
         axyNNtZ93Q9IpY4HDzmEL6fgy87MqZ8zniiKiITAvVi7wgM17ESlZv74pe5vFaHkScl8
         4uomx6Jb4nTuLTQk97MJeDCTjI6NRKYOhUZUqm1C6Zyz0Y7Zjrfe9lTGkSjmMrQ1RK3k
         iNQw==
X-Gm-Message-State: AEkoouvJmm4pYoffpeFTYxU97B9xnvhq2+9CFFb+N293ZngYZpbDD+OVAmsi4/z/sUuU2Q==
X-Received: by 10.28.39.134 with SMTP id n128mr4299238wmn.60.1470850235173;
        Wed, 10 Aug 2016 10:30:35 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p1sm44015663wjd.37.2016.08.10.10.30.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:30:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Aug 2016, #03; Mon, 8)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 10 Aug 2016 19:30:29 +0200
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A6131C47-3230-4EC4-B3F6-B2507C937A22@gmail.com>
References: <xmqqwpjqdh7w.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> 
> * sb/submodule-update-dot-branch (2016-08-03) 7 commits
>  (merged to 'next' on 2016-08-04 at 47bff41)
> + submodule update: allow '.' for branch value
> + submodule--helper: add remote-branch helper
> + submodule-config: keep configured branch around
> + submodule--helper: fix usage string for relative-path
> + submodule update: narrow scope of local variable
> + submodule update: respect depth in subsequent fetches
> + t7406: future proof tests with hard coded depth
> 
> A few updates to "git submodule update".
> 
> Will merge to 'master'.

I think "t7406: future proof tests with hard coded depth"
breaks the tests on OSX:

https://travis-ci.org/git/git/jobs/150779244

Cheers,
Lars

