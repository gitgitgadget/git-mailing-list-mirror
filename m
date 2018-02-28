Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB421F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935093AbeB1Vb1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:31:27 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:38812 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934866AbeB1VbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:31:25 -0500
Received: by mail-lf0-f49.google.com with SMTP id i80so5716251lfg.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JfLy1q5XnnxH9sfd2RMwVvNxuEUaqnFFvVDX/fP6OXY=;
        b=Zvuh56jeoYzA5/4ts5tmmV21zVVXXxdZGGYUrUZ4HUMSkYAuGsQ238CR0wC+3MIFSY
         Xn9nhymqk2RFSsXjkF5QAwopmPdaWMGW4tG208OsErb34BMVstg53CnyChQPdmR579IN
         B8mFOAv/suHoyZaHt0ygWRlpGHiME4DHM56KVs9v14QDcH6Yxfk7FiEeuRGUNE3At7Cr
         DC7jHqhBHwWYqD7uWRCRUZC4HJKtTy+3jGuSqHgGsqET/CPiuRGracnLG8528Su7EAKT
         na8OeEzXHDLSqmAwlKR9QxWfXX3rYaxjpm1X1gspxzNo8RT523wnG3ZyJYm2zwCPmLlu
         vztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JfLy1q5XnnxH9sfd2RMwVvNxuEUaqnFFvVDX/fP6OXY=;
        b=DFXjCcBLGxKmY91cugEu3/lffDX8pWn7ZFxPxIMTNVAnG34vNiTqdLEWE/fKf0NFjD
         CksiPI7gPV9CVWSyO7qXLqKOgb4YW7Yk3u3HRxTYa/g/6EVzUEFadnmVwq6cVlmcQrWM
         YW7KjNF/WocfVrMEm9NhAT+/p6Q7P+YdcE3MJRS5Jie4wSr40bcbOhELfrXRDD09ic0c
         cIMBUQ2D7Qzh0eSLAwwHWTnb7x2J1A7FhiRXF2021J5KhPCAmQ0cd3gh3rGjzGS6LU2y
         ERW7JUvF9AWrMotBnkKptZWnRQhBZQGsHU+gyHLJJEGHVFsk4jnO6Pu7xBG50BuMILxX
         rLbw==
X-Gm-Message-State: APf1xPDtEqa0asWu+PvbGcuQTKYAWTMFp1BjUcp+niWV8GCkPSjENS2D
        C25L7kwVJAyO4ZFfrF90nDbdNl2W
X-Google-Smtp-Source: AG47ELu8fnLy4Pcpwwq1tCiZC95SgfosGQYhQvBdBZIVLQLn6tE/yGkwA63RqfhVtQwS7TOT/3zIzA==
X-Received: by 10.25.92.1 with SMTP id q1mr14771932lfb.126.1519853483245;
        Wed, 28 Feb 2018 13:31:23 -0800 (PST)
Received: from [192.168.20.21] ([89.113.128.32])
        by smtp.gmail.com with ESMTPSA id s12sm547979ljs.92.2018.02.28.13.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 13:31:22 -0800 (PST)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Obsolete instruction in SubmittingPatches?
Message-ID: <48b5c506-6882-81e2-35f6-7d040bfc6017@gmail.com>
Date:   Thu, 1 Mar 2018 00:31:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It seems to me that this part of Documentation/SubmittingPatches is
not actual nowadays:

  After the list reached a consensus that it is a good idea to apply the
  patch, re-send it with "To:" set to the maintainer{1} and "cc:" the
  list{2} for inclusion.

From what I observe in the mailing list, most patches are sent with
"To:" set to mailing list (or re-sent with increasing version) , as per
previous paragraph in the guidelines [1].  Then, after the topic is
reviewed and the [PATCH v<last>] series receives a thumbs up from a
number of people, the maintainer--Junio C Hamano--replies with an email
containing something along the lines of "This change is in good
shape.  Thanks, will queue.", which makes me think that the re-send
is not actually needed.

Is this part of guidelines obsolete, or am I not understanding this
correctly?

[1] "Send your patch with "To:" set to the mailing list, with "cc:"
    listing people who are involved in the area you are touching"

--
Best regards, Andrei Rybak
