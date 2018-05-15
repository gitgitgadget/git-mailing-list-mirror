Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C85E1F406
	for <e@80x24.org>; Tue, 15 May 2018 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeEOUC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:02:28 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37178 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbeEOUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:02:27 -0400
Received: by mail-yb0-f193.google.com with SMTP id i13-v6so484996ybl.4
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VSJYIVMqJn7A9YPHWEt6pPfjZJK9s0LlxY1c8p97tYo=;
        b=iHmakZLCsscALZ78+0EO3tE2K8hZRvzSMl8C8kWqEmDYK1SpOCNOPABIKGyiPwpeNT
         tZaycrf7NRBVMb49ePgNMiCg/IwAS9/1IsZbseWAr6HfiU43HIrvRjbTFR+DrCKfqevK
         niISxSNbU8n/+EkKl5358crIJPKTxIEpCyXO5TyFnAGb/kZrC1MobEnltp1UX8vR6g31
         JdEWfWSoAd+YF/D/Ylt1y5JxzbprDM0Gl2U5hWSRTIY3//LRCccTN9Sr1xGs+cXqKFt1
         n+FI+PeszlGaRcqknTz4qKf9uT1Uty2rL127mjUHRg3a4e0jQsdPQr/1/yXZ8UAGmboC
         SSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VSJYIVMqJn7A9YPHWEt6pPfjZJK9s0LlxY1c8p97tYo=;
        b=tuj5ZLrzYsxzxJ4pMGyzK1k88mLaB6i4W+/6O8SI7w875XCUmqYLp86PLQcDRX14vY
         UrX38Hp+mdV1G4SWRUXdAKRjTejv4mBGRGNfORez4sEsOwK0hYX7mVJOJXzIWYmM+TT7
         6kjOePjt5P4HRLTqum3IllZKXSR8V+auEhfUQX3WG3IvFu/deSOE+/+jh0yfBGO/CiVh
         If2YMJyv6fLuBg+BYbFi6/4ZDRsej4XL9qnyfqyxOh8HvKTMXvwCA21kVdoh3UI04YTW
         ETO1Zd9koV6Y3cMpJ6Nj+Sisz2DScucJyuPF6WCAR586r1Bz+JF8aMrZ/JnetLaNuRjG
         es1A==
X-Gm-Message-State: ALKqPwcV/qLxzFpLOtSgHAsOuH7CpC6jWZDV7cezbv0PmM4n2TEc4qne
        gED27GvNS1XRUfRFCXzWKmbnB+y2sXr4zUGstLJj0/9PP7k=
X-Google-Smtp-Source: AB8JxZqOAMSrXD9qQk+TXiYbCdLI22V6+WPQoTzBK+uLTMmn0mMgUpZGyT082EwosbbkMdjg7Iz6QVzsyp4CN30n0+0=
X-Received: by 2002:a25:1907:: with SMTP id 7-v6mr9712874ybz.292.1526414546051;
 Tue, 15 May 2018 13:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Tue, 15 May 2018 13:02:25
 -0700 (PDT)
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 May 2018 13:02:25 -0700
Message-ID: <CAGZ79kYp89yLTca3SzrUnHbD-V8n3B7QAs1G9DkJKZQAd=exCQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Reroll of sb/submodule-merge-in-merge-recursive
To:     git <git@vger.kernel.org>,
        Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And I resent two of my earlier patches, please ignore those
(0001-grep-handle-corrupt-index-files-early.patch and
0001-git-submodule.sh-try-harder-to-fetch-a-submodule.patch)

Stefan
