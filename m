Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F5620281
	for <e@80x24.org>; Tue, 23 May 2017 23:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760314AbdEWXcY (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 19:32:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34113 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758106AbdEWXcX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 19:32:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so30530367pfk.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PLUscOd2tufKE4SjhSV00yEcWqzZxeavTRumYxqd1j8=;
        b=a1LXQ/q7MyxcTRoLXhtBVBs7vivE9nUWGPeqP2lJGzkjcHGGBo11aAOyjmKXwjDZK7
         LUkuRPtD85sEKj4YxkK4NBoAFnKgNpSTtVV5fHZZHwulpVlncbMPCCp4HkH0uK6tqUA/
         hEYoo+FnqkL9Qxa5aW5rPT3QcxHzvVFClfghAUFZYYQLkJNvtq6vE503KPTrjtsoCUMZ
         HAwg1988NFVdIRZ42MePXSZpls8S2BO7Hj3LXBygkMBB6+sWAJlKbfDYRNt1JiUcbsTT
         k79EU3VjX9frfcztmLdy82i5x8pqHOxZbS0FTvwNsjTt5NU+kwk6VGapMCLxr3iw4DWK
         mtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PLUscOd2tufKE4SjhSV00yEcWqzZxeavTRumYxqd1j8=;
        b=b7bAEr6MD8xs63ER8CO0CFCmgZkoSdALqZR0sKw7CvmICVtwur3EafTtyMYgcy36MC
         gPV7eK3hR9euBNIZkvHC2RAUYzyRgioqbpA9JNF3gXnDCSrEydP6eF1xXnRrBMRK/mMv
         vRfUQHTS1UqLP949Z7s8jrXwtCIuwOoGrbce7IuEu2db08QXfpNJi15piHwCoyokGpsa
         QkN/SA/MBezC8FoRBDtFHsSHsx5AuWUQ1esSHk0S7INjaqIcJWje8rRL+EHHYzp0nBGL
         JTyzCU0AGOJSH1DbLOcSYoHPOkdrTKWLoozLmXnEWZtpZpi8RYWP5Zdz7IJWLCW86wTd
         0oxA==
X-Gm-Message-State: AODbwcBxEqizqJFqf5oEQxNeE5hP3TpEqzgmJbq5PZXLXyJ6duQSniVe
        TrMeZrT1pJa63A==
X-Received: by 10.99.110.202 with SMTP id j193mr34787579pgc.141.1495582342667;
        Tue, 23 May 2017 16:32:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id u74sm3104928pfk.58.2017.05.23.16.32.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 16:32:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, webmaster@kernel.org,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Another git repo at kernel.org?
References: <CAGZ79kYirjV0eQgB_ng-64HSPN_7njUMjnoNBkmWnx-rinsemQ@mail.gmail.com>
        <CACBZZX7HYU1USdcX_=CDFiMDtdaySSjd0zv-Bb1Z9-nHxk8UvQ@mail.gmail.com>
        <20170523151310.mhdhck5djmdlxrt4@thunk.org>
Date:   Wed, 24 May 2017 08:32:21 +0900
In-Reply-To: <20170523151310.mhdhck5djmdlxrt4@thunk.org> (Theodore Ts'o's
        message of "Tue, 23 May 2017 11:13:10 -0400")
Message-ID: <xmqq60grjgje.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> So Junio owns the pub/scm/git/git.git tree on kernel.org, and he may
> already have access to create new repo's under the pub/scm/git
> hierarchy.  In which case we might not need to bug the kernel.org
> administrators at all.

Yes, sorry for a premature inquiry.
