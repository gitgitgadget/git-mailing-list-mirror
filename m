Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A13A1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 14:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfD2OMd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 10:12:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52477 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfD2OMc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 10:12:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id j13so14412461wmh.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACQI9r8m75fdKU/9xVGHmrTomtBtndKgZekdVluQ8Ds=;
        b=P7Zr7Z1EKqh4f0Lcg/E+OH9jyZ/wFPT1aHPR5+GmDFdVoacCI8vpEJInqBT0t9MiGP
         9U6r8aKhvgoe88C9soUdphTFEHJifXwnZd4BPKmHM9r2wnBPqYNuir/VMPjS3buLgnP3
         o+3e1XcIE3ZogCGo4COPlqPF5lU2axyspwhS0tS7H8CN5/uL1sBZ3Nq1gcUWYCC3NkcF
         LFdr7HKguf6gjngDUNQyfqhI+cnO4KI2JpqvbJ1oHru2RPERR6wZvNDXabcERLSGcu9T
         rbsA8eFqSFAAKDDv6KSRF5Wy2t4b8TTK68c0JryQEDjL1Qgz5/lpz6ORLgil4LZ1h8dG
         TWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACQI9r8m75fdKU/9xVGHmrTomtBtndKgZekdVluQ8Ds=;
        b=HFQRniRNlHJTn4lvE19LKnC5tZp50dzw75O89Bs72jtrcXlBlbboIR3fUg/+99+Czc
         uoipA/yPjCzOT28Ixch/NZFIMy4LYkYG/63sWPZvgBfYQJNDOajWjJmPamUUgyXzjwn9
         J9gEk6t/ppbqtD8CF4ePSkMOAOm/uhbDVrXmx5uVLjhjR9qSugsuIvMyeZthz4Z7vhzE
         djBKVDQixGmzREkaDj0gO2yBlda3y5pFCSfeXfj39BNCOw4DFyiKhnNdOukXw3A6tfT9
         SprlWU9CcVFR5MBTssTr680xjzydUH0mPyPqzYeiZvbxk+NRn8DanqtwWJ62o++/LwdN
         dexg==
X-Gm-Message-State: APjAAAVVEJgnQfZei+O1sq2IMDdtocmrXmGkCYqZZ0Oo3kKCR4X9hZiM
        z8KrsO6MLO4dz2yHWKBpU9w=
X-Google-Smtp-Source: APXvYqwZizx7wYwqvvkqSjaaDjxEwYnrxGRW3el5NryHXNf71d6WdAzHLYwgYnm5t4tX+v/fFJ82lQ==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr17480339wmh.114.1556547151260;
        Mon, 29 Apr 2019 07:12:31 -0700 (PDT)
Received: from szeder.dev (x4db43edc.dyn.telefonica.de. [77.180.62.220])
        by smtp.gmail.com with ESMTPSA id x14sm20951278wmi.32.2019.04.29.07.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 07:12:30 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:12:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v10 0/3]
Message-ID: <20190429141224.GA9286@szeder.dev>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190429051944.77164-1-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190429051944.77164-1-nbelakovski@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 28, 2019 at 10:19:41PM -0700, nbelakovski@gmail.com wrote:
> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> Added test_i18ncmp per instructions from Szeder
> 
> Is there some other part of the infrastructure that's testing for this? Because it did not fail in any of my Travis CI builds.
> 
> Travis CI results: https://travis-ci.org/nbelakovski/git/builds/525801210

Testing with GETTEXT_POISON was broken since 6cdccfce (i18n: make
GETTEXT_POISON a runtime option, 2018-11-08), and didn't catch any of
these issues.  See:

  https://public-inbox.org/git/xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com/T/#u

The fix f88b9cb603 (gettext tests: export the restored
GIT_TEST_GETTEXT_POISON, 2019-04-15) was merged to master just last
week.

