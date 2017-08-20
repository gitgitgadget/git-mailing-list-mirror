Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33300208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 10:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbdHTKS7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 06:18:59 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33280 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdHTKS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 06:18:58 -0400
Received: by mail-pg0-f67.google.com with SMTP id n4so4973278pgn.0
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=UrbbLLND2ZPl1wIsG/SOy+XIgTND43uQ7Me5gUP5Q+w=;
        b=B3Gt0oBHUWhula/01vakfDtDRImUB3eEUI2U6xhKN501xFWB31/jDU0nmBkkCyLK6a
         2E3wVPFA6s4oNlyGL+MNLJjw2c//mwXllHzE6PA1d4XinXW/WvYs8pvpzzPGC57tglen
         E1Ka6A+xFWG/IPIlzSodXkq3OpPU9wUitoSB+biSFXXipX+PVl2y9fnCrJvUNYam3WrY
         3wRAmqDsi1pm+g8DyhQVISGu4X3U1GQ7JsZloA++FP/38Xn3Au8oKY5nsc80RUKBKyxV
         VfCL6gj2IJUhqZKrXaNByPmuJelAOe4juPB2mWaprrzJG6hovF4WYcVbD9eNnspdgVuW
         rHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=UrbbLLND2ZPl1wIsG/SOy+XIgTND43uQ7Me5gUP5Q+w=;
        b=U4zJfrftbweulwwh63SfGR66f1dsPokNHvbtiEPnkAhc83wPNfuVz0WSFHsUAS0K5M
         ehcikNx1IEq1Mi2c5HGfWtjDzHDf6rvo9l3jCaojIREU/ubdYSoMBdQ6HlLXMBbRFF0l
         V22NK1vPuZqQj+pmZmfS+8vR4K4RGr8vTAMWNE9rSk1YWeAQYeaxPGufzWtt4NWsc5fH
         AYfxUNGw/xckKF+9kQjzrmwDZ0wLPnXgukVF17o8IFQJageCSUUtbRTwFEO6BMhakwP7
         hyUAzc12CVATUjweMDM6K8MXCjVEpQb6H52SN8z1bP7ZC5DL02iKvlrf7zS8ooLldT1C
         WFfA==
X-Gm-Message-State: AHYfb5hZ0TSyasvySknqz0tNIPDf+spEwpR4iE2MVK7qGE+9fY9H1pqm
        sqXbTUvjTgnv5A==
X-Received: by 10.99.51.140 with SMTP id z134mr9181955pgz.247.1503224337934;
        Sun, 20 Aug 2017 03:18:57 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.googlemail.com with ESMTPSA id u186sm18398785pfu.82.2017.08.20.03.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Aug 2017 03:18:57 -0700 (PDT)
Message-ID: <1503224389.2116.5.camel@gmail.com>
Subject: Re: Please fix the useless email prompts
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
In-Reply-To: <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
         <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
         <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
         <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 20 Aug 2017 15:49:49 +0530
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

On Sun, 2017-08-20 at 05:18 -0400, Jeff King wrote:
> Ironically, Git used to behave as you requested in 2005. After being
> bombarded with complaints about how Git was too lax in creating commits
> with bogus ident information, we changed it in 2012. So I don't think
> "it's 2017" carries any weight as an argument.
> 

I would like to go with the "don't create commits with bogus
ident". "bogus idents" seem to go against the notion of a "content
tracker" which should *help* identifying the user who was the reason
behind the change. It shoudln't encourage users to create "anonymous
changes". Thus an "anonymous user" seems to completely obscure the
meaning of a "content tracker", at least in my opinion

Moreover, there's no tool that can satisfy *all* of it's users because
Humans are so diverse in their thoughts and behaviour.


-- 
Kaartic
