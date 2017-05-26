Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DC51FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933130AbdEZQTM (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:19:12 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36384 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbdEZQTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:19:11 -0400
Received: by mail-pf0-f177.google.com with SMTP id m17so15734400pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PUBot6meowXFLI99L0Kt1zo3P+2aHBncTIBXTWwuKMo=;
        b=ccaOHu3WHYeAlqWEDd45y9oOvvwjifibBaIcHHIhh/KRQRiXi8G8WeT2XWCvU2sNCM
         26zugv6iz1G9rMubWH0usaRZqKNUMzPHRUwdvRRZxehJD9qK7efJ5C3Z0vP/jYp2pIif
         T+V9FSrkL9/cD/vudhkxndQ8efHCHmksmiJsRW0me7D1uxTDaduzNrnLU1c8y+cNMPOg
         R9udTGi5bb8gqie9fNKlRBINWs9iRCmaNuVPn7xJEhHRiZ+8YlBolErFbU4O4n0nmQ3B
         i/h185ThjxJzPaCmlKlGfXHDyOdahWT/tvGfmuIzDe+tOVJ1DYb8kOJG4LPuU/LmJ5R1
         JOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PUBot6meowXFLI99L0Kt1zo3P+2aHBncTIBXTWwuKMo=;
        b=P8lwuqTBIlTmyJVvpdEnLkSJGHzCN/wLecLrj9KAavDtRO2wgsxZNzwUjb6tzJXvRo
         EulEiu0+lBlsHILIqEH/uLr6E8G3WQl1XawtJoR+eRxvco1ri5p1gcTlyBaxgyMZtLsc
         uZFGzrD9vac3mdtBIcF3jFD9t7NxNMl6y+WQE5vFNea85rx5/2ozV1bsv0BwEtaFPHPf
         rra94J4MISJbUaiRf9Az+/eVsSdjapXTWns9vJHA4w6cW1ibSuFk6h5p6D3dbS7myqlj
         DntKkG8OqWzybmTvbcTKmIjq22y6W7Zq51xqA/dG1KIrPqQAyDN6iVpv20F48nAEZFUp
         Ytdw==
X-Gm-Message-State: AODbwcCsVMeTlrNJCfmx+h9wetUTxN1mA6A9IAyQk7LmCpdPpoV4kMKw
        r1YyZkghICDDs74FzrciVoXq48WsYKRQ
X-Received: by 10.98.236.150 with SMTP id e22mr3358927pfm.48.1495815550553;
 Fri, 26 May 2017 09:19:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 26 May 2017 09:19:10 -0700 (PDT)
In-Reply-To: <20170526151713.10974-2-pc44800@gmail.com>
References: <20170521125814.26255-2-pc44800@gmail.com> <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-2-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 May 2017 09:19:10 -0700
Message-ID: <CAGZ79kY4s_WtEJfyFStchFvr7ka659zYjv6H3vy9GsCX2sKbdg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5 2/3] t7407: test "submodule foreach --recursive"
 from subdirectory added
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 8:17 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Additional test cases added to the submodule-foreach test suite
> to check the submodule foreach --recursive behavior from a
> subdirectory as this was missing from the test suite.

As this demonstrates the fixture of the first patch,
this could be squashed into the first commit.

Reason: When someone is looking at that first commit, they
may wonder if there is no test that demonstrates the fix. (as fixing
a bug with no test is bad style. ;) And given the data structures of
Git it is only easy to find the previous commit, but hard to find the
next commit (this one) later on.

I think with only the minor nit in patch 3, the foreach is tackled. :)

Thanks,
Stefan
