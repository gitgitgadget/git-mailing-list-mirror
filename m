Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AA01F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFDUli (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:41:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46993 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:41:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so13369902pfm.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmk0pgI6xZD6hKZnFonkP2jLIFbIg6J0TbkAmkfQEVA=;
        b=JWKcXY0bmT1F0Sx+qwLuHdTIvghS+GLKSnYgUUTk+/Lj8N+2rZrVnEyfpVg8EOFb8D
         +Y+LExXEIJRihfNwGb8uMzcfPvXoXU3OKwHoReVXcUAWV/FvYg/9ttnbSvS7gLSq8ggg
         quenWFxsHMfdv4CEF+Jz4BXgeSqeWQtBx5bbz5V6lMQzG6US8VbdjQUfq39W43gXex30
         9f+/Df9alkdJCwl88nppcNiONm8Pg2vLbJbZmny5xhMMkYNqxqzfJBaHFf4JYtgFlo1y
         jhhC7XdP+n1UKbn9zy/9WMle0UFp/4R+C25ehdBdQQiWo/3ZnmEKrL48tLRLcb2nWGDk
         DVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmk0pgI6xZD6hKZnFonkP2jLIFbIg6J0TbkAmkfQEVA=;
        b=pmXzWEDFWW+YTUYkj7MxBFMy4zIQaAk6CjeIvL6BgzzUSh1b48+pHMol7oejPpeCHg
         V6yctHzKBbylLN5YnaFXAP6QTRayz598rBM8jZD83dQTbmI5t7GbUj7Ps73oJxy0Bvvj
         MiwqjNk+agLgDY5L3G94buvDhOdeRbgLpZeBVXk3VS1QbLcGu3n993cCPm9EOmLn42x2
         J4bdDWtRrArMq/Dk2pIwWWGgXtrMeLsbaJGRsRa2tOksrwKghWvd1II6u4okl6OEjuR9
         vbKZQDgrvuY6qD5YUaLiV8b/ZQTjYDUzbhOsOh+zJULMoyO5KSC+kTPLlc7bPFZA71Mp
         b74g==
X-Gm-Message-State: APjAAAXQEUEqpHo1EXnzTmlpQyb3Ljiz+DlRcI2kXDs5B8DCDrhrSbBE
        tP5gI60KF7StWsjY94H+mbp9hA==
X-Google-Smtp-Source: APXvYqxs5YNGNK/83R45RvDIsO39WIfyXSPmSTIEBUrDTYCTYtWTIphiMgoizP+jPTKn2B6n9qGDPw==
X-Received: by 2002:a62:1ec1:: with SMTP id e184mr41141546pfe.185.1559680896413;
        Tue, 04 Jun 2019 13:41:36 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id 128sm20215802pff.16.2019.06.04.13.41.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:41:35 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
From:   Barret Rhoden <brho@google.com>
To:     Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
 <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
 <80a23fb8-5ea8-dba3-ce7d-f6f5d4c02310@gmail.com>
 <9ab619bb-9deb-4e57-a3ad-9e996425b783@google.com>
Message-ID: <09bc8c7a-bab5-7cdb-75dc-f7c45a4dbaf8@google.com>
Date:   Tue, 4 Jun 2019 16:41:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9ab619bb-9deb-4e57-a3ad-9e996425b783@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 6/4/19 12:38 PM, Barret Rhoden wrote:
> I'll try to come up with a test, independent of my blame-ignore work, 
> that can get in that block.

I have a test that covers blame_coalesce(), which works both with and 
without my blame-ignore commit that started this thread.

However, the only thing we are really testing is that git blame didn't 
crash.  There is no detectable change to the output.  AFAIK, 
blame_coalesce() is a performance enhancement.

If you all are interested in that sort of test, I can put it in a patch. 
  Right now, I have this (below).

Thanks,

Barret


diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index c92a47b6d5b1..4c652b85a55b 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -275,4 +275,32 @@ test_expect_success 'blame file with CRLF 
core.autocrlf=true' '
  	grep "A U Thor" actual
  '

+test_expect_success 'blame coalesce' '
+	cat >giraffe <<-\EOF &&
+	ABC
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "original file" &&
+	
+	cat >giraffe <<-\EOF &&
+	ABC
+	XXX
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "interior XXX line" &&
+	
+	cat >giraffe <<-\EOF &&
+	ABC
+	DEF
+	EOF
+	git add giraffe &&
+	git commit -m "same contents as original" &&
+
+	git blame giraffe &&
+
+	true
+'
+
  test_done

