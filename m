Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8751F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 17:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeJFADm (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 20:03:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeJFADm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 20:03:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so11647403wru.9;
        Fri, 05 Oct 2018 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Di2qTnfVSi8PA9aM+8/35V9tuh8JDi6tG4um5JXc9mI=;
        b=IDhEOd4auRfhpBsfWEqU6SAc+0iYYYci+g4QHdYBLfVETAXKiQklbTStIJRanUvoDE
         oDMtTuUvcnC/slwWDVaLWRojHQ4UZ1kuU2W3kDNP8Gob3gwhXsj/tclIdQu1/Nt5wjSN
         D1QYkYzQZH4LC17hKcCVlrx0IJIMiQDM05lJ+REgy1o6AG+0jobJPHE6xZddnShz9XSF
         l0nm1TbHuXDtBimpOhS+yQ5wLxO1O0WAi1kAzAsM9py+whoM6eE4BGQob8Q/Yq8xdy2Y
         +sfgVIzqtj92fO4MPM8Wpw5D5YRqMHQKKAZUzmL/5wL0/vHcjWPY4HwcZMWJbutoBpqo
         5sBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Di2qTnfVSi8PA9aM+8/35V9tuh8JDi6tG4um5JXc9mI=;
        b=QluoFzo1hn+U1e02Sji8ViPRPFU+ZuwwpvKJJ/IVolOdeE7tWpZk8O/mYy/c9CHsX7
         Tp+RtX3oQn/zID3mHVWqwjCk/3GtH5qasT9ncwZkKD+oDhBHEiiu+USFo/ouaj79GUh+
         sMdxA4fbmOWEVfQuUb/+0OMSXagzWIdJwMhmrJKAtshUHpxP7DtVOFWifPMjKFEL5xRp
         2jna1jtU6DEKs57IozKuZufDmol0aYlw9c9t4LccDzoXIE6TmP1reymFap6g7eoHg3Bd
         Z5+wf9w0tJspObb3fW2SSY5PGfXa/Il0hbsZE6kXCxNCCALKVNGCcTSNDmvtjJz+5pJW
         YPWg==
X-Gm-Message-State: ABuFfoiax0PTlolX5m35kP+eTD7iN4xr6IbXnDyK7tiYs0Yt8dJSykF4
        JVG8JL8j6pkwnG2AqoAMUmGtT5HWb1s=
X-Google-Smtp-Source: ACcGV62kDPDQnfO9ozAQd90+LEeHOSSPvhmyzFYcYQM8mzM9mrbOuIDT8ZmJAFBPjcz/xvCBfn4dMg==
X-Received: by 2002:adf:9a84:: with SMTP id a4-v6mr8757363wrc.78.1538759043894;
        Fri, 05 Oct 2018 10:04:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1879991wmf.35.2018.10.05.10.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 10:04:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Announce] Git 2.14.5, 2.15.3, 2.16.5, 2.17.2, 2.18.1, and 2.19.1
References: <xmqqy3bcuy3l.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 05 Oct 2018 10:04:02 -0700
In-Reply-To: <xmqqy3bcuy3l.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 05 Oct 2018 10:01:18 -0700")
Message-ID: <xmqqpnwouxz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> These releases fix a security flaw (CVE-2018-17456), which allowed an
> attacker to execute arbitrary code by crafting a malicious .gitmodules
> file in a project cloned with --recurse-submodules.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of these
tags:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git
