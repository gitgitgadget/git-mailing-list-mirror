Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133E620966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934219AbdC3S0Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:26:16 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33715 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbdC3S0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:26:16 -0400
Received: by mail-lf0-f47.google.com with SMTP id h125so32601605lfe.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tDDcbRRxoCBOtzXSNy1mdUt3accllGsckNXJJJrUUWk=;
        b=Ni0sTPRri6mMfNyAuKBBf1ISkDJE3xnu9E84QDhrQAVqt5TpGr1rj9y/6ccWt9u2wM
         o6RYK5CqdJ9CFvFrneymyX8TPJmaqrzdSYr3y9TCB3CgQ7NbGM3ZB0g17iYnDWYLeZZY
         GQuVwWMqUX0PljDo8deNgqSJ5VEAJATctbdk89EtCTvc4DOM+PklkfsqSqK4Q7laPUeE
         VyFYb3d+0rgZbo/npiZl15PcW4vH4v2Dz1XxvlU+0gOLYuI5lMfElzpcaMloTkvf2ljC
         owrIDGwj0kF7qLW++xVDWLbKf7qvoWY+iR4QzlBi6ah+TLb9SoeAL0jEqfstyocR55Vg
         cgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tDDcbRRxoCBOtzXSNy1mdUt3accllGsckNXJJJrUUWk=;
        b=VLA6qAqJCnr86SC/Yh7++X8LU+QsM7luu63vSiImzyuo1AbpXLwsYH15Q38luzIp1/
         FOmUH/vhcoULZ6BaTixxGH1GGOfn0uWX3g8hWU4t6KW7SfHl/R36Ofb02VcJLgb72tCS
         8QXUty0eucFnQ5GQlLpZcm6JUW7S9mCMZ5dDltgqXA5FknsUSkyDzYIwNXIenNU3kHLU
         +aFIscKBPJsc2h6D7oigZV8/Jo23xZhm/DZxlwiRaFpEiL7WVeyJcyZe29ZDoIEU2yQ0
         dQSUF62HSKD+zRzrWOMdCQC9FI89c/vYKgfqTBdqMUNYNx/kMfqgDi0zjNwoGumw4zam
         j52A==
X-Gm-Message-State: AFeK/H06o7DggmddPKyE9Fr2UIcestrUP/daZON5cCyeMO84uFpDOREy+4YSd4Y2zR8fefci5wfAK3wMfRCQIQ==
X-Received: by 10.25.20.198 with SMTP id 67mr310765lfu.78.1490898373748; Thu,
 30 Mar 2017 11:26:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Thu, 30 Mar 2017 11:25:43 -0700 (PDT)
In-Reply-To: <ab7a326c-0189-4542-76e8-649eb6e804c9@alum.mit.edu>
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-5-git-send-email-bnmvco@gmail.com> <ab7a326c-0189-4542-76e8-649eb6e804c9@alum.mit.edu>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Thu, 30 Mar 2017 15:25:43 -0300
Message-ID: <CAEA2_RL18TarW6k5keP+ADFDv+VZE+gG3e6EkCmWby7GjG-T_w@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] dir_iterator: add tests for dir_iterator API
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 4:46 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Is there a special reason to write the date to the file as opposed to, say
>
>     touch dir/b
>
> ? (Some people use `: >dir/b` for this purpose, though I've never found
> out why.) If you write the date to the file, the reader will be
> distracted unnecessarily wondering whether the contents are important to
> the test.
>

There's no reason. They will be `touch`ed instead of written in a next version.

`:` is a bash builtin that that returns an exit code of zero and
produces no output. On my Mac at least:

bash-3.2$ type :
: is a shell builtin
bash-3.2$ type touch
touch is /usr/bin/touch

I suppose there are reasons to try to keep the most of a shell
script's logic within the shell itself, without involving external
binaries.
