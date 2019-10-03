Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E581F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbfJCS2q (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 14:28:46 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:47088 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCS2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 14:28:46 -0400
Received: by mail-pf1-f179.google.com with SMTP id q5so2250012pfg.13
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=alcvbxTipcZX0i52/cbOb26rrqivRun8OgrGb2b6MiU=;
        b=c5tJJjednvjt/GbBtP9g2E3k9iBSiAmnqrxk9Ggi68/9b6at8dzXuYtissBTBVM9K6
         xA69p07oGR3ED8XeBSYIMQtksez40U1TeoN669GKNVr94vSj922R2hgz/HX2U4tJVr8f
         xckaF1CoQaMquJrxT8ZVAcvfzP5c83i3XtT2K1UKDyMzixP52TQujchd9SIB6JAU5/eQ
         IV5cOgu0RFb45e5LHYBLWlBvkTk2LVvCTQKMnxGSrWdPLgfCfnKGqtGYLn9DeEsrpeuK
         LZQurvDm7k98w5ltLHV9ZefIyY3Ylf5P/N6f65GKYns1TLPpTmIaYwb8vpEnJ7Aghy/Z
         1lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=alcvbxTipcZX0i52/cbOb26rrqivRun8OgrGb2b6MiU=;
        b=qbgO7a3Xrd8arqEw9i/YMlOodXbOIO+uxaF2kg7v4IxWNT39vcxB12NN8cKClOSfdO
         mj32IKbt4Rqf0IEiwcnHwURwin6Iv7i0ARaokGbWD7QvBqdAbFtfjSxesSrseY9g+88O
         N7GDEregxbBJ2cDtRTpr+LXRXatmciB8CBy9phIPRrNEB6NRRiQmjzuRHYbL4Q1NcZvh
         zjZDdXOobuHNnyYpHUMO/MwrlHJyGl0+6FBceKWExcZ9GdGTunTQ+GWkOhEcIq+HX8dJ
         jUyzRmoct6z4YGEH6c0rkjLxoYtqsXUrpCtMstvLVWHwE7tGcye0lPFOfgC0Dp8gDFed
         TBFQ==
X-Gm-Message-State: APjAAAVpCaGvsoB19ftVJZOy7gZJ26J1/qHlghdnMF7+eCiri6jGZGMM
        t1nFN61j9LvOvlghtxb05CiRVmb9RwZfjQ==
X-Google-Smtp-Source: APXvYqxQdnQAzAQ+JiHM9BCriyYywGZlUZEvWmxVsWzlmEowzHmRTWxZ6esFdA7q9Z7lHO4OZUw5PA==
X-Received: by 2002:a63:4812:: with SMTP id v18mr10261664pga.83.1570127324767;
        Thu, 03 Oct 2019 11:28:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b73sm3067763pga.36.2019.10.03.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 11:28:44 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:28:38 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
Message-ID: <20191003182838.GA173211@google.com>
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 03, 2019 at 02:04:39PM +0900, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 

Hi Junio,

How do you feel about
https://public-inbox.org/git/20190930220355.108394-1-emilyshaffer@google.com/
which fixes a user-facing SIGABRT during partial clone operations? It's
reviewed by Peff and Christian.

 - Emily
