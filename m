Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0096C1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 21:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdBFV31 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 16:29:27 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34250 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdBFV30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 16:29:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so7663368pfb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zI8XLb24f9/To5237v3T9rAo851H+FH6SdQ7kKY2+Ps=;
        b=sdfrYf7mXPIG2UDzucsq1YFs3Aos6PfFeBRbmRBUllVLAyT58s6idzDhrS3G8wx+2L
         ZMf1YvwudI7KJxrs6yPDW7qooWJS/iZ9PrHgxMI2NltX4y1pIXY1VVbCJWZteHGtwyz9
         ZtSPUun0WWye1zhyG30EFOSlHHhv+cZGBQqqkNo37ehrqTGlYqIKdPWdt8qEZjpwv598
         gxTf69usC2ZM/gbkrJq+VaShqZl0nM23eOPvvcO5341Q3qyrIyB3FQ1E6UWHh8uPmXKd
         hAkosKomeZXWiQ/PPqrpfxPwsTDMsaexjlF78DEWMoT/Jk9QVoFtOnpf7fAkMMyTjtKl
         lskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zI8XLb24f9/To5237v3T9rAo851H+FH6SdQ7kKY2+Ps=;
        b=jp+6K0Kr+0VwIiRqCxCdljHSOmOgXgEdj62BM61JVB9J+DA0S2KlnEeJmcQXe91mYS
         P8x4yBpvJ1Kd/TeMvvq5Ncam/lgLUjFSDj98cA62KDhmakwVqNkde30MHdv0859L4jtj
         Yoyy20iEBSzcysdRoJePhT2crrJqimyaqzVw5OFyh8UH0TtR9SQ7bPpM6aVy73qFmx1Q
         bGXiqUBHjovKLr04YQsO/JgmgBOVfF/szX3xK7iKhE9kgzI72ti7s1XAX9joeIg6dbGX
         MIQUl9UOKtF/bdfHgPXy9mZl4LsgjBJ2McimKCieiq7+O/X7+er71tMx6voRiBAHiVub
         9bew==
X-Gm-Message-State: AIkVDXJxsFSbJ2ilptNEztU1NH/BWyKWSUB2W8J2clNBXi65teqv9Fxb9o4E/pfRjjaX3Q==
X-Received: by 10.99.167.10 with SMTP id d10mr15890882pgf.19.1486416565712;
        Mon, 06 Feb 2017 13:29:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id s136sm4914022pgc.38.2017.02.06.13.29.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 13:29:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, j6t@kdbg.org
Subject: Re: [PATCH v2 0/7] completion bash: add more options and commands
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
Date:   Mon, 06 Feb 2017 13:29:24 -0800
In-Reply-To: <20170203110159.377-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Fri, 3 Feb 2017 12:01:52 +0100")
Message-ID: <xmqqd1ev100b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> This is the re-roll of patch series <20170122225724.19360-1-cornelius.weig@tngtech.com>.
>
> This patch series adds all long-options that are mentioned in the synopsis of
> the man-page for the respective git-command. There are only a few exceptions,
> as discussed in the above thread. For example, no unsafe options should be
> completed.
> Furthermore, the patches add subommand option completion for git-submodule and
> git-remote.

Reviewers, do these look good now?

Thanks all.
