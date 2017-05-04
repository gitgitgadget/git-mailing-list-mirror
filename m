Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F9B207FF
	for <e@80x24.org>; Thu,  4 May 2017 05:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbdEDFTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 01:19:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34847 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbdEDFTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 01:19:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id o68so624563pfj.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 22:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PnHvzF50158acROyPHtgp6YL5VMCNsXK8PsTC3F4VJ0=;
        b=fFE6U3xnP9hXXD4Wl5oOB9MsMY6SDCXDKqHFn+TTi5VsmbfEhtm5AlpaH9jsYOq2JW
         8c85YIvHozVqkvNfGimRKYkZ/z05poi5cNXJeKjBn0W+puLX3fQPCDniMboOGykiD7p7
         MFHe6Ye8fDiyZTh0h8PJGhm0Tfx8WOmVxCEjiETNXxRtlNu5OwrLZxEMCoKT4ggeIf4y
         sA08CxEFLs6L+Tbr12KvN3WAMG1lEBdVGxgEEu9DDsYlF//U1tf1voD0DXoSWSN+m0In
         rmZB6m7yKmIbzpt4Gg1jx9B7MKCMJLGXhcbrtbov225SOQfwyz5rUrT1sjhpiV9noyWd
         rslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PnHvzF50158acROyPHtgp6YL5VMCNsXK8PsTC3F4VJ0=;
        b=WstkfXRVrFqIdPg8SVZql5RBnvr0qtWx2heNR8eVIeDimn035pqaE5qF1PPLxAjU+x
         KzcztIUXFsWIfj+J1ybctmIyL1bYWqodT1p+m73Oemexf3J213ZA+XOlvF+gvSyFX5g8
         gKi06ePjwLazLtlaS1u9u5TBO9CuqdW4nNtYuZOAojSYZW5KjgK+n8twVuiJMCav0n1Q
         8EEo+AEdpCxO8T+bXzXp9ejspQSXd85oapzvb2c7i9Jxyk8qqFk4/sboz1DzdzkQkmt1
         6B1s0BoiTv8Ehxt7nqZPgFBAcwL4ss2MlJ/undBCrhpoFByIJSS5ZUXmrrwZBPsvsYm8
         OHNg==
X-Gm-Message-State: AN3rC/59/Q70deaIv61itsQG9e0aF7lJlW6AFaQMyPECgqlq8i3ZmINz
        lLoEbEz18jcphTIIM+c=
X-Received: by 10.98.76.76 with SMTP id z73mr456210pfa.99.1493875186028;
        Wed, 03 May 2017 22:19:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id k23sm1528537pgn.11.2017.05.03.22.19.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 22:19:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
Date:   Wed, 03 May 2017 22:19:44 -0700
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 2 May 2017 14:29:44 +0200 (CEST)")
Message-ID: <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> For starters, those files include shell scripts: the most prevalent
> shell interpreter in use (and certainly used in Git for Windows) is
> Bash, and Bash does not handle CR/LF line endings gracefully.

Good to know.  I am not sure if it is OK for shell scripts not to
honor the platform convention, though.

Stated from the opposite angle, I would not be surprised if your
shell scripts do not work on Linux if you set core.autocrlf to true.
Git may honor it, but shells on Linux (or BSD for that matter) do
not pay attention to core.autocrlf and they are within their rights
to complain on an extra CR at the end of the line.  IOW, I would
doubt that it should be our goal to set core.autocrlf on a platform
whose native line endings is LF and make the tests to pass.

> Related to shell scripts: when generating common-cmds.h, we use tools
> that generally operate on the assumption that input and output
> deliminate their lines using LF-only line endings. Consequently, they
> would happily copy the CR byte verbatim into the strings in
> common-cmds.h, which in turn makes the C preprocessor barf (that
> interprets them as MacOS-style line endings).

This indeed is a problem.  "add\r" is not a name of a common
command, obviously, regardless of how the text file that lists the
names of the commands is encoded.  I am undecided if it is a problem
in the source text (i.e. command-list.txt is not a platform neutral
"text" but has to be encoded with LF endings) or the bug in the
tools used in the generate-cmdlist.sh script, though.  Shouldn't the
tools be aware of the platform convention of what text files are and
how their eol looks like?


