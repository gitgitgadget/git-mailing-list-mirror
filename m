Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA951F461
	for <e@80x24.org>; Mon,  2 Sep 2019 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfIBNBd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 09:01:33 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40954 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbfIBNBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 09:01:32 -0400
Received: by mail-ed1-f41.google.com with SMTP id v38so9692642edm.7
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=3azwBLn/c9xX+m+hzBQ3MsYHfSclCknKrIBkySZcwKw=;
        b=HygS81Zyyuosxa+Z/3tegPWsSVNiZCENx54w1SjT6Mj0pT3yWwWIue8hE2yAd/qqzH
         k6kzb0/SFzbjxzzYvrW6NpniY8ucoJgitbkNZDnCuzeZPb4SwcHboEHDbDdMUUOZwibN
         N6mzzYqcurV0eHQC6BAIaLv0ITigWlLqT4OKMIbXwCLHLuM+bH4j9OR8fEtwIZJCjldE
         FyK0fSwkKY8v1JpWm1mDJF/upBK2OZv5tf80rNRGAtTK+fQkCt07VJsOFi7qCUlpj+U5
         nZ2sIwTQn0sYfROWmpjDV8u0mHTLp0kh6p/JLyw7kcJNmZZ0YB8wF8UB5AsPlWi3nq6E
         6uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=3azwBLn/c9xX+m+hzBQ3MsYHfSclCknKrIBkySZcwKw=;
        b=Td52WBqfX0JLuBaKS71nhDk3Jca+GR40Tt2dePQFL3CxtYMK4ONnL2xnudeGI7YtvT
         MHB4pMVEzzRyJAqUSFL8uO4ox3iXJ6abfMudUdk51uSpfL4CHg6fX4qccTOn14bNHw1c
         aoVP1izguWzZtjuRH5ygJBIc7lBf8HL3N422FavVLisZ4NxaoDF9EtcD5dNaiFT+BoJW
         p0QtmtMyU534L8i24fU6ZYuwEqglarjNb5h4GY57tGRMwBPDbrbYOONezTW1r1VnJPQV
         ZLC3u/58z92FnQ7TA+FcYq4bu+Bd1uMd+G5xdgqNqOdHgI8u7SrP2nhrTzCXyJnU1msF
         ekUQ==
X-Gm-Message-State: APjAAAVgc0mtseCuMCGIScEq+YN0Cf8/vixREGMCv2OvhtUGWQUNZmZ6
        N6RIiy+ZCaUIsdS42OzJh2I=
X-Google-Smtp-Source: APXvYqyVZavX63nprclkaXcuyyBOEZgZ0t5m+cxsW/+rx+hGpfx++RNHiq6SJTfNyqvhnxntbheySw==
X-Received: by 2002:a17:906:32c2:: with SMTP id k2mr23954201ejk.308.1567429290386;
        Mon, 02 Sep 2019 06:01:30 -0700 (PDT)
Received: from instance-1.europe-west6-a.c.vaulted-journal-250706.internal (169.120.65.34.bc.googleusercontent.com. [34.65.120.169])
        by smtp.gmail.com with ESMTPSA id w11sm1948876eji.2.2019.09.02.06.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 06:01:29 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:01:28 +0000
From:   Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org
Subject: Re: [BUG} stash show does not show untracked files stashed (reposted)
Message-ID: <20190902130128.GA2843@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Reply-To: 002901d55e8f$e4a4af70$adee0e50$@rogers.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Suppose I have files a,b,c,d modified, but only file d is in the index.
> After stash push  (or save) --include-untracked, stash show only displays
> file d. A subsequent pop will restore files a,b,c,d. So functionally push
> and pop are fine, but stash show appears to ignores files in the stash.

This is more of an enhancement, isn't it?

To reproduce

$ touch a b c d
$ git add d
$ git stash push --include-untracked
$ git stash show
 d | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

What is the output that you think should be printed?

-Giuseppe
