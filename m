Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E791FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 00:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbdBIAZq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:25:46 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37667 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdBIAZp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:25:45 -0500
Received: by mail-it0-f48.google.com with SMTP id r185so4852947ita.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KN9/WsLCk5bjdd2/ud759KBGojGVEzcJwBbtT/ctcoI=;
        b=lsqlgZzhbFigu1tMtZMWneDChGp9F2ySRnOR6Z/HCTqCrSFK95wE/xdw0OP/gXK0ix
         9RYsBTp17ZnbkLIC2Ozzyd6zWUmLZ2iGT/u0azrsiO/ev2Y23TtK3bt40C2uLsUtFbHp
         rITEtEGD+afaQZg6Ft0vrzKo3YDO2fxtJlxydBjCprzfsX2flnwtYUcIBqIPoIuBJWoe
         53arXxrQ3kbqVqg6mN9glpMiXUWeWD8oDP0/D9iKj/h4wJWCd3qb6Wn80VMG+n9bepqq
         0Pp4i3fgZ4c/KdpRUq4sERhvo2c+j6OANqvIzolgDAFrxlS/yZ6mXNcgpsmwp1jcZePo
         s/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KN9/WsLCk5bjdd2/ud759KBGojGVEzcJwBbtT/ctcoI=;
        b=Jkxrj1Aycw/Qx0+bwb2pebcHKjdARRL1VErs/1qgFS+Sfhy3+gkrsj35xdZPa5tta9
         I/vXkkIfw4GXJbLMlUMGg3CwghZhBjzIccagtZ3desWZWYNk+hfqaq8rtKXadjdolNj/
         bh/zr8FP+TYH8onJmUH9oTmDSCbZnaH/FKeAz5OA3Y+o6z2UyQwpwQYYNZKp79OGFk3j
         ZDEOwP1dH7rBPHszrNSzpzuz+TZdCiKHcTPIg7Bw93fYS3Xvs4tLr/LhT57gPoAgyveL
         ZBZGfl6yX5CxfkvJTyhh7l8TVA3tbGDMxbCHnNc8lYWsJAkzyU0Rgyr4vxSNzpVF29GR
         1O5Q==
X-Gm-Message-State: AIkVDXJPJ9Jl7KOHGt2Y6j3UcBlPFU36FKIZj/BpF1wuXusJW8NwvO+8TplMPbn9/AuZFT0qKYrUBvwVGLjuXMYy
X-Received: by 10.36.65.4 with SMTP id x4mr19946600ita.69.1486599921114; Wed,
 08 Feb 2017 16:25:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 16:25:20 -0800 (PST)
In-Reply-To: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 16:25:20 -0800
Message-ID: <CAGZ79kZ6m1NGz9Lhhd5BDxayLW-UC8MqexMyhHBhHKrmg-tB+w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/submodule-doc (2017-01-12) 3 commits
>  - submodules: add a background story
>  - submodule update documentation: don't repeat ourselves
>  - submodule documentation: add options to the subcommand
>
>  Needs review.
>

The first two commits are good to go IIRC as you seemed to be
positive about them at the time. Though I have a hard time finding
evidence of such.

I am currently reworking the 3/3 "add a background story" patch as it is
RFC-ish, so no need to review that any more.

Maybe we can get 1&2 merged and then 3 comes on its own?

Thanks,
Stefan
