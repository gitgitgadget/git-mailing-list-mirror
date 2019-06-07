Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22B01F462
	for <e@80x24.org>; Fri,  7 Jun 2019 04:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbfFGEMP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 00:12:15 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36068 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfFGEMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 00:12:15 -0400
Received: by mail-pl1-f170.google.com with SMTP id d21so305087plr.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZZ3KJjQ0bK3Wc0leQ7oubPDfRoWVATFuWp7sKEox2g=;
        b=j9AFLVyZEUJrPxLTuJk35BBCBADWZoRhDTztk3dsO1sZCAv3H+bXUZgE0EdjZ4e6vU
         oe1zTmIlj1dKva5pDpwopIXbxiUITK5wN9g6tt9f4DK72ZEi+k5B2vqz8DG816oD4Kw2
         HuCLxdvptdUDLKw0qIRdak04EapHRqh+rCyHAFPzcsKki6qISxrLQ7Vzd9jm07t8T44Y
         hbY8GnqptLLpIXOYoimOElm95ZUHjuAX/1XHQjmKMWDuUpqgYeQoVDZIeszRGQjigHfF
         dW07rCaP4tcowo2ZNNlm/QqhYopUmZHA1A4FSOIIOX0ocWhmZcSxxNFZwKqq/ZvO7IAa
         jCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZZ3KJjQ0bK3Wc0leQ7oubPDfRoWVATFuWp7sKEox2g=;
        b=ewHr7CIRKncx+8cIcn6YEqwi9YVuiMqY3/v3YXlcf522qpWvOksZoOW6J0UAc68ZYY
         4jVB8BsyYydsuO3GFum5fHPI/jYoaGburrVO7djxXls9SY2SUbD05t1j0bq+upRLaswg
         MJs4rdN6SE9w3los3cugC1merNbHSA4B111bA3PhHUKvrAn8WDXyMTMYlfcurgkuzWPA
         FzsM/q8FLSCoRVTfqijzc/NDLDeR7SUwvmBUwhuIirLEaZNbsH0dPWGfV+rJnpbB4WlF
         U0sYiVAbY7m3U5Aypq754gme6ehm87AJ9wAs+dHAPHlchRtB/n3DlyKAHDTMKi8xs/cM
         xyYw==
X-Gm-Message-State: APjAAAUfUnPIU8CytlhX/TgoHAOj5rgtrq7HcoIARW0/8WqLPNeTW+uJ
        yvrTstWwhLCbujRPIpLFfYA=
X-Google-Smtp-Source: APXvYqxJpswC8cXng4wzC+NL7Brc+MDGwuOb4Ix4niyqMCTlVqfKtboJmxfYk5O7k2hUo0m7y4U/pA==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr34661749plo.312.1559880734443;
        Thu, 06 Jun 2019 21:12:14 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3103:7668:4d84:bbb9:9322:5fe1])
        by smtp.gmail.com with ESMTPSA id r4sm543307pjd.25.2019.06.06.21.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 21:12:13 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        matheus.bernardino@usp.br, newren@gmail.com,
        olyatelezhnaya@gmail.com, t.gummerer@gmail.com
Subject: [GSoC] Blogging with Rohit
Date:   Fri,  7 Jun 2019 09:40:06 +0530
Message-Id: <20190607041006.30182-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
References: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Everyone!

Here is a blog[1] update about my last week. I'll send my first patch
within this week. Be sure to check this blog to know about what
interesting happened during the last week ;)

Thanks
Rohit

[1]: https://rashiwal.me/2019/ignoring-spaces/

