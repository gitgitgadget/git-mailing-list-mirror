Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19AAC20899
	for <e@80x24.org>; Wed,  2 Aug 2017 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbdHBMW1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 08:22:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35398 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdHBMW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 08:22:26 -0400
Received: by mail-io0-f193.google.com with SMTP id f1so3596216ioj.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Wo+0FGe6Ryh/BdEO4NeyFziFcXM85domqB7x68bIbM0=;
        b=Nq8eooFsqbvpgw7BhuT2D1FFxXp4YzZkqI1XwsbYj9h+DaMSNy0mDcZaDLl8KERXxv
         9mTfPxM6kZJVnuWNyNtJmxAG+7m3JX5FpkAK5n68Lpp33VkQ6O+n5YvtSmfrQi61H9TJ
         XG1cL4ywQsCm63sgnlOVI1wttjHQ40SNMSpqWDUUsB3/n+RDkQOd2yrmBTopPwLV8fkl
         s4u2KktCwoLdvVFaz/Pl0CF/KiWogGxdyvPUEXqXu2en4KI6wiQAp3Shh7sfbEq84BLv
         Uj5iXJ4JVJQIjPiQxTw17g499YtWnneGzTTowQ4LnuYya47iA+kjSHrXPYS4HMSuGCh9
         JriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Wo+0FGe6Ryh/BdEO4NeyFziFcXM85domqB7x68bIbM0=;
        b=D0mp7tHNXyhXRHav/+GVxpdpj0JUBhytK68ZZDd8fY1szVvywKRZhrDjwarL2UTT6O
         mI9R9d/urvo6MoZk7HhknH+t5elV+Uf7kMvx8TEpwzb/1yvMnOJT5Kl9Upy2Ad3RCaxt
         gTe+R3vfXFblyh4DtExTi/nfzY/udMbI5Vq0x+0DYO8iBP7JFql9ByNf/1CVkmnmX4c2
         JqumMe55u3LwzLc5sqyI2yvZWEct9LVmNWkRquOZcQMcIvfGirba1jY+j3vXmzhw7MVG
         kzyp5/Fzvk6Rv/S+3FXlIGflzOP6oPgQITC8zQVuLaI6n3t/ZBRcpqsfzRVfloyIBZnT
         q1zg==
X-Gm-Message-State: AIVw110qHIGv2bRDNzlSj9wBeAACyzSyiiXyEbD0IoL+1sDExMYsdFiU
        UOGRurhUNWVzJQ==
X-Received: by 10.107.130.33 with SMTP id e33mr25568541iod.322.1501676545595;
        Wed, 02 Aug 2017 05:22:25 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id b83sm14132387iod.35.2017.08.02.05.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 05:22:25 -0700 (PDT)
Message-ID: <1501676577.1957.4.camel@gmail.com>
Subject: Re: [RFC] The correct and consistent alternative to quote a
 command ?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
         <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
         <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
         <1501603171.1671.8.camel@gmail.com>
         <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 02 Aug 2017 17:52:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-08-01 at 10:38 -0700, Stefan Beller wrote:
> On Tue, Aug 1, 2017 at 8:59 AM, Kaartic Sivaraam wrote:
> > I assume you mean the consistency in quoting i.e., you're expecting the
> > patch to use (") instead of (') for quoting. Correct me, if I'm wrong.
> 
> Actually I did not imply any expectation on the outcome, because I
> do not know what the consistency end game looks like for this issue.
> 
> So maybe we'd want to go with the currently most used way?
On scanning through Documentation/SubmittingPatches, I saw that most of
the commands were quoted using double quotes and chose to use it for
this patch. I'm not sure if it's the right one to use.

Changing the subject of this mail; hoping some one who has thoughts
about this would dive-in.

> (Are there only three? (a) with dash, (b) with single quotes and
> (c) with double quotes?)

-- 
Kaartic
