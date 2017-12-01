Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5A720C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdLADE5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:04:57 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:34292 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbdLADE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:04:56 -0500
Received: by mail-it0-f67.google.com with SMTP id m11so3026880iti.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2gORYBVhLgzhoF7x/Jm1xb7t1cjJUqsjKZCElwAO4lE=;
        b=laXZ7+ViirAGxjNvKx7ruy99KR6oABEYm4m7ibCJQ0BWD+oEK+VaKEzJofWtjVCHUq
         GLeLuqRCQ1X5XKdlz1IXCGCKbvLgX3juS3ovkNjpZE3RQA5IG40eF/OXc0k1WNmtT8jC
         R7tpZCp/0zf5s2VIH9KxjTDnYXB8ZybWvbgBQz+Bg3tieoxSAUxlw2xrn8vbVBrXfbOH
         /Smss/71OO/Jyiyp4Dq3eEI6sKX6+6WjnZL+9x5tW+KmXvLnXQ3H8EKw57HhnIvbRsB6
         P1YFKynfdgQ+Uuq1iMxa9kb7oV46qnEnP1UYmv5qK2rtpT198Fk1RKohzfscYySmSbw0
         cSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2gORYBVhLgzhoF7x/Jm1xb7t1cjJUqsjKZCElwAO4lE=;
        b=j6lrrlfuPT1BtllKFMxE5R6HG2bfyAKEcPmB8gXuVerAOZGKccdApGXjhJkZqPAp3J
         9U8VTFflpvUlyx46b8ULUxpCAX7lqvWRputv9o9woitRi9y/s7C9gPEN5/jxp0Y6IVWb
         tzroULNDjGgfUFNClB8krbCr/Ph/t+f3rZoga+V0BGE8dfSfWZoSbInoybo8f5ZOSJ+X
         MGVHMzB+StpVoHd3IL7Sx7L88mHtROm+aQes6TPVIX/4hloUb4tbwX60wFmetUF8Flwi
         cYIJlivUtgiL8wiuUEi6+tHzbJpwK1HsdHYFz+7Y5GW3/oxO+c4qt4N7w1SLsMXWT4Po
         vPrQ==
X-Gm-Message-State: AKGB3mLDAZ7MKNcSR/15nUd12nH5XIPxdUzIS5HGa405SZ4BiQjDonWZ
        A0Yj6G9I3CFrzodaW7y0zg4=
X-Google-Smtp-Source: AGs4zMYHkRGZHjUCJ83C12Q1xGImX7/d04kPvn7PC077Tg9QMcLWHVgZ6dMR6LYageVbRWhjsftgvw==
X-Received: by 10.36.73.9 with SMTP id z9mr91023ita.36.1512097495478;
        Thu, 30 Nov 2017 19:04:55 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v76sm5750itb.1.2017.11.30.19.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:04:55 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:04:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/2] t/lib-git-svn: whitespace cleanup
Message-ID: <20171201030453.GG20640@aiede.mtv.corp.google.com>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-2-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201023239.26153-2-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> Subject: t/lib-git-svn: whitespace cleanup
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  t/lib-git-svn.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.

nit: it would have been a tiny bit easier to review if the commit
message mentioned that this is only changing the indentation from an
inconsistent space/tab mixture to tabs and isn't making any other
changes.
