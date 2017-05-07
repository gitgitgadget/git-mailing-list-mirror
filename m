Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359CE1F71C
	for <e@80x24.org>; Sun,  7 May 2017 23:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdEGXMa (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 19:12:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36810 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdEGXMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 19:12:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so7554649pfd.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=O93QAZzWRI4gWoCv9TecK9jJNErWhHpD9btqW7x1nEY=;
        b=BmV9FiaExe1dquyNPDDehrNlZPEAZwi17jPSF9+Ntmbp5yNLX9sSaeyfL9i3QefbsS
         aIMchcpji3Axj0wQuNoeYCur/FeSAh6qIuSiWJVa8C0uBRnfq5IPZ9uoQTg6TzrKAt6Y
         W6MorIyjGmxDf1/yZIdF57ZYKQwCJFdO6b1ipmYfglntz68eSgsnIs9qJGyD2cy+5laX
         0bXKoO7l7UtuhZOrQy6tOmsTQSh8jk6Rp2OCaNCsCGHhzfa7ZRcE9++bxiQjtWjC0zqn
         HdFF3o3kKv/7OeXk4OJ+o8qXvPPQEapK2mpw5NgVI3BWHH32OebDD88tdrOshn0e65fX
         /lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=O93QAZzWRI4gWoCv9TecK9jJNErWhHpD9btqW7x1nEY=;
        b=Ksyp0TV/kPaca8nM51+8aCHGLOHBcrE8kgdrfoUcaT5YfPqgsOyIKTPmLlEkaXEjl3
         2zUg3seU2WQWn9iLvImNEB4a+sMM02FxbJt9/DvBRAqN6usdv0Iv78ahezxcu6ZAIoqM
         IKOaTsLWJuM5Bm9JnIABUNnB3W+9QyZx7zYLjwNBp3U8f0v0X6Ej3d5uSNk0E3BLP4Wi
         j0peqnx4ZXn/03u5hJsEn8Kyca8Jmy5kYga0dKuVArUYvcz94Xt37J/tY579xkFcMtIr
         levK9SlK1Z8J0ZjiSFBzwAOl5oFfb92GGdy8DDN//S25T1YiSlbVSQdu9iqD9HTQtR+K
         tz8w==
X-Gm-Message-State: AN3rC/5QqqAYGmOdana5ZcDf/Q/KQ+tIcPXBJpQwNPYZ3SJEV/nRtYf2
        cxUqoNeySg22zQ==
X-Received: by 10.84.141.3 with SMTP id 3mr72861489plu.8.1494198749548;
        Sun, 07 May 2017 16:12:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id 66sm14306647pgd.47.2017.05.07.16.12.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 16:12:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [Announce] delaying 2.13 final by a few days
Date:   Mon, 08 May 2017 08:12:28 +0900
Message-ID: <xmqq1ss0dzxf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As -rc2 was delayed for a few days, I'd like to delay the release of
the final 2.13 (which was originally scheduled on 8th) by a few days.
For one thing that would give translaors a bit more time to update
the message strings.

Thanks.
