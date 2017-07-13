Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF32202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbdGMSPM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:15:12 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35768 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:15:11 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so33215681pfk.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=XahfnCKdoZCWSW20BuKCiaiZ3y8Utwbxhdfs3NIWeFQ=;
        b=p0DeSxvCn1r2ygYqdEiCD6O//9H93cWmk5HZoHdpN6suOVfL9p2Q6qV5j8yBxbNdeE
         rhTunf8BwNnf664U+TmipY7pK83aR7XWI/pZ14WrzUwbn0kn0wninsh6IW6yAxcuvchP
         tHeDjCRcOItvJNOmcTt2IaI8uV+vn0H8YroZGnbUVPxJom7MXzjHjsvvk7qFya5pZY3R
         j86Fi7OCfRXQxho9S59yOysvYXmen6E0mIwCZYfQ/S7DaY4igciT7YjTcJUU+pIEainC
         dgXcRQIvNMyWa3EROxapS5b37161nJM2I8zkie2xjvxuK38yO8yhcKLOXJxtNsU4Ij8g
         R8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=XahfnCKdoZCWSW20BuKCiaiZ3y8Utwbxhdfs3NIWeFQ=;
        b=ZIKWxHT3CSvOmfPvkxHVf9OSipPDWcMzB3D0Dyd3CkYGWib/7rh3nw8UhfZpfzvkjl
         LkQZROq/rBFhajPctviflGcQxLhNooBltfAUm2jDRgZojocGpL+zqzKSmqa/D0fx4iLL
         sxzQtGE/2PTMlk841ontNVIyIhAyvPSN9Qhtz/tD3fTW9qfh1UmE1VoeR5y9mysvVSmX
         7iUR01R1U/wxfVk5R1UZng8KN3hHnpiINQGeUnXW0cqHiRqZwicSGIrLt3FOL8IEg8O7
         Xr2ORkUyupQ97BrkAVKEmfDhN/u6ZFcEK7aQtqgMkO/Vxa6d3DTMCuuOS/aLEOLza9+E
         x1jQ==
X-Gm-Message-State: AIVw1125RAutmLzuHGrfVi/bQ1C8Fae6LDHecuSC6p4V5RJxO6oGlaO4
        Im13fd61Ak8MYQ==
X-Received: by 10.99.171.66 with SMTP id k2mr10644632pgp.248.1499969711070;
        Thu, 13 Jul 2017 11:15:11 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 28sm15399900pfq.125.2017.07.13.11.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 11:15:10 -0700 (PDT)
Message-ID: <1499969722.5973.2.camel@gmail.com>
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info
Date:   Thu, 13 Jul 2017 23:45:22 +0530
In-Reply-To: <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-07-11 at 13:22 -0700, Junio C Hamano wrote:
> I think the "validation" done with the rest_is_empty() is somewhat
> bogus.  Why should we reject a commit without a message and a
> trailer block with only signed-off-by lines, while accepting a
> commit without a message and a trailer block as long as the trailer
> block has something equally meaningless by itself, like
> "Helped-by:"?  I think we should inspect the proposed commit log
> message taken from the editor, find its tail ignoring the trailing
> comment using ignore_non_trailer, and further separate the result
> into (<message>, <trailers>, <junk at the tail>) using the same
> logic used by the interpret-trailers tool, and then complain when
> <message> turns out to be empty, to be truly useful and consistent.
> 
I have a few doubts for which I need clarification to move on with
this. 

    1. If we abort when the <message> part is empty wouldn't it be too
    restrictive ?

    IOW, Wouldn't it affect users of "git commit -‍-cleanup=verbatim"
    who wish to commit only the comments or parts of it ?
    (I'm not sure if someone would find that useful)

    2. Is it ok to use the "find_trailer_start" function of "trailer.c"
    to locate the trailer? 

    Note: It has a little issue that it wouldn't detect the trailer if
    the message comprises of one trailer alone and no other text. This
    case occurs while aborting a commit started using "git commit -s".
    Any possibilities to overcome the issue?

    3. Ignoring point 1 for now, What other helper methods except the
    ones listed below could be helpful in the separating the cleaned up
    commit message into the <message>, <trailer>, <junk-at-tail> ?

        * ignore_non_trailer
        * find_trailer_start

-- 
Kaartic
