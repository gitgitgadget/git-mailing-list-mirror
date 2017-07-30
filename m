Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02142089D
	for <e@80x24.org>; Sun, 30 Jul 2017 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbdG3KrV (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 06:47:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35367 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdG3KrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 06:47:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so23928469pfq.2
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=+n4xF0ZbHbgnCukNnzxepOVHoGxEXn/rSa0lcJdNFgA=;
        b=hp+QfHWTIXLDcOf+QpgMNBQUFUZ9ZplwFT72FqNUZg4gskigogAptzAlYDboVSB3th
         rtZ5hN0Cb1exp4W4g4KEHoZbt6uETP/LIeYV+Nl3tXFowj6C6hiY4he24vWlTMT0T+Kf
         XLWvXuw9LOsz9NK5h0PjF61/UEGgStp1HgVyLWtU0Hl5B2tEDFP90q6ZZ2KYvy4jr5uS
         pnhuadS65ftpm3yXWZHhIYjat3EMOoqTYTGppVSRR4kGncVq8sOK8sdbV4YBUXaFQsr4
         nAhlPWHlX9d6jvZRQT4DyHE5GWNafCg1W8ewSlRbxoFc72643bWDywaetRDGgjRzFr3X
         ariw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=+n4xF0ZbHbgnCukNnzxepOVHoGxEXn/rSa0lcJdNFgA=;
        b=o0pJjiHPWIDnhdQ1dDX+l+I1WC9G+oPH8BlrLDCnAkgx3Y/eBwKyygYSdCfgRbppWm
         B7D2GHAzy12zgZYUc7GzIjgsjg7ZOIcUQTqoiejQwQuIKLhDdk1sR7oitIImC62hy6NN
         tMn2KV5zfJM6b5I193co1kXXef6+RjCc5Y2RQD6lPPrjBl5Va0o4pf+6WdRZWSFuH50d
         SZBkr3qSzqRNTmDjL59+0pGak0y8W3yuwNEyYq/wEAY1YayR3SHtCRrK0di1n3DccRoo
         Sy9rTaMY19oGseTqEhS2qbfeTy6UfXCeHi6bdHjxU6GTJg9U9+SqvzlxoUXoY+K0SjsY
         zYQQ==
X-Gm-Message-State: AIVw11077+mzRQivGdGOWZXoXXWPvhEdWlwFfpKpZ7X2yPI6LgyAKxUD
        AKrdrjvqnEqcbA==
X-Received: by 10.84.176.131 with SMTP id v3mr13915631plb.142.1501411639701;
        Sun, 30 Jul 2017 03:47:19 -0700 (PDT)
Received: from unique-pc ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.googlemail.com with ESMTPSA id l2sm41236241pgc.27.2017.07.30.03.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 03:47:19 -0700 (PDT)
Message-ID: <1501411669.10533.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqqy3r7jkbb.fsf@gitster.mtv.corp.google.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
         <20170725212110.GG13924@aiede.mtv.corp.google.com>
         <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
         <1501296270.2112.2.camel@gmail.com>
         <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
         <1501330390.2001.1.camel@gmail.com>
         <xmqqy3r7jkbb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 30 Jul 2017 16:17:49 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-29 at 09:10 -0700, Junio C Hamano wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
> > 
> > That's interesting. In that case, I'll go with the suggested statement,
> > happily!
> 
> It is not interesting at all.  It actually is disturbing that you
> had the notion that these are "valid" command lines.
> 
Seems I've used a sloppy statement, sorry about that. I actually
thought these were valid because they "worked", no other reason.

> We perhaps need to somehow make sure new users won't be led to the
> misunderstanding.  Improving our documentation is a good first step.
That's something I could help with.

-- 
Kaartic
