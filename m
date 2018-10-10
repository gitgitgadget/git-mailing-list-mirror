Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152C21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 22:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeJKFnn (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:43:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42934 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKFnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:43:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so7413362wru.9
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pdf/ekfdMMQvhaV6O+0pwV28n16H5G4egGyMewusHJY=;
        b=QPga0eWLWknGJTsM0E/emwR+PNtrmb1WkdSZJ56PbpSgRxAOUGZbftdb687sJ6htTx
         BrPw5LZy7YChR1PlBHpLCtp5GzQsXJkPDI8q04FW8LiEbzCzORMH1QxSigH57iqqONJa
         Dzt1S6IzJbyG8tJ0V6+Haz7EnefOebpqpM4tdMR6zVa7OLFiCs5EkJ9HKE6qVvfRejLi
         MEiPW/pJNer/+SI5hPgs+pT0UWrdDIxCJtYe8nT4GbfMQv1Zj/dU19qqB/c/fKzaDmX8
         UpgcMe7FUiWnyl98JBhZpLjgfptXdQ6XdmJ8rZACOw8mnj10vgsv2WzahyJHsoVjJk9p
         +k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pdf/ekfdMMQvhaV6O+0pwV28n16H5G4egGyMewusHJY=;
        b=bFx2/bEsFOYZ6J7lkBCAS61xmsetlFZhULYCVFoJzjm2SeSTTyaCDd3feErJ06mFoi
         jyW/U0Gr7xcMDhpBQndWM+pC0X/MnH2QPeUD09GiTAr2tVdlrvJjDOJ+W7WOLgPNZ0jV
         oJbo/mxNFXofz6MENQXGqAW3re8ffB4HWdosSxKBRiQWSS6LYM/5emT66Ao/P28rajjp
         2G/WMGHmaKexr7ifxKaY1KUQHyI5BqeCW2jNhnr1jmvRarMn1yx5qoKji6ywriQO/3+w
         lJdIHMkRhZyh0GrE7S3CfRzkGz25cpJyUeOGFhlUaOxHL3cAAt8/ztROdJ9cyfMXMUT9
         wvGA==
X-Gm-Message-State: ABuFfojDXJHwRdg/KWZKb8HtE2U71jkVa0lvnPdEe9Zq3g6urMIF7kr1
        hjcR/IvgAVCAGjyOAtFc2IA=
X-Google-Smtp-Source: ACcGV61wTJSgaIlLSW9DfrZNJj1uRhhAGLj8CvHu20dITu1hDTPaIUApK8+7kKnWCL3nQP+WDhNOeA==
X-Received: by 2002:adf:84e6:: with SMTP id 93-v6mr26815297wrg.144.1539209971248;
        Wed, 10 Oct 2018 15:19:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 204-v6sm18453534wmh.25.2018.10.10.15.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 15:19:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mihir Mehta <mihir@cs.utexas.edu>
Cc:     git@vger.kernel.org
Subject: Re: none
References: <xmqqwoqw29uw.fsf@gitster-ct.c.googlers.com>
        <20181010152007.14441-1-mihir@cs.utexas.edu>
Date:   Thu, 11 Oct 2018 07:19:29 +0900
In-Reply-To: <20181010152007.14441-1-mihir@cs.utexas.edu> (Mihir Mehta's
        message of "Wed, 10 Oct 2018 10:20:06 -0500")
Message-ID: <xmqq36tdla1a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mihir Mehta <mihir@cs.utexas.edu> writes:

> Thanks, Junio. Instead of removing that part of the patch, I opted to
> expand it to make it a little clearer (in my opinion) than it was
> before. Let me know if this works.

I am mildly negative on that change.  "Omitting both would give an
empty diff" would be understandable to anybody who understands that
an omitted end of dot-dot is substituted with HEAD *and* thinks what
range HEAD..HEAD means, so it is just an additional noise to them,
and to those who do not want to waste time on thinking, it is a
statement that reads as if "it will be an error" without saying why
it is an error.  So overall, it seems, at least to me, that the
additional text adds negative value.

So, I dunno.
