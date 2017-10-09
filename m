Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F03320372
	for <e@80x24.org>; Mon,  9 Oct 2017 22:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbdJIWWa (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 18:22:30 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:50870 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755544AbdJIWW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 18:22:27 -0400
Received: by mail-pf0-f181.google.com with SMTP id m63so15154135pfk.7
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DKMyoJY4EXYqiK2SKgNOL/4ERT47rJqfYpUOQxkse0k=;
        b=a52JaQ7V7sQ89w3TrJuIeHhdjdxpX88eD2bpm5pXo0sejWarJmjT5sMJAbKtEuNDHU
         Qe69Zor+TRyoWEQ4K5qNWjyqJsqpKQvxen1fPEFcda9/SZY+1oL53WOz4qpPNe2aacqC
         Jfa2ULEPFJWOBMBhG7gx2tIYvGu4CTzqSatpgbXjrAj5tyeTLMZo+FMrpyUhZgxDcGHB
         ZpBeKdO3jOZyu7AA9g857+RcC6iU3Y9QJzX7PFjNp5w5CUj5RDOOt7VaeppY2fsHFRhC
         ERtWk+CdWK2ilmFB32eAsi2wTRlg3KarYVSQVpfs/O6fV5h2gjbzydKZomwvobNEtRMU
         2Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DKMyoJY4EXYqiK2SKgNOL/4ERT47rJqfYpUOQxkse0k=;
        b=JnkYl+SxJdcEWa+0AruuPRBOngMB45SfPrGe1nPOxFZwf0LG4Yx62C1036W1rBOXsy
         yJym/dqwj2QCboQC3+SfYTDmvOp02AG1ctH3xeD3aOE7uQ0CID8f6+urvFCbcJlxuyFP
         Lh6lkLvzYm0MdICrwskgmWny7b+HqgwofSqkg5ws/NacKIs+jD9MYWAlCLr0CQXC7A4g
         wDYtdWu2GY8vjB9UQHxymc//Oc8Hnj3MUxkRowP8Ne99Zogq8BqOoAgrj/stq2w395QY
         y4eNpW+1BDZN1ywgZuk5CIzgUifFBiuENsNBhevuxW1451H/PTVdmmQISrfro5sQ77Jk
         pAMA==
X-Gm-Message-State: AMCzsaVy3WTMTXW8NA6pVhmsKHexWS5ILvkwvz1uDDLVIMrUq5zWtOjm
        peWycMLJQIIijBIEWmkFCc2XFSg7
X-Google-Smtp-Source: AOwi7QDedqbxqes0QJp7AsSg7Mf9PFXvXQ48h6w5jWkI+dinzSfSb7rrx+xToD27kxz+pKN//XmJRg==
X-Received: by 10.101.76.6 with SMTP id u6mr10290300pgq.93.1507587746966;
        Mon, 09 Oct 2017 15:22:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:14f3:fccd:46cc:9e97])
        by smtp.gmail.com with ESMTPSA id w188sm18251804pfb.67.2017.10.09.15.22.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 15:22:26 -0700 (PDT)
Date:   Mon, 9 Oct 2017 15:22:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: spell out API of submodule_move_head
Message-ID: <20171009222224.GD19555@aiede.mtv.corp.google.com>
References: <20171009220615.27541-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009220615.27541-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> This way users of this function do not need to read the implementation to
> know what it will do.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c |  5 -----
>  submodule.h | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 5 deletions(-)

Looks good (well, you'd expect me to think that :)).  Thanks.
