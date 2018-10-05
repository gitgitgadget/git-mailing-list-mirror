Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BEA1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 18:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeJFBMo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 21:12:44 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34247 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJFBMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 21:12:43 -0400
Received: by mail-oi1-f181.google.com with SMTP id v69-v6so11152746oif.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRsn3RlH6OXRU59K97viP379aHsz5AczjngBBYtoaMk=;
        b=VsvS49IfuJlmPVmvAmL2ngL8y8ho51ussYgJAGkMgw8s96gmZDudH1W/RrTGIq8TV0
         zvFNVztQ7vnQSAV7LkBAoulhX3Kzb1JOVgXWgOiq4HY7z29L81sMaJ+5H0Xl39suWVVB
         jsb3/wQ5/7IqVA4Vl3swovn29du4fUTJaoh3nnxsCbisOyuP7FOgoiDRWw3OLQj/sBZs
         Fhe/fajOC/s+WR9EuyhVrhDCmflvT2EsbAWJDJXOrC/7xDGPGuJVCwtMNIwdVLo6o65J
         ex4XXSRqaoqcibIryERoNknXLBPcyyIaVJ3+JtbAoB80p4cwFZmXxRkXWwCbN4sXMzgm
         cRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRsn3RlH6OXRU59K97viP379aHsz5AczjngBBYtoaMk=;
        b=LITd3QdvgL1pd5WWGncS3ytaVWgQnHYodzFe2K0mPMM+P5qylYpRRDuYwLTK+pNgvQ
         s+V5VE3nHjOr1/seQdH8KVJ3FdPMMugbycbLhGlujI8gvu2SWfn/soGQW7hASLblxnrQ
         QilR/Ro+Y3IqWbSRxfC+esRw1uaRj9fVcDerkwr08fpdGtiF1SDAuWevJ8oylWLR+FZ5
         4cI+9Y1aySW0tKBCO8XQn8//Rqxg9pjJMbNI8OU+RuT2btLdEsrJH1N4sZnAdJ7gnbcJ
         AoYfw15wATfdldjIYavbHRerV+zHhm/DTL56/vK0UYSphFBq74Q2Sw94r3RCPkZmoKnZ
         sdJw==
X-Gm-Message-State: ABuFfoiMVvR8Dojzky07Z1tvLaQFx8jltyo0ekf3iJiP6c0pZUJQUzOq
        Sqky5sCrUHmhbqRpXMnrrAaVx1pra5qaoc+31xIZZx2Han0K
X-Google-Smtp-Source: ACcGV626Vk0vgmsRWvAJvzFdGIvdcQWmDUmnbbGZF9+h759fZgr14wjhUJ41SpzE3gnfu2pP+Wgoj354BP4DY3+zcys=
X-Received: by 2002:aca:5c85:: with SMTP id q127-v6mr40780oib.127.1538763171620;
 Fri, 05 Oct 2018 11:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538581868.git.matvore@google.com>
 <8c0821f68570551675901f4bfdd3149884286c48.1538581868.git.matvore@google.com>
 <xmqqd0sowda4.fsf@gitster-ct.c.googlers.com> <CAMfpvhJasrpDxgt+LATsSQf68LB97hCQnCCnRMJP51iXDc34SQ@mail.gmail.com>
In-Reply-To: <CAMfpvhJasrpDxgt+LATsSQf68LB97hCQnCCnRMJP51iXDc34SQ@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 5 Oct 2018 11:12:39 -0700
Message-ID: <CAMfpvh+0kugh8g=5KzAao6tru0k0Gp2-OY8km+Xr7fBDk4PmyQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] tests: don't swallow Git errors upstream of pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just realized that the changes to t9101 should actually be part of
the next patch (6/7), not this one. I've fixed that for the next
re-roll.
