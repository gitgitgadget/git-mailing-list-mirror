Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9811F859
	for <e@80x24.org>; Sun,  4 Sep 2016 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbcIDMLG (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 08:11:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34076 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbcIDMLF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 08:11:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id v143so9208599wmv.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6tiWpb5AlGAy0e1yxw+/+1O7MXpwnCNbrj62pu0z3Wc=;
        b=eHf0B7+7LV9teWgmcPOSM0GbrXt5kVuueZKoll39f8ETxL2CE7Ej8+G/6XmDrLUvZ3
         ExvCg2b5c/utJCCkmoQtW6+9ZqEMrM8dfyKQEPzLysR8YcEzPSWIQ10PDZp/140XH+sl
         uc4CZgywoxTx0LSRLTD/xT/lSp+9j4+g18p5ljL7EhcQQcIxvyiUsHFVoM8tWj00AGpG
         9AZbBhnYTyEoF1D9T3HCMsQP0R2zt7PXtp63kn9uLbgsPrnUUPH5Ryfhgn6x57Sd+02r
         SWXB427+g/W1p1UFTYjn6QSWY7C2nwErOC70BCtVhozKfaI0xxD3WY5kL7v1xuneAK/T
         b6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6tiWpb5AlGAy0e1yxw+/+1O7MXpwnCNbrj62pu0z3Wc=;
        b=WvZ+T461VuAGZ0boDTwGCS3HmxhcQKB6RAnC+uCubHAKD6S9/ffwSofIQsycn5Ez5C
         L8U3yzYpTQa4rHyFMaKRzllsPq8ZLrWcT7/RvaDayhJBF23b2Yt3oC5tH8QEl5FoRQzg
         zR+0lIvCqkk0jKEnLRGh2qwy8qo859aeAxjl+TNkgU/zKQtIqKvUSxZ3i4efaC2EqTJT
         p2EbfQWiO2avSCmlDBYq87taaE67p5toqjh2id2peNfWJV0OIQ9Nlzd/Smv0RAOVlOiM
         CKf+YvBWhJj4s20BqhAdEEPNeGvoVZVb3gX7u01HUGhT/qzEzyEW9VOKf+3FmvTsoHLg
         cn5A==
X-Gm-Message-State: AE9vXwNj5LmB3nsJZnQwa9moRCHhn+v4Es9bCUyhjLpNgI0MIVTTbk+/FtRxvkw0yAUAeQ==
X-Received: by 10.28.214.130 with SMTP id n124mr10572107wmg.37.1472991054650;
        Sun, 04 Sep 2016 05:10:54 -0700 (PDT)
Received: from [192.168.1.26] (elm244.neoplus.adsl.tpnet.pl. [83.21.206.244])
        by smtp.googlemail.com with ESMTPSA id v137sm8458837wmf.3.2016.09.04.05.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2016 05:10:53 -0700 (PDT)
Subject: Re: [PATCH 1/6] git-gui: The term unified for remote in Japanese
To:     Satoshi Yasushima <s.yasushima@gmail.com>, git@vger.kernel.org
References: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <32ec2698-7730-a088-6a76-ec6f2d379987@gmail.com>
Date:   Sun, 4 Sep 2016 14:10:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472913822-9088-1-git-send-email-s.yasushima@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.09.2016 o 16:43, Satoshi Yasushima pisze:

>  msgid "Tracking branch %s is not a branch in the remote repository."
> -msgstr "トラッキング・ブランチ %s は遠隔リポジトリのブランチではありません。"
> +msgstr ""

What for is the above part of change (empty string)?

> +"トラッキング・ブランチ %s はリモートリポジトリのブランチではありません。"

-- 
Jakub Narębski

