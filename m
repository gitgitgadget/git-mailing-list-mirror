Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0EA1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIOChZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 22:37:25 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34515 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeIOChY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 22:37:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id u1-v6so8492103eds.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wk7h7ouuY4ovpsXcJrldPwazlQ1ytXOJJCae6wVrE+U=;
        b=HagdUzkB+1P/BIeHcZJVRrlAPHY1wBIp413AGeb1Vtt0GtY9r1Nhp+1Z59zQPs3IS8
         kbXu8bpVqrijSYQZ1FVpO0eMypnVZnybAldLXlPiaasSxb71KigVXDHgIFJVen8sowCr
         Goe/PwpRFuY/pVnyolau1xWm6dwrRpxlVzy2zgkYIJXUofuOQZOWM+1yhr05ejwpfW98
         dV/bsFNMyIGl2bHdWMdIZ0nM3zLEwNLv+1FA3nCsR9EZHObiy/USK5hMAlOkQqhbUuaW
         TMjVxvnvLsDENlhyoOGvnhpQupVykh28TS7ox4/6jwneAM7FvfaVjwANQsitZxPWJhmE
         4r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wk7h7ouuY4ovpsXcJrldPwazlQ1ytXOJJCae6wVrE+U=;
        b=lscLigSx9gfvx9VmhFdl07aP3jAqrTdEDR8zdy9f+YBEFl6Lq7p28QWCvw7B70/bxC
         onOvjY29JF4R0+6/bv7Mwk5uCytBr3X/O9t90VuGag4DGZQ+9ASE1XKlVF+HzQ2SJSg0
         esLRPw1SFSuCli4C48tcMAgf24cE78PKkI//K23VRW7g7e+vc5MEZWfSWiWUmYV60P4q
         IMSSlmFVeV2RMRo6OVI8eaO49W3ER+mfQSiFk+UkP+WrlzgmSJ5jAw7ICD5rqrC0cfKL
         s0Yx5zjPr/lyiA5HH5JhT32AAgx2p7k/HxByKoVlea+xxSpfaYO8TSK0A/TmJE+aWoKQ
         Y+YA==
X-Gm-Message-State: APzg51Dw/vrqfzqlaRIAwU8QkLXij4D4j/SAOfQT2UOqs9HxgUgaExtl
        y5XAalnbt1DJM4gUKFDLbkk=
X-Google-Smtp-Source: ANB0Vdad6ofgrt9ML0U2aooUJfgffuk7SjTWB5CXeT9+LMN+Ng63exKWOWiCAcV79BR/lIwm7L+m7A==
X-Received: by 2002:a50:c101:: with SMTP id l1-v6mr22306033edf.126.1536960069395;
        Fri, 14 Sep 2018 14:21:09 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z30-v6sm3866874edb.4.2018.09.14.14.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 14:21:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Austin <john@astrangergravity.com>
Cc:     git@vger.kernel.org
Subject: Re: Git for games working group
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
Date:   Fri, 14 Sep 2018 23:21:06 +0200
Message-ID: <87bm8zlqrh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 14 2018, John Austin wrote:

>  - improvements to large file management (mostly solved by LFS, GVFS)

There's also the nascent "don't fetch all the blobs" work-in-progress
clone mode which might be of interest to you:
https://blog.github.com/2018-09-10-highlights-from-git-2-19/#partial-clones

>  - avoiding excessive binary file conflicts (this is one of the big
> reasons most studio are on Perforce)

Is this just a reference to the advisory locking mode perforce/cvs
etc. have or is there something else at play here?
