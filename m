Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF5F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 03:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJKKpO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 06:45:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53417 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbeJKKpO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Oct 2018 06:45:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D92321FA4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 23:20:02 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute1.internal (MEProxy); Wed, 10 Oct 2018 23:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sb.org; h=
        message-id:from:to:mime-version:content-transfer-encoding
        :content-type:date:subject; s=fm2; bh=gBlFy02Dkl7GlxDlKD4oeXVsnP
        48LiUpJII90NoJCEk=; b=KWRkw6ghz0ZI2VejGcErKJJkP4woxEoQoiifcUu3o7
        nJXaFk9wfFAJeC2O/RFYeWCJj9guQk/I6vIyBGM/yY0MUsrKzXhqkCO7cq1K63py
        PBS5hDZRmfcUGHdf1V2Ay1HVJGzHzJNbXBqLTW1zkNfMdSdQ/ViteIKm6gxl1GZR
        yoRysBa8ATnJ0eBuKoahvFWAu9YajkPlz+9a7mH/frxXMvXiGFLdPyQhWYPhMqVK
        o5wN5wuSV/3zdChrilq32KJ5oh5s6v/W2xiBbYTHdf9y2WxRcAKsiSOQXa/ndeiF
        71TJqAz1IGgQqqDr1Edulv5abMBoqLJwWXP2/E2/kevg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gBlFy0
        2Dkl7GlxDlKD4oeXVsnP48LiUpJII90NoJCEk=; b=LK75LdrmwY1zipN6JKqXTv
        D36CMG6j/5DWwz1Fnt7aFR6wE6NIGzXbtqHQ7CtBug9vjEUROqj0psjohHfdxaMj
        sk2r9yuzavV4JlatjAIiPcCtZVeE++KjHtQLB5WHRazIEBmmmyaMLGfjahJueyx5
        TnE3uyFm8+2G3qzE0uAE6QiF0xUvROBjyKza+5HlNnEp0GW/pBk0kBHm5X3Vn5sY
        Qrcf6lDSol8fUm/xB2aGLVoG+1U4ZeSIgHcdi2igcj1Mv9qiaiwiKz7AgXgRurrg
        p84yNpHFkPporHF5pEq+We3/aHiHtO7I9pXkS2t3ga5J+tL7qS/yppRTYBENDmJg
        ==
X-ME-Sender: <xms:YsG-W0REFsQ96Zm5EqI5DaaQW3naQNFiOMhT-22nHqvLVGtJotmNAg>
X-ME-Proxy: <xmx:YsG-W-vqGQQPUSzkGy95aMhghdsnEsfo7z7eZ-phps8NOir-2reFZQ>
    <xmx:YsG-Wz6-WqjuwRdzROTObDTzJzbQNnv1wFHFfg0CVqUBhrlvcC0b0w>
    <xmx:YsG-Wwr3iDXdyuZHgznTPCTH2UmaTrhsPWMQJXZPIoXqwSybh9ns2A>
    <xmx:YsG-W_eaj5kisyTtt4-66myPL9DP_UJcblgN0FC5PgMyTgkMI6PbYA>
    <xmx:YsG-W8Kf53ZI5Ldy5sLM2MZ0jmZtaWJ03-3IJGw4hCfh2BpBMYzjJg>
    <xmx:YsG-W5pHsvtRRT933dKHxeALwNZyEv8TywRRHXXbmbDbAhjacNtrFg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id C8DB941D7; Wed, 10 Oct 2018 23:20:01 -0400 (EDT)
Message-Id: <1539228001.1758106.1538051752.20CB6C51@webmail.messagingengine.com>
From:   Lily Ballard <lily@sb.org>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-6804a824
Date:   Wed, 10 Oct 2018 20:20:01 -0700
Subject: Bug: manpage for `git ls-files` uses <file> instead of <pathspec>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git ls-files` takes zero or more <pathspec>s, but the manpage (and the `-h=
` output) lists it as taking zero or more <file>s instead. This is confusin=
g as <file> is documented in `man git` as a filename, without any magic. Bu=
t a pathspec has a lot of special handling. The gitglossary entry for paths=
pec does say that `git ls-files` takes it, but nobody is going to know to l=
ook there in the first place if they look at `git ls-files` and see that it=
 takes files.=20

I haven=E2=80=99t checked any other commands that the glossary lists as tak=
ing pathspecs (except `git add`, which does properly list it as taking path=
specs), so I don=E2=80=99t know if any of the other commands incorrectly li=
st themselves as taking files when they take pathspecs.

git version 2.19.1.

-Lily Ballard
