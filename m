Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC5EC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381387AbiDTSGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381386AbiDTSGk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 14:06:40 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B306473A0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 11:03:53 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id p21so2720722ioj.4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 11:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JKXSDn15RGk+q62hDlIt7Xk3/92xEGk2SH33vr44RI=;
        b=t9895mr3se9xeEwQN8UY8xpXosE9FibnFiKGOHDQigdcDU/SjpgQ4qqem9Lbo13g+n
         47fv9LgZDGoOhrulgdJPhwfqug2Erro0s0xnFAAgkzoAp/JoZnfgcJATr9os6xk8BTSB
         yTt2v0D29y2QB3PfCMXdc77TB7mruBiRUA6bWOyPelvhaDgvtkhgPlBeNfbHJarcP0H8
         zeJq5nSrdnPYiZ3y4D9vif484hHDNzXVFzY8tJJkAPZ7QQdwZtFmtCkbEHJ5YXADT8Us
         uWpmdqoOtSaCvJfSQC8X5PdcMWxzdHxJtIzY5DLBnIo3YYNPS7r2NbOMVNTtn4fnCMr2
         Hx0Q==
X-Gm-Message-State: AOAM532RvVyRIPPh0FD1mmy4AY86Ll4s+w7c75N3jnU9f+AeWp7veytI
        QLvMgjJqvTF+lffySC70w7+UWAf1Gvd/JxlRZZ0=
X-Google-Smtp-Source: ABdhPJy2SstgdHsoHw8bziXRNIusMJww0gaPyLSeDfbQlQp7wQWFUY6W/uhzFL0bv+O2ksVmafOoqkQyRuSJIgja3mI=
X-Received: by 2002:a05:6602:29d2:b0:64c:753c:c490 with SMTP id
 z18-20020a05660229d200b0064c753cc490mr9929673ioq.90.1650477832688; Wed, 20
 Apr 2022 11:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
 <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
 <xmqq8rrzr6dp.fsf@gitster.g> <CA+JQ7M9o+kZUgLkCq7aauCUwzZy6OzwKpyGQ1DxQyaL2jkJBSg@mail.gmail.com>
In-Reply-To: <CA+JQ7M9o+kZUgLkCq7aauCUwzZy6OzwKpyGQ1DxQyaL2jkJBSg@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 20 Apr 2022 20:03:15 +0200
Message-ID: <CA+JQ7M_Q_Qkh=+qziKg379e_xywQn2RBeAPNx29Dw6a5RXkY1A@mail.gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Long <kevinlong206@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 6:29 PM Kevin Long <kevinlong206@gmail.com> wrote:
>
> Hoping for some suggestions. I've also tried to save the file as UTF-8
> in both branches, commit, then merge, but still that did not work. I
> just want to merge it like a normal source code file.

Solution files tend to be of the "for machines only" variety.
In my experience, it often ends up being a bunch of csproj GUIDs
changing back and forth.
Consider just taking one of the two and manually fixing the solution file?
