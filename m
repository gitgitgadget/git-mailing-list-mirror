Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDCE1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeKGX0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:26:46 -0500
Received: from giant.haxx.se ([80.67.6.50]:35026 "EHLO giant.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbeKGX0q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:26:46 -0500
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 18:26:44 EST
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id wA7DiqPQ032004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Nov 2018 14:44:52 +0100
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id wA7Dipkp031998;
        Wed, 7 Nov 2018 14:44:51 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Wed, 7 Nov 2018 14:44:51 +0100 (CET)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] http: add support selecting http version
In-Reply-To: <pull.69.git.gitgitgadget@gmail.com>
Message-ID: <alpine.DEB.2.20.1811071443130.3368@tvnag.unkk.fr>
References: <pull.69.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Nov 2018, Force.Charlie-I via GitGitGadget wrote:

> Normally, git doesn't need to set curl to select the HTTP version, it works 
> fine without HTTP2. Adding HTTP2 support is a icing on the cake.

Just a FYI:

Starting with libcurl 7.62.0 (released a week ago), it now defaults to the 
"2TLS" setting unless you tell it otherwise. With 2TLS, libcurl will attempt 
to use HTTP/2 for HTTPS URLs.

-- 

  / daniel.haxx.se
