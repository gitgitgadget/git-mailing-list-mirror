Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4100C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 21:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F81611C3
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhIJV6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 17:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhIJV6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 17:58:18 -0400
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103DCC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 14:57:07 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 6A7555F6E3; Fri, 10 Sep 2021 23:57:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 67C0B7DC6C;
        Fri, 10 Sep 2021 23:57:04 +0200 (CEST)
Date:   Fri, 10 Sep 2021 23:57:04 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
In-Reply-To: <87lf44b4e0.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.2109102350460.2614@fvyyl>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com> <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com> <YTkNdGk28UJnSDVt@coredump.intra.peff.net> <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net> <87tuiscwso.fsf@evledraar.gmail.com> <YTt5nhXfZ8CRYayk@coredump.intra.peff.net> <nycvar.QRO.7.76.2109101740380.2614@fvyyl> <87lf44b4e0.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-39887073-392473790-1631311024=:2614"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---39887073-392473790-1631311024=:2614
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 10 Sep 2021, Ævar Arnfjörð Bjarmason wrote:

> So it was just a mistake of mine, sorry to soil curl's good reputation on a 
> public ML, my bad.

Ah, no worries. I'm just glad things are good!

> It is really common for the two to mismatch (e.g. because there was never a 
> version for that release, the maintainer grabbed some version, did "make 
> dist", adjusted files manually etc.). But apparently curl was rather early 
> on bandwagon of good SCM practices.

I'd like to think that we've had that part pretty well nailed since a very 
long time back, partly thanks to us sticking to simple and straight-forward 
even for version control. And of course thanks to git for making it easy to do 
it right!

-- 

  / daniel.haxx.se
---39887073-392473790-1631311024=:2614--
