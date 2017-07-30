Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C88208A0
	for <e@80x24.org>; Sun, 30 Jul 2017 16:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbdG3QQs (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 12:16:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35364 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754409AbdG3QQr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 12:16:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so24230929pfq.2
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=DQlXOdAKbRu3SZ9EEJ3WvjoD/qeFsunxVo5SkKXvrfI=;
        b=pDc4aH4m24WkBGRTQT/45xGrGxL3CRNfCruknbjRNWBGXFyFBHZNtiIHC2lEbdcECF
         McWmfMlk4ZWJ8yT5xF5lgOtalr0Q0+cgWzmthbAB/GMn9elK2AlYtN2ceWrHxpb05ihm
         eq1L4vB+u/PCXf0m2Gx+s2Q1PkTf1w8/E1MgViElbP9b+V47Or5vR6FQU3ORPBXyBCk/
         yJB8ksKJnsQwsQZuZb+lBc/HNLGwo/XvmBcDzl64tycA+nd7GmKNJrTSqVMCaNp+nHux
         doYWI0+3i7T5OUXL0bvOwOW0YPOpdSJJGCei0nrnRWUjdJM5CF5qSWLjaO40D+2rYTO3
         ZSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=DQlXOdAKbRu3SZ9EEJ3WvjoD/qeFsunxVo5SkKXvrfI=;
        b=GOV0B4TAcnf4KzQZCbasGeuy8ERYvqALX5WyHwcFNzHA3NWr11Zaz/6ubOKV25EMrQ
         k6M4P9I9Mm1UHS/U4C6KgO+GrEBoq+aVSQlOlprQbZZizFqCzL/EFXinmbj++icQn5Vw
         5F3otXHObOqrOYSzLv8VKyGZcoX2xBJQi2XnkBKLXCJX/oTyKi52HWXIo85wSFFECrjd
         ViAVeLtoBhX8vu6pn25lyuKmXyWLvVV4exxdzNmRDkSxFQX/36im2q+0gOBSExoukNyT
         kFKCITYTOltQiIinpTP8DBXW/vYvnC0kAk2H0zriNxksLa5X0cksfSMF99izS7g60vCF
         P4iA==
X-Gm-Message-State: AIVw110PRNOlt7whmWg6uRcC9hzXupt0OvdYpdIFgi3hMqn5miqdpPyM
        4VK0rLhhXba6vA==
X-Received: by 10.84.232.143 with SMTP id i15mr14386733plk.248.1501431406444;
        Sun, 30 Jul 2017 09:16:46 -0700 (PDT)
Received: from unique-pc ([117.209.135.24])
        by smtp.googlemail.com with ESMTPSA id e123sm45829195pfa.96.2017.07.30.09.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 09:16:46 -0700 (PDT)
Message-ID: <1501431431.31112.9.camel@gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>, gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
References: <20170730110921.11805-1-kaarticsivaraam91196@gmail.com>
         <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 30 Jul 2017 21:47:11 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-07-30 at 15:49 +0100, Philip Oakley wrote:
> From: "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
> 
> minor nit: It's nice, for these single character changes, to give a clue in 
> the commit message as to what to look for.
> 
> E.g.
> 
> Quote the command, and remove duplicated space character
> 
Fixed it. Will remember this in future. :)

-- 
Kaartic
