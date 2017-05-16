Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E95201A4
	for <e@80x24.org>; Tue, 16 May 2017 20:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbdEPUMP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:12:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33439 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdEPUMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:12:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so22583882pgc.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lw2tCM3DnA8D/Z+yr0MLnOrrqOBgaRB6al7jFD5aL1U=;
        b=La0Xn5T9b9by4a+ur6zBRHSK49hRlQQc5XOK9zgAuxwCusmOH4zGDbXbnMKzMVig+2
         kbaZYES1zXlxduOVHahe9DCDg8X+OsarvCLbUh8iXt0HkbnZWoNMeBmogrUn6hNhMhZU
         0IlIRFFQXaRXuCRT6n6UvLiDWXvlq5iRX9vGgFAsqgLxQnQjZsPXjYz4Ua6U4nc4Knhl
         gihkVaYJNYmehP/6TMKqiiKHVqRcdO9FeUn/Q7KHlMiZKyuXiiI8pgFxiP3fUYUehzRb
         0Hj9XlTkrjiPDjJunWTGy6fnPYSPFyPlN5Sf7EcbjOHjb9W+EpLSFvKbfolBFT0OMWVz
         Xakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lw2tCM3DnA8D/Z+yr0MLnOrrqOBgaRB6al7jFD5aL1U=;
        b=U5zqbu9XXAr6zgigBL3R3nA8PROOWDjDRU3uJHj5RYrzvtHTmAd/Vpzlq+nN8rEats
         Zq9YT3tdtmIypixeKreHlBvJgs5aciSAQgH0bt9KmOkHkO5hn6QnfjvXXnHoKRDQzazr
         PCRSeZqR9x2I5W0AVNpB0FGlJo6SC0EDUoSOx9YrHxZrexCh25lZcpL2xLknj996uUqQ
         gUv+qGCjoMGMXS/MAmGm0No2TIZRdbN2iOfnoxWlHckK9Ein495eFWKa2hBVveDBt73H
         b+kxopm+bpROK8zdPrlPZ/ugDsL+a57LnwfeXPbgidtJTXYijw0IFjONUQtw8+ROtm4R
         9/8A==
X-Gm-Message-State: AODbwcDUE1LyLZgrhy+o6LvUFXwk+YnIxG7dp1W7DerJHsjSBbsGOYc0
        KLexh18Q92dzmOG1Mtg=
X-Received: by 10.98.67.8 with SMTP id q8mr14086203pfa.67.1494965534116;
        Tue, 16 May 2017 13:12:14 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:cd47:ccb1:c55d:4b70])
        by smtp.gmail.com with ESMTPSA id h89sm253031pfh.45.2017.05.16.13.12.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 13:12:13 -0700 (PDT)
Date:   Tue, 16 May 2017 13:12:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: add git stash push
Message-ID: <20170516201211.GQ27400@aiede.svl.corp.google.com>
References: <20170516195945.745-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516195945.745-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer wrote:

> When introducing git stash push in f5727e26e4 ("stash: introduce push
> verb", 2017-02-19), I forgot to add it to the completion code. Add it
> now.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
