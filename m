Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA341FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeCRVTt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 17:19:49 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:39132 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbeCRVTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 17:19:47 -0400
Received: by mail-wr0-f172.google.com with SMTP id c24so4819286wrc.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=thKVRecVUtUEhhp469T4OTiSARd1Fc33ZVksHe508C8=;
        b=W3cCB20WvABqQcLqz8mXXATJKvtN7IMK6p1BQ+nfFrP1g31ZlQpIj4CInWLiMmkoVP
         FCW7QVLl6x2oZ1hkJ2L0nHIgPJe23NjbYHufSdJiUKNh1rw3HZj6RrueK9beTz+CMlVg
         z71BvfOAKZEOfS5Qmv19UMQ41u12jd0X99zd17YqkLlx4Eh24518Ihuij/vNNOaD0zWE
         DhQ3Y4coqnTcmEelNlxLaDueuobQGj0iu9Gtq3XftjouV/cq8GCe4XmxIg8MDwnEECeN
         gyibP1QCSDJtcYSZCnLvp95jwJV3Z/YlDcptf1j12mEdu7m/wVsbmMhHsO2GiIXMbtAd
         0iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thKVRecVUtUEhhp469T4OTiSARd1Fc33ZVksHe508C8=;
        b=lQRz4RWK4g2msnHRDBAwhd0ieKMPvF442bCQXgQuCGcEhG3tOSA4d5xIKdwfz+0M0E
         eNvLsOsL9Iehym7uscOLo0BlunYu4jGSfy9aOUCbVGQsR/i/p1froITRPoRvzbr9SLRg
         1K5hJxFFkDO5mHH2Ysrexu++ArzO2YeLfTHgogd803oWleu+jDDCBTZmvLFzTMVm3p7o
         v4k/yO61g9PDXrDgiRn7QjceLd/zF6QIsngc432Hggy9yTUO2kityWeVIyiuV61W7IIh
         aKz5dKcW9PLyC54OEAvydXUsZdjo7tm6KVi/wwZiud8Af6gyOYuHfr6hHdQCh+dyMuNj
         yR/A==
X-Gm-Message-State: AElRT7HhtGLFVUxyz/q0SAIrveCWcxnozkKPX+7ctCL5R49PG25a3Vtm
        iuUBCMSVkkcuropEl017UglYgA==
X-Google-Smtp-Source: AG47ELvx7UtT8pdsLXYkdrvYpT8P6nSxpejFCcQA5PRRvb9PH6nCA1b4VGUS91XuOLbUMSWJA2AVcg==
X-Received: by 10.223.133.209 with SMTP id 17mr7413729wru.143.1521407985988;
        Sun, 18 Mar 2018 14:19:45 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:4054:72ef:d863:f2b7? ([2001:a62:81d:ab01:4054:72ef:d863:f2b7])
        by smtp.googlemail.com with ESMTPSA id w134sm11001016wmd.45.2018.03.18.14.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 14:19:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] git-svn: --author-prog improvements
To:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <20180304112237.19254-1-asheiduk@gmail.co>
 <20180311135835.9775-1-asheiduk@gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <bf90b92a-d982-df89-7b01-b4a233181cb2@gmail.com>
Date:   Sun, 18 Mar 2018 22:19:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180311135835.9775-1-asheiduk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No comments on this one?
