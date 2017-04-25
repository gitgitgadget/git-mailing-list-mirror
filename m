Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D947207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 08:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1176908AbdDYIv0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 04:51:26 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38834 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168456AbdDYIvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 04:51:23 -0400
Received: by mail-wm0-f46.google.com with SMTP id r190so89582700wme.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uyAqhsOeKPGPNVeMu/9+7euLSDLR8OeY41+uqYo58hs=;
        b=Wxqn1Z3LMDQsHHTWFgJ6QHtAwhB/dKCur3+rBgyYW6S1BX9IuNqaOAEyrLJa55uraN
         xGFOfosGpo1Dt5CcixxgetPvUni1ZEJlP67UxYuzR7EcJAibIjViWMz4o1xMRvCQZjqL
         F0pHX6/6zpVhYncOHb/W7Xu3ZnF3Arj3qdU5c4RPmtN/CHbwixWHiOiamnNJanibaiVh
         pjJS4jvefdWSbPEQPCMESVAcUiEy5jZIAHo92QucnR24p2NVB5nFdJJ1Htg38qiWehQq
         Xs8FeIYaR8A7GEUDQDaKdB3EHA/6GYSNBheSTgTxfvKe3H8oKIuyBomDJnozX8z5MCoq
         WrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uyAqhsOeKPGPNVeMu/9+7euLSDLR8OeY41+uqYo58hs=;
        b=H8r0H6sbaxzpvFews2KWaoZrNaH48ZVPT8/8OrXMLztUvbvJVMRAJI+b0uPlFtBeea
         avApuTq3poPekKDVYe98dMhDQeNqRRN7FezaC2Qd8jNQIRiaqlCPHKuY52wDIxP/ps5n
         51PIGgvkZ9U/PB/C+81I15CJEk2z77pgcciA+fcapRcA2h3IC+kir/LKD8GO96cevowi
         GSj0MEL9gnidpozNv5OfFxO+fJzlslCMIvWlBUNPBGJYSzD68wJIhMdRwU+t8jSCKskG
         PKOpvu8Xe0Ow/CVLz3uCjzoIgYfxq/WfwzFzxacuKxJ7KNuTInWtPtnz6mvkbGyBhVCQ
         EJAg==
X-Gm-Message-State: AN3rC/4EEXssbAZIkZmFsDpodbgsCBxOOlarBoqpgVi4uAN2hr9hncBI
        CfNOuDT9fmMTlw==
X-Received: by 10.80.152.69 with SMTP id h5mr4175196edb.66.1493110281961;
        Tue, 25 Apr 2017 01:51:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y24sm4816726edb.62.2017.04.25.01.51.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 01:51:21 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net>
Date:   Tue, 25 Apr 2017 10:51:20 +0200
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <054E67A2-56B0-4C91-89F5-F33E8C00ED61@gmail.com>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com> <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com> <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com> <20170424203710.cijg3bjdrb2eywmh@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Apr 2017, at 22:37, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Apr 24, 2017 at 08:22:36PM +0700, Duy Nguyen wrote:
> 
>> Off topic, is it possible to receive mail notifications from Travis
>> when a fault is found in either 'pu', 'next' or 'master'? I know how
>> to do it in Jenkins, but I'm not familiar with Travis and there's no
>> obvious button from the web page..
> 
> I looked into this a bit for my personal builds. Notification config has
> to go into the .travis.yml file[1].  So I think the best we could do is
> send a notification email to some mailing list, and then let people
> subscribe to that (or it could go to git@vger; I don't know how noisy it
> would be).

A separate mailing list sounds like a very good idea to me!
Maybe "git-builds@vger.kernel.org" or something?
What would it take to set something up like this?

- Lars
