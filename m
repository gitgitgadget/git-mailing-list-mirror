Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EA01FF34
	for <e@80x24.org>; Wed, 10 May 2017 08:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbdEJIMq (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 04:12:46 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33805 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdEJIMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 04:12:44 -0400
Received: by mail-io0-f180.google.com with SMTP id k91so8660373ioi.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pLVNsEc4Lg+6pMwTWfZdijVTOSu/aYM75Bq1K1VRprk=;
        b=E/YqFOoU8QtO8sxxTvTMD7HlmcxQ8a8/jX6FRaNCeXG3bgG3YVVH3XdLFT0OC283Qg
         olUiBA1aF3YBMwj54f5UP3YY6sM2NANtAeiR22EeiL/jN3CNo21pZscL3sYo++xvoYvP
         o09L/CHcpRBk4IX6g3PCG9dLUJ6m+eqL8A+JczV+YwcHx4SAdG4/VXltKQ5yNYiQ/jyJ
         7eNGdINpdixYpwVRVCw3d4l8QOKxdQp4D08XDES4b06CvWlwgEOwDw2N3n4blp/nWMPP
         DyVYBoS5W6LIK4zXidtfbjIoj60nx+oSfLZI400DiCXEWRAxG04HQ7JpEgG+BAI+akYj
         BMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pLVNsEc4Lg+6pMwTWfZdijVTOSu/aYM75Bq1K1VRprk=;
        b=HUl8elUBijsgyfQbc2D+59BhAJ7G0M/t2ttysIDSwq3bTcVUsfJzNGkRu2AEiCm/yy
         /62MCPv0Rc92JZzY0r8ygfehSGFK3WtgRHgbTk4bdn4ScQdBI81UiSZv7RSB+dzRDwLj
         naPe0pb7wwk7IbWqFUYL83ebI+q18oTZn6zZ4Lx9TWZgGw+84tBVm8yY6w9hozPq96K1
         8I5s4Mulg0vGYBNp22LjabvRmXDj5HmU4Itd8ym94HPCZSoTRMdWG8Je2cnUfJdhgTBT
         4RHyvMK9+qe6Ny/xY0XLxqVAaFLlylX7WFpcdUXONS/tW6tzdPElyrOJw/y5YE2HAUwa
         Ydaw==
X-Gm-Message-State: AODbwcAwhyJyM28HsGIzqaiEvA7GNoOl7XqSeAS3B2XOxQ88uSplX3WM
        +bYsEUH+nGIIs1unxR4TU6IXix+brA==
X-Received: by 10.107.178.12 with SMTP id b12mr2121746iof.50.1494403963777;
 Wed, 10 May 2017 01:12:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 01:12:23 -0700 (PDT)
In-Reply-To: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 10:12:23 +0200
Message-ID: <CACBZZX4VjwXNhFCwhd=-5ArWOvR5E2GDjWZf5dwz3Y4iCS0yYg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 7:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]
>
> * ab/compat-regex-update (2017-05-09) 2 commits
>  - compat/regex: update the gawk regex engine from upstream
>  - compat/regex: add a README with a maintenance guide
>
>  Will merge to 'next'.

[Sent last E-Mail too soon]

There's a tiny typo in "compat/regex: update the gawk regex engine
from upstream", one of the two bullet points says "Git project.f",
should say "Git project.", i.e. without the stray ".f".

If you don't mind amending that before merging it down that would be
great, due to the whole multi-patch !fixup -> you needing to squash
that sounds easier....
