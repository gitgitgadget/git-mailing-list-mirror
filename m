Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806931F453
	for <e@80x24.org>; Thu, 27 Sep 2018 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeI1FsW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:48:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45660 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeI1FsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 01:48:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so2917162pfi.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZRP/jTeCu0Gts3DBAwvRsgt+Iwdtpb4EVO4CktNLKM=;
        b=lq2PaNnJFNaVfKJzLSexPm36Vf6C3VDGsk5mcmgW6lTRY1w4+IkJ6nqgGznCG6QkwK
         yJ7YFQGrgH9Kih58vj/tquxeI5vt4sZ9frw87FAqrLlDLsRvqQ7AyGtoN32q2xS/s0rq
         wcKsFeUjKiUWEdpgAlPcw+8AxWab3uYuG9kur3zaBvI7+8iGBlAUL/TfHpoz/FURFwl+
         IJXEDnnzlu3Ri3SOgkAxfpE4Esp7fIA8TUYixPHLCZIW4hz8Vc5aDWPXJ8WDG9ZiyqiF
         FuiHOWYfwyaAXKohJp0I20yA+g8wyAPXc8pbDfE5B5Adum5tzwt3o+xX1AD99hbmfgG7
         L3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZRP/jTeCu0Gts3DBAwvRsgt+Iwdtpb4EVO4CktNLKM=;
        b=VvcSCfX1C2rli4D98G76g5VHhhZlvFxHlb9qKbDH1DJ1x1BFNRsZNggFuM1CsKgVjI
         H9MUCB0YR4apMGm7eN999AkyKvSBCkXCFYompHPQl0CuazbNT3KpKQQP39iA/bEH8Sz+
         /b7Zpflfb++ZLszePdJTGLneX9iN6jOU4L7qZystvM83X2JYJWwKHPK7MW3J0AkpZGUf
         Kqgsb2AHOktgYf728lauNlyxD/SnVAuclqZxuMy+0sYPTUUY0gkVvc5GVVwdAAw6rjNF
         SuN7Shz7nx1Y3aBFi+63KDuSwRVpta3k0MWoN93kyzg1ujkTvS/pkLZ1tdx/0M8p7xbY
         NT0w==
X-Gm-Message-State: ABuFfojvFFjRCGGX2WDn8Tlt2rnK03F9kKZs+FWtyoTIAaxD8QmJNDLC
        6yS6EcJuUpKahT8reh3BzuM=
X-Google-Smtp-Source: ACcGV61uI3tMy5dFtGJ8hB/WZmUsPcqMWzFJyx41MEmsxVdJSeK18dRtodzQFVCKSCiQqgQqKqcnfg==
X-Received: by 2002:a63:595:: with SMTP id 143-v6mr12472405pgf.244.1538090856063;
        Thu, 27 Sep 2018 16:27:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z24-v6sm5609401pfg.183.2018.09.27.16.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:27:35 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:27:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, avarab@gmail.com, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
Message-ID: <20180927232732.GA216193@aiede.svl.corp.google.com>
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
 <20180927212727.128214-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927212727.128214-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> There are different opinions on how to document an API properly.
> Discussion turns out nobody disagrees with documenting new APIs on the
> function level in the header file and high level concepts in
> Documentation/technical, so let's state that in the guidelines.

I disagree with this.  I think we should put all the API docs in the
header file, like we're already doing in e.g. strbuf.h.

Do you have a link to where in the discussion this split-docs strategy
was decided?

Thanks,
Jonathan
