Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123B41FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 13:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbcLJNlh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 08:41:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36664 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbcLJNlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 08:41:36 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so1894244wma.3
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=q5wh4YP9Q8a1yjLNzFncZnGUGZMP8mh2u/MTE2Glx90=;
        b=nlOIoV0W1kdE42L94KD6zz7ePalMCTLdPHAdrDLYyeCMVaJS42i94kYcxR+1EtXGOR
         RFvGxkbUADOGG51Fvj71HumJlinDt22rfHjfwLPyL7g2GVd2moNTcJ2kQpSOMn98DSxR
         J1vWOvsPGpWeQHMCl4E2diUCkdO6F2h1BMbgKQg6rbOwO22SFlis6+MFDa4et2zo37JI
         tsgoazQjE3OoCBx1h8Zs7p/oy5N0MbQ9O63N2g0tob7xSnHEOmHvCwqBhG40T+D6IkSR
         cqrjTVBw4vKNxNOYHGYef0Rp56xNCAXSQO7zvHNao8xqJ01nEegWlBr2bSbwEqtK9KLK
         6QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=q5wh4YP9Q8a1yjLNzFncZnGUGZMP8mh2u/MTE2Glx90=;
        b=QeXscr2B1Zb6xhigPW0PYVRpmyw6XQWpTpXN3Yr3Tng0L9491o+QQlBf+o341+6mOQ
         1BUB0mkutXxXKrvty5X+D94M8tkuFy8QyLYekSp+xpSeyWzn/a4xwg9wTzTVxp0Fvn52
         87Jw1i0H+ODYG9BtG5ap4EFskNnfKDRiRbME/R4uuTO02dDGN0L5v86Q8KGaEsGrRIm5
         9ZniTi9uBOoTjUzU5Z/8qpar8oN1DiSps14/ZR+1ZfJeYujyBChSSmKWRnDUqHMk88XY
         blAK92m1JFEPg/3e3cJcKigyXoHFzW/Y3sUZknptTbjEKA/bXt6iGklbAgi7vtmmKitY
         s0iQ==
X-Gm-Message-State: AKaTC00feBcqbmDIhQAwLsWaGCzhwFRKE09BC/gnYau6c7knSPked1nrOu93vd8wswVL6g==
X-Received: by 10.28.148.81 with SMTP id w78mr2410617wmd.42.1481377294780;
        Sat, 10 Dec 2016 05:41:34 -0800 (PST)
Received: from ?IPv6:2001:470:7bd6:1000::2? ([2001:470:7bd6:1000::2])
        by smtp.gmail.com with ESMTPSA id x5sm47610796wje.36.2016.12.10.05.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Dec 2016 05:41:34 -0800 (PST)
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned
 submodules
To:     stefanbeller@gmail.com
References: <20161208013814.4943-1-vi0oss@gmail.com>
Cc:     git@vger.kernel.org
From:   vi0oss <vi0oss@gmail.com>
Message-ID: <12000496-2191-2915-8a9e-fe7c314c5676@gmail.com>
Date:   Sat, 10 Dec 2016 16:41:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161208013814.4943-1-vi0oss@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/2016 04:38 AM, vi0oss@gmail.com wrote:
>      Third review: missing && in test fixed.
>      
Shall something more be done about this or just wait until the patch 
gets reviewed and integrated?
