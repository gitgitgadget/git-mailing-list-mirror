Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC9820248
	for <e@80x24.org>; Wed,  6 Mar 2019 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfCFSKm (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 13:10:42 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:59401 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfCFSKm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 13:10:42 -0500
Received: by mail-it1-f202.google.com with SMTP id q192so6161016itb.9
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SwYd4QW5fCRAzHhbAGY1KowaAs9KaDalpgunCu3FpXo=;
        b=lid21rfB1NKlmB3aWN1hzoF9o5XV7LHHO1j61MK9TP8mqyUmYkAGXNTxTwZT+fi/Wd
         6WZMzGqamtjgBAXBR+z9jiBatiueXUPfEgCmLmFySzS08eKIktEcFrUQ7sJx4s8AuS3/
         1PUdp72H1ZEsn+vab2UQXC8zPwMVa/2gUMISQVXxe3tkWmIY06Qg1bEUscaB2kurpDI1
         +WhZ2zFGdBUCL/Amr469qC86FHKqTp46RwyR57qdwv8a1OrCHuH8vDO7/7XXlqmcDdjG
         SPLyWlNDjoPWkbFuf+kVZghq8mtan+J+Hl6chO3Dol1ATTT6ITAy+1tiX/HGbq1CJBCM
         QJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SwYd4QW5fCRAzHhbAGY1KowaAs9KaDalpgunCu3FpXo=;
        b=UKruCFr3+OTLaP7kxa0mmGNZSrj5w3W5onGFVoi2ByCZSrDoheEjnf2/tdUWAlhT5z
         mxOBMOl4aetG8k3+6eBAswfsyc3sk0sSyvSWjqXw/UH57OwmV2zF7JjPdVfQFjedlLZK
         0Qhwrz6SXgrnadNZZPUDJt+Ob0JeqPOVig9Ay9PvGaYR2pXvuEkT5zKUnTSoQWRAsVrc
         ESVy4WWxHU6Li53khCWxTbiRm/4mZOufRL6+JUPCqo35aWQ8uAXoNIbV7rlGGYLS1eE3
         j1IMFMQQ4KlfC6+OAH5vjEnowg25PYhJoHC9Xh0tL01yFbdSqtIebA4WonLM/9pP9r89
         xNJg==
X-Gm-Message-State: APjAAAWOh40FlsPmuLaKpzUvXeVCXQogmWKLBPjFtnktXD1PSFUHkeu/
        hXo4wbjMscmGxF5/I4M5zS9ndu0kXdtesO5T4ODF
X-Google-Smtp-Source: APXvYqzUiBxDzRvIC6rfLTrV+3lY3GDXwiO5oqDB/DruCkYL5M3fPgkMT40ANNGEn8fhRvDtuPt5bLA6tczyoz0ILUhR
X-Received: by 2002:a24:1708:: with SMTP id 8mr6806421ith.0.1551895841497;
 Wed, 06 Mar 2019 10:10:41 -0800 (PST)
Date:   Wed,  6 Mar 2019 10:10:38 -0800
In-Reply-To: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190306181038.140413-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/test-protocol-version (2019-02-06) 8 commits
>  - t5552: compensate for v2 filtering ref adv.
>  - tests: fix protocol version for overspecifications
>  - t5700: only run with protocol version 1
>  - t5512: compensate for v0 only sending HEAD symrefs
>  - t5503: fix overspecification of trace expectation
>  - tests: always test fetch of unreachable with v0
>  - tests: define GIT_TEST_PROTOCOL_VERSION
>  - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
>  (this branch uses js/protocol-advertise-multi.)
> 
>  Help developers by making it easier to run most of the tests under
>  different versions of over-the-wire protocols.
> 
>  Blocked by js/protocol-advertise-multi

I sent out a new version, on master, that avoids the block:

https://public-inbox.org/git/cover.1551131153.git.jonathantanmy@google.com/

It is mostly the same except with one new patch.
