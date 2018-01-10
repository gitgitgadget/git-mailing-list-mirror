Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9851F404
	for <e@80x24.org>; Wed, 10 Jan 2018 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeAJRom (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 12:44:42 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39877 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeAJRoj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 12:44:39 -0500
Received: by mail-qk0-f171.google.com with SMTP id r8so19616977qke.6
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hnzrECST5hlkwW5qfO9wwVcsrKfLs01orxTrn/OtaYM=;
        b=D+2N8BJCz3XuvVhr+AttwF86DErS1ukNaCdSsUSaWWT0M7l64OSB6UMxhtyGPz15C4
         W+OXd9l2+rMt6V67nmhGP7+E0Gb7wOnP/qVRKQs2I+lIAQJana3D7ONgm8nFkyDeGyOR
         xGrG5ERJaEmZxZ8YbuH2qVAycWCIsNwotegUf7eCmrILJ6pRjV5CCYMP/w5k0BM8v0ur
         P/W99vp/gYT9Gh9UGY6Tv/6NUSpn5BtFOLSzSU1OtcHtN+x1NrzvxT94e+cEC0Gs/JVx
         Ib3qvAfB6T3yVxVVuXUGVNpcQ9nNR6cA5wUrb46D/HmyUMYNoM5FRfMroxLxSzpwCdc4
         mM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hnzrECST5hlkwW5qfO9wwVcsrKfLs01orxTrn/OtaYM=;
        b=F+MO5sruvUMN1XlTPBYLjxFfFf5D3C7GxOVSjeRnhMb/TiVKdMJwtwwI0OClfCD0G2
         QSwmhy3OdUBEXDB+iVVvfp+LA6ivA7y1JsSwlkQllJn7rqPkgxw2Fs1nM8QR3p/476ro
         ThIn0Oj+fRHqWCeE68a+GnTbpydDI+ARwTG9A6HmSEKi+RFy4VQxWngLymj4ROoIkpi3
         kgXMgYXkzDnJtoChtdvMBmZJVp8jGocw45P8OkNUmxr1/ox700yzLv/VKTK2KJ84q3LH
         ahzoCJIKEeo8+csxMVBW1yXGhX1BjyPFy6TzOzGPwumId0qWfvOv0UsMwLTiImN8IML0
         Qu7g==
X-Gm-Message-State: AKwxytdSCAuFniCYHh+is1M3DB0ve5aJB86AWBcroLB7tm88UZ1TzFIo
        f/nlQgPZ35kGtWzuuA3MkXum9+X1i4wZFNcVJ5Y=
X-Google-Smtp-Source: ACJfBouHM9IVYBX7AXHzEFlN3o0f+D/yQgRPsHdmbJ5h5W3hfLinkc7JUBwBAaJmevldK1GvA7mAn7c8IOYcwEjY2hE=
X-Received: by 10.237.38.71 with SMTP id z65mr27293868qtc.114.1515606278716;
 Wed, 10 Jan 2018 09:44:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.2 with HTTP; Wed, 10 Jan 2018 09:44:38 -0800 (PST)
In-Reply-To: <20180110095832.22077-1-dev+git@drbeat.li>
References: <20180110095832.22077-1-dev+git@drbeat.li>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Jan 2018 12:44:38 -0500
X-Google-Sender-Auth: X6bEGvPSWgxBsXw5jIkBDAc7Ds4
Message-ID: <CAPig+cTmgp3=jkG2Kb3x+3n4Dsq1V6GMGkfVE3=p6KGMBnNMkQ@mail.gmail.com>
Subject: Re: [PATCH] t3900: add some more quotes
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 4:58 AM, Beat Bolli <dev+git@drbeat.li> wrote:
> In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
> were added to protect against spaces in $HOME. In the test_when_finished
> hander, two files are deleted which must be quoted individually.

s/hander/handler/

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
