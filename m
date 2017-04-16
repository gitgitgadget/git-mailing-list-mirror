Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CB0B20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 10:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbdDPKrq (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 06:47:46 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33405 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbdDPKrp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 06:47:45 -0400
Received: by mail-oi0-f54.google.com with SMTP id b187so121912868oif.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nn2DWfV/G8wqUdF7lwEjS1Qd3qqPHJELXzBr2qIfClw=;
        b=HqnkdXRPTM/XWtb4ooLsNWrb6HzYBXBiBOr3Y1PfwHaruehWBR2wLRABV5OkI3Bu61
         X2E7FxwELOJ6rXnmtmjjfuaJ7k9XkAVc9kvSeWG6g0P245Fqp3FA3XsVqus9Y3O1KLD+
         0CjdK1WuAt5GhOlgEwCBFdEAU6rWlEGHb/Y5+XWu/9Te5vKh51EwGJh9XPbZLpTfannH
         03Yv0ZZEfWcmxdrBFRS7QOwWq6TbPns0ZZViouhyvYA+XyBIwhByodJ5ldU/pOq6gA/V
         7UXPmRuyVurZkZfppf2oR1iDL66oQ46q7fsMa/iUbBY2BhbAb1KWV2hQD7l+3EawDTNs
         EfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nn2DWfV/G8wqUdF7lwEjS1Qd3qqPHJELXzBr2qIfClw=;
        b=GzTHsHYSygUAHoqfdUF4LLgO2a2EyV5BJSiaAEAB4K0Ty+/Bhslvj6BvrG+CrLlAx9
         FwaJHS/q1rV//3QH5EUDDOmmddm2Tyk+8XcShfnaWtiArY1JINfxNTn3Ro+O/oSzynv7
         hZGGLhYv0k03Pb9RkrTn9Vav/I0MdM2j1EZ9BvHDl3EbrKxmiTO1PjRkKBMxvpzaZipw
         /QE2l2ZBTiFc62sWUnjJTDNSqYp+d/4mN/37gc8dxl//L9uGuIq4Aryz7jA00NYDhP0D
         5RBogoVEvOvK8ImtAPMKMM3TCTePBKEEB+IPqlgSZ5iH7irD23A9a6MlxqRgxNSxysb1
         mk+g==
X-Gm-Message-State: AN3rC/4nhFVOBOj6yWOEV5cUdDjnUKKQIeuJ4/gJhp7Gm/1yerJBye59
        SH8hwnoBoI67N02Y44WwFFf30p0NOA==
X-Received: by 10.157.6.78 with SMTP id 72mr2456605otn.37.1492339663883; Sun,
 16 Apr 2017 03:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sun, 16 Apr 2017 03:47:13 -0700 (PDT)
In-Reply-To: <xmqqy3v2kmf5.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3v2kmf5.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Apr 2017 17:47:13 +0700
Message-ID: <CACsJy8B08DN+0Kn-g6iV2JVkHej814tqXjFSx=XBhckDyGx5Vw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #02; draft as of Sat, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/conditional-config-include (2017-04-14) 2 commits
>  - config: resolve symlinks in conditional include's patterns
>  - path.c: and an option to call real_path() in expand_user_path()
>

$GIT_DIR may in some cases be normalized with all symlinks resolved
while "gitdir" path expansion in the pattern does not receive the same
treatment. This may lead to incorrect mismatch.

> * nd/worktree-add-lock (2017-04-15) 2 commits
>  - SQUASH???
>  - worktree add: add --lock option
>

Allow to lock a workktree immediately after it's created. This helps
prevent a race between "git worktree add; git worktree lock" and "git
worktree prune".
-- 
Duy
