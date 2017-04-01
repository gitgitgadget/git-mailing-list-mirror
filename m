Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356B41FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 00:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbdDAAL4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 20:11:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35653 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933354AbdDAALz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 20:11:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so20439276pge.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S5Jpk284w2c1wA9nAN56yM/h/QCw1/alcFLJLRsi/nA=;
        b=J5xywJMEgyDsrPPhpsdYvisHFWoyw/t9dmrXnd6nfXOQnm4Aaq0U8SWTKqBz41Qcj0
         E+OsCNV2xlzkbuWj/JhUae6fzs9yiQi7FfQ6atlKJaFXmfnl9eU66nIrlBgon27lxP/0
         8Oc+7dbXclUZXyLaG7B7D0KIDK12qMbiQlERde0fDt+7kL5DSeoMJ6pYE7cA8+I2e1cA
         I3N46JBP3yQLynRoJ1d1xfJUw9Ql6azQputxP6uXkkrX7F/C7HW4EKzKSpR1MHebEXp7
         g+37y0KgFTG9QQN+adngvE+nKf7jcZaverzxoTwwLk/W+7MUsnDu8yXVILBnGYvKcdTZ
         tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5Jpk284w2c1wA9nAN56yM/h/QCw1/alcFLJLRsi/nA=;
        b=nuqjgQuMrC4q499l+5eRnD86nQ3wKv9heGdUMjrlhgd7fdyvLJ9Waa+AWpNg4czRVj
         MkzyrqkaE8g5wOYLkKr985wZszmy1XNmKzVFLbhM0RTx1Y8DLxgLtiVzSU5W8wyGH96J
         ZIgVWva2zH9i38ZV48qVLJMER1wRrRBVsTujWoaFrA36AwMJjDV+6UmSCXqg28dcov6O
         zgL04dbGnoVlHGqqXnK1V1uLseO2yb/Jx+wGXTMAn8/ZEOs2F3f8awnIM8/W71etwuA/
         OKwUfk0BKO/Anu6EMoYcUnvUC6XmoqzkZyMPm1DZRw2wIJscj691x9urVS4N3U+GqzMa
         IHMw==
X-Gm-Message-State: AFeK/H3CaDivd8CbJlS2zvqpMrhBQOoy0mRKE/wt0LBhj/jhoso4lMaYtgO0jbTkoQzKIg==
X-Received: by 10.98.144.16 with SMTP id a16mr4817087pfe.247.1491005514825;
        Fri, 31 Mar 2017 17:11:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8962:97f5:cc56:a89d])
        by smtp.gmail.com with ESMTPSA id w186sm12550332pgb.35.2017.03.31.17.11.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 17:11:54 -0700 (PDT)
Date:   Fri, 31 Mar 2017 17:11:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] push: unmark a local variable as static
Message-ID: <20170401001152.GB8741@aiede.mtv.corp.google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331235623.166408-1-bmwill@google.com>
 <20170331235623.166408-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331235623.166408-2-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

>                         Also, clear the push_options string_list to
> prevent memory leaking.

That's not a real leak, right?  Is the motivation to make it not show up
in valgrind output?

At first it didn't look related to the other change but then the
connection dawned on me.

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/push.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
