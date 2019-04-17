Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21BB20248
	for <e@80x24.org>; Wed, 17 Apr 2019 02:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfDQChL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 22:37:11 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42670 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDQChK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 22:37:10 -0400
Received: by mail-pf1-f169.google.com with SMTP id w25so11336755pfi.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 19:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFBwFAezq/uVxfeYEeYkBDSaGMrC62bhldDh//KNcqg=;
        b=WGw6rMfGZvG4s6FiyWrf13DD+PU+9JvkjajnwOX8wQM5paqa9+1g3MnKNy5XPbt9dN
         imIA9urGgz9hTZIYwh+oAG6FGSBoHTaoCleXsFL397gAlJtRFjrxH0q7KPjRBwWLJyP9
         CRLZOB3WX0RnbT1W21tfEF1NMKWlsAP0gO03yhoQ5iOLFX4s+slbLP7JH3w4APT/14+D
         g2yNOUqvaLqQYHsSGDU3WhZpbd2ed+vn6ZZNXoy9kVWukIXMUYdMCabBCdY+LZZ6uuxp
         zDRjgh7qa1TpRXzm0CJ7PORxZM2t7Pt4JISa5zlJH+tcj4Km1W68nu0oF0dlA8ewtwMn
         INgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFBwFAezq/uVxfeYEeYkBDSaGMrC62bhldDh//KNcqg=;
        b=PhB2eUVdYukEh1gqAfJKCwPPTHSStir2CXFfJ/ZeC5x4BzcqAjxipb70uosWQPNFsO
         SD2C3hrEpwPjOBGo7wEQBGkiKxrQndsRLYE6id9ldMJXa0QOC586oyD5Jw0uQ+VuRtWr
         iKabiYbFn8cpUXB68iRw1ecSTf6pPyQ5Q98i82/3meyTLswONWb+IFka0G7s/zxlY53R
         58xsKH6XxzmUgwD06IiSBYPeFO3Ly/7ge0t8LDRKOo/CclCnAYZGKXOXYs3+sZ3emL+Q
         ZEKK1OZDTaZU6FqtHkZLxPh8IBVaFuYdATwt81DXR7McjGIQE8Cm2J9SI5BP8HGPx2pJ
         +AVA==
X-Gm-Message-State: APjAAAWHZcwhwys88f7Jx8evCFTDYwy5Vch/rSUPBUZelf7tS1GQWCtP
        lx3iHlXoSshSRcQYAdupCYC7pCBGBphUaw==
X-Google-Smtp-Source: APXvYqwFiEDqLMACHpjYHoIGT1mtSYvtvonAWqKUkhN1/WlE2xj4rzJzkWpyIqhz67yml91dNj5UUg==
X-Received: by 2002:a62:75cd:: with SMTP id q196mr77748753pfc.70.1555468630083;
        Tue, 16 Apr 2019 19:37:10 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e0dc:83cd:66cb:9fa7])
        by smtp.gmail.com with ESMTPSA id v20sm69527545pfe.118.2019.04.16.19.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 19:37:09 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 16 Apr 2019 19:37:06 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
Message-ID: <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 16, 2019 at 10:19:45PM +0900, Junio C Hamano wrote:
> * tb/unexpected (2019-04-10) 7 commits
>  - rev-list: detect broken root trees
>  - rev-list: let traversal die when --missing is not in use
>  - get_commit_tree(): return NULL for broken tree
>  - list-objects.c: handle unexpected non-tree entries
>  - list-objects.c: handle unexpected non-blob entries
>  - t: introduce tests for unexpected object types
>  - t: move 'hex2oct' into test-lib-functions.sh
>
>  Code tightening against a "wrong" object appearing where an object
>  of a different type is expected, instead of blindly assuming that
>  the connection between objects are correctly made.

I sent a re-roll of this series in [1], which should be ready for
'next' if you feel comfortable queueing it.

Thanks,
Taylor

[1]: https://public-inbox.org/git/cover.1554861974.git.me@ttaylorr.com/
