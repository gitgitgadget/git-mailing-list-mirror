Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1443E1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 22:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfBFWSF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 17:18:05 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36483 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 17:18:05 -0500
Received: by mail-wm1-f50.google.com with SMTP id p6so4591434wmc.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 14:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNrfCfrjJNKeyDKd0nZdhSBxAbSzunU2uYWePV+nwl4=;
        b=aJ9uhYzmdnXYGkk5I4TY7HN29xEFRv2uWs5KZTceNo2Rsym2vibK/9J28FM+2bWYmo
         1N6IdvRfyhKf+Ija7XVm1j4QELLPZhn0cdz0nrqWlt2ufNR37dush+mdT7MYedo6+SuL
         3uDPyYMt8fH8OATqDi5ZibDLOilQ5YCwf9oyVjkS71Xw4znLmUETcCPHwlZ3mN/OrzQJ
         Nj5OT04GRqD4ShKHecmWYTkbUdhLd9kV/4DwE5ro1mU1VaSjh7DU0o0QhzeigN4AhToP
         1RSvTFj8zdfhvN84RwceqXEqS2bP60lK7g9dLGGgmlei92ei+pVn6TYeVP6UmgmxtG8G
         10pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNrfCfrjJNKeyDKd0nZdhSBxAbSzunU2uYWePV+nwl4=;
        b=S0HuxtBj5p2GWtPc7wlcN0aq15p0fDsGou66861fJsgYVETAfT/hj+fyvFY4Jh99+X
         G3oycegJ8G74hBWUxWTwGD1ddW0EwFHkIPMKjTZb1k4FHLFU0W5llF/sh19jFovAdQFS
         cqcbxo8ZF29W+ahHOdl8VtwRdkg8A/BKfU3RbR+bsQ8s8Q3KfBFBq45zgX/aHJcIwrR4
         9S0+IQZZTduuU3o5bOaSG4meCZtynSADfaoMhbqxW1GeHzAcOMvwT+ntEKEvqxe4nnzI
         q3UGhktXADXpUOIEFAbc0BcHet22wnbenoenMhRwYh8xXLJdz1x32DZJWmlva7+grnxp
         97lA==
X-Gm-Message-State: AHQUAub6A7iOM9YwXUHw7s38y98jQkxhS7XPq0VR8wyf5ZBmzE3J/MCR
        mfzdLXyrQd55hLmjiuCOW8A=
X-Google-Smtp-Source: AHgI3IZ1grzxuziStZ2t6XHPy2F4Obb1KAYazWDBrE+VqOlV0+PaQ3hGzyANz8lSHSuROqUnmim+8w==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr4944141wma.85.1549491483644;
        Wed, 06 Feb 2019 14:18:03 -0800 (PST)
Received: from evil (host201-92-dynamic.60-82-r.retail.telecomitalia.it. [82.60.92.201])
        by smtp.gmail.com with ESMTPSA id 129sm35235727wmd.18.2019.02.06.14.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 14:18:03 -0800 (PST)
From:   "=?UTF-8?q?Giuseppe=20Crin=C3=B2?=" <giuscri@gmail.com>
X-Google-Original-From: =?UTF-8?q?Giuseppe=20Crin=C3=B2?= <g@evil.localdomain>
Received: by evil (sSMTP sendmail emulation); Wed, 06 Feb 2019 23:17:59 +0100
To:     tboegi@web.de
Cc:     angelomelonas@gmail.com, git@vger.kernel.org
Subject: Re: Possible minor bug in Git
Date:   Wed,  6 Feb 2019 23:17:59 +0100
Message-Id: <20190206221759.338-1-g@evil.localdomain>
X-Mailer: git-send-email 2.20.1.390.gb5101f9
In-Reply-To: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4>
References: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wanted to have a look at the bug, and I can correctly reproduce it using version 2.20.1.windows.1.

To start to even think of fixing this bug I need to build the source for Windows, but I got lost on how to do that.

Is it correct that I should cross-compile from a POSIX system (GNU/Linux), using x86_64-w64-mingw32-gcc and Gnulib to produce a static executable?

Am I missing something? How does people here build for Windows?

Giuseppe
