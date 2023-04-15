Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34DC77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 08:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDOIzx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 15 Apr 2023 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDOIzw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 04:55:52 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1126A6
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 01:55:50 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id h14so9288563qvr.7
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681548949; x=1684140949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEc5ZYdTziY3FviMuXQP3kAFh6yIwYwsEG/TuM2/UOo=;
        b=FfAJr5nrMDH3aoyFymp4CNsm6FOGyaaZ+yv+dP6NAdjK2Sil7kqcp2QaqLXBPbY7SU
         K23UgeYNuPO71jX4XVEVhS+uqP1eHNphu68FHRQo3v2H51Rle0oZP9WV9AnQDCeyGJto
         4JnlczRCAGPMYbNlOfjEqQCyYWzjj+/114Bd6q6bQUhpSGQ1b0WsD7F6dYZQmkmohU6z
         9ZMqciOJdOW7BE+eV52z3heCMlbIaEsPiLH17ObHGLdcnfr9uBFKa+l5PHRYNYULt/Mt
         hzJn4o4yTRtrob1yEKe/lXwbOn4NzRlzdGsytS+kTA+rrVK5yw9IJWjAqTsFelLaUTha
         Z+7A==
X-Gm-Message-State: AAQBX9ewyceRWbovayE5h8p7qpt//6rsbH0eGQHHUYhE/Ql8ebvXNjBg
        PD6it3nlsCZuWRsPBLzj/7zOvpk2bVaTawq0p3S2loTt
X-Google-Smtp-Source: AKy350Yk3ypfMct7qf9I9qrzC3d8qqOtzaq0Ma1TP+rrLz6mFoFw782VtO2IHUjVpNKjePNjqwd0wrbPu0caaAZg4TU=
X-Received: by 2002:a05:6214:e6f:b0:5ef:4455:fd24 with SMTP id
 jz15-20020a0562140e6f00b005ef4455fd24mr7248689qvb.1.1681548949346; Sat, 15
 Apr 2023 01:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
 <CAPig+cQQVby2g+_kfucbYdwOZW5_CEyyyOex=4hXoCJt7TkjeA@mail.gmail.com> <CABPp-BH=LQdjn4yjtCJrPZVHLAZPC0895NYpyUfE92+TKcUsbg@mail.gmail.com>
In-Reply-To: <CABPp-BH=LQdjn4yjtCJrPZVHLAZPC0895NYpyUfE92+TKcUsbg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 15 Apr 2023 04:55:38 -0400
Message-ID: <CAPig+cSYJw3_eJSLr0ygPDj21vcdVK5NT1h_g1PrhA4vM+uiOA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Elijah Newren <newren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 3:08 AM Elijah Newren <newren@gmail.com> wrote:
> On Fri, Apr 14, 2023 at 10:08 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Apr 14, 2023 at 2:13 PM Philippe Blain via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > > +Notice that the diff shows we deleted the conflict markers and both versions,
> > > +and wrote "Goodbye world" instead.
> >
> > Some grammatical problem here. Perhaps s/and both/in both/, or maybe
> > just drop "and both versions"?
>
> It reads correctly as-is to me.  There were five lines dropped:
>   * Three were lines starting with '<', '=', and '>' characters,
> referred to as the conflict marker lines.
>   * Two were lines containing content from each of the sides ("Hello
> world", and "Goodbye")
> and one line added.
>
> Thus, the diff shows we deleted the conflict markers (the 1st, 3rd and
> 5th lines) and both versions (lines 2 and 4), and wrote "Goodbye
> world" instead.

Yes, upon rereading it, I can interpret it in the way it was intended.
On my initial read-through, it sounded wrong. Perhaps, had it said
"and both versions of the content line" or such, it wouldn't have
tripped me up.
