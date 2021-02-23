Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 22:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE17E60235
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 22:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhBWWTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:19:18 -0500
Received: from silly.haxx.se ([159.253.31.95]:42376 "EHLO silly.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhBWWTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 17:19:16 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2021 17:19:16 EST
Received: by silly.haxx.se (Postfix, from userid 1001)
        id F24895E4EA; Tue, 23 Feb 2021 23:08:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id EE27F7D5D1;
        Tue, 23 Feb 2021 23:08:43 +0100 (CET)
Date:   Tue, 23 Feb 2021 23:08:43 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     Kevin Burke <kevin@meter.com>
cc:     git@vger.kernel.org
Subject: Re: Crash when using libcurl with new hyper + rustls backend
In-Reply-To: <CAAJ6v9AruZ3HfqB1x6CKBM=JgFj8bNwjQFUO4rzv2s=yeXfcDw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.2102232301550.23358@fvyyl>
References: <CAAJ6v9AruZ3HfqB1x6CKBM=JgFj8bNwjQFUO4rzv2s=yeXfcDw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 Feb 2021, Kevin Burke wrote:

> When I compile Git using this curl, I get a segfault when running "git
> fetch https://go.googlesource.com/tools"

The hyper backend in curl is still considered experimental and it doesn't even 
pass all curl's own tests yet. Before it does that, I'm not sure it is 
constructive to bring problems to libcurl users like git since if the problems 
can't be produced with the built-in libcurl HTTP code, they seem likely to 
rather be libcurl internal problems.

-- 

  / daniel.haxx.se
