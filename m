Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE4C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbhLTROO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Dec 2021 12:14:14 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33422 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhLTROO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:14:14 -0500
Received: by mail-pl1-f179.google.com with SMTP id y7so8651170plp.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=46D0DePFt9/l/pqYA1+oIJemKYzQ7pPhXYGFuna+9zg=;
        b=St44ttL3qJ7KyMkI5MxJUI59KjgJO9nJ4zR793PnqzX/FrLTicJd6ufMnW33jMMBdO
         gnVFAsqGFrbk0ni/4jjowSa4gtRaSDM3EDN/BOOqvZjst975wtZ8SxaCAXDq8SFVWgiq
         6bY6LCMsrG4W/CKBwIPuth/vso+UALyf1R3zwdg6SZifDzkVH+8k53u9RyGAjgBDP9kl
         0UuamMQ5aP1eJxeTo2bu90wxnVResvdITyOujyg/XpJLcpEAwElLCz8c8cXcH1ve0MWc
         oXleQKdTR/4aFlP1WrhV52DmpErBWgJ6Qq3ztvxgowT5SJAmdJuEj6o2S9czkkGZGvnP
         jPzw==
X-Gm-Message-State: AOAM533IId+vr1Q/af9VRgCTEHKcX26DK6w1K0C4dEIvmFhpTyGQWfIP
        rwOxFu5fJdZKjTK5hbymFphQriD47cybdFcEV8UWjazlnd7lxA==
X-Google-Smtp-Source: ABdhPJw7q6LwjLTPd74trLwvsXWUmq3WRbgkzj4S5ricRUNiCulzQyO6CrhYGkpf87KEu28lutzbV+9IK9vtCVm2Mzo=
X-Received: by 2002:a17:902:b942:b0:148:a2f7:9d72 with SMTP id
 h2-20020a170902b94200b00148a2f79d72mr17929338pls.145.1640020453559; Mon, 20
 Dec 2021 09:14:13 -0800 (PST)
MIME-Version: 1.0
References: <YbvBvch8JcHED+A9@google.com> <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
In-Reply-To: <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Dec 2021 12:14:02 -0500
Message-ID: <CAPig+cT+NshUMS+BNLKDMuwOEXKEzS3Ve=hK3kCYEBvJNzXuxQ@mail.gmail.com>
Subject: Re: Review process improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 7:27 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Whereas the only cases that really applies to in git.git (and I think it
> might be useful to have a MAINTAINERS for these) are:
>
>     # but not all of po/, see caveats in po/README etc.
>     po/ -> https://github.com/git-l10n/git-po/
>     # Pulled from their respective upstreams
>     {gitweb,git-gui}/
>     # Anyhing else I'm missing? Maybe {sha1dc,sha1collisiondetection}/*?
>
> We should be leaning into helper scripts like
> contrib/contacts/git-contacts (and I'm aware of some out-of-tree "better
> git-contacts", but have not used them myself).

For completeness, the granddaddy of out-of-tree "better" tools is
Felipe's git-related[1], which is maintained and more functional.

[1]: https://github.com/felipec/git-related
