Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B0420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeLMNXB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:23:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51532 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeLMNXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:23:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so2342791wmh.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 05:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0uKyTMIvdd+9eziAXMrm6kIMdd9nRL5NhA+Fr5BzGRc=;
        b=hlj+slNBKh5YBN+RS8GyPnFzHQv3k4u6Xz9U+ZSfJSxDV2s8CM5dVr0ttvhE0hrIgs
         Uhz32XQ/PvudezHghxsiyst1pTJvVC8HLbCiJz20gdAVt1iti7OwB5yr+I3a7HJaIZ5s
         Lh8J5tCieDhSXYa0eIX+A3egbS7IL7lDdqWfSD/xy0rG2X3bui4pGOlecKGFzTaMhYTw
         S13uju3DapqxVDP2qh88jgYjUcV5wnkc3037iuIPln9W3YKWPMp0ZO2+RROHe27NoxH3
         HHpvxG/IYbigcRF7Z2y8gZdhQHanq1/3ZpdudnlYD6vQ4mylMkQd6vEHZ9LV1qIt4OvO
         ce7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0uKyTMIvdd+9eziAXMrm6kIMdd9nRL5NhA+Fr5BzGRc=;
        b=DMdf+Gx9qJIkC8Wu19xRb4JMaijI9hYyvMY992K1t4oEwjkKEz40MSnKxi41Q3sywf
         6UzHFzmsJoIDpn31K26YyJ/9NEbEHZiM7UzM1fr9Ht5tWE03pCbYujaHWJ7DB/xEnKbh
         U/+GeGnXvxcIEwbvwcSMhN+EuX2kNvVjyMjWmRPSlJ77HxTAqQetzpuVjgY+WnftYEIm
         rzZkyB+9BFIylVZ6u98Bqe2uQSrTGdTBWHOTUZcbnqyJG0goYAbsYU/MPqMo8/v9OKZK
         lnun49XX/p1tVf0hxhW5DPEH6nMdEzoJlzQ1/qHdR0gO7o4wnpCs2xAsJnp8P2pVmV+g
         GOKA==
X-Gm-Message-State: AA+aEWbrgUNWm+JXJbDWX0feuI5f7hLC1zw9d+QeUTAI83um9gvIP3NJ
        R+q6j9VH2hR46xdsCUjPPxmHXhhD
X-Google-Smtp-Source: AFSGD/WhmKKCGxBJk2wx/PPUuQPj/HSNGWoaiGJzRuF5eQeLhn/dST3pBVbqMRSLis6/eNkyd3Idbg==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr10530449wmc.3.1544707377832;
        Thu, 13 Dec 2018 05:22:57 -0800 (PST)
Received: from szeder.dev (x4d0c57c8.dyn.telefonica.de. [77.12.87.200])
        by smtp.gmail.com with ESMTPSA id c77sm2049856wmh.12.2018.12.13.05.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:22:57 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:22:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] .gitattributes: ensure t/oid-info/* has eol=lf
Message-ID: <20181213132254.GW30222@szeder.dev>
References: <pull.98.git.gitgitgadget@gmail.com>
 <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com>
 <20181212133945.GV30222@szeder.dev>
 <nycvar.QRO.7.76.6.1812131358530.43@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1812131358530.43@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 02:01:15PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Wed, 12 Dec 2018, SZEDER Gábor wrote:
> 
> > On Tue, Dec 11, 2018 at 12:35:46PM -0800, Derrick Stolee via GitGitGadget wrote:
> > > From: Derrick Stolee <dstolee@microsoft.com>
> > > 
> > > The new test_oid machinery in the test library requires reading
> > > some information from t/oid-info/hash-info and t/oid-info/oid.
> > > The shell logic that reads from these files is sensitive to CRLF
> > > line endings, causing a problem when the test suite is run on a
> > > Windows machine that converts LF to CRLF.
> > 
> > "What problem?" is what people will ask when they read this commit
> > message in the future.
> 
> The test script (not test case) fails with the rather terrifying message
> 
> 	error: bug in the test script: bad hash algorithm
> 
> See e.g. line 958 of the Build & Test log in the Windows phase of
> https://dev.azure.com/git-for-windows/git/_build/results?buildId=26757

Yeah, I saw that in the cover letter.  And that was my point, that I
saw this there, not in the proposed commit log message:

> > Please include the relevant details in the commit message instead of
> > the cover letter.
