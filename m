Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B33B1FA14
	for <e@80x24.org>; Fri, 26 May 2017 14:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940564AbdEZOBu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 10:01:50 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33541 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdEZOBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 10:01:48 -0400
Received: by mail-ua0-f196.google.com with SMTP id x47so763675uab.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fo6Ae0t9pGoQOjekMkIjIeCKvqBUCZbbBehs0PB0f5s=;
        b=FHItiyRDHHXszflIhHA4f04kTIrkEcdwsQR87E7UXxasXyO35uRgPqtT55HpC1y4w4
         dOvmWGG1AlVQhKCkCciFcfIZqaMM4EbQNGlrWRaKbsh2Fuf45+iyso0kkFQe4lR/6WUP
         gbtpMz9geis4vFuDGWlyzSGMZankuNzdvGR0dySHgpI68aFxkwzmjd86tTPVmNVz6j/3
         7f9tSr/InkD7n5a8x2/tJOQS4xq/BNahrJnLtFmUB/1UaO3DP88VE/BHsBMdJaUWxq+I
         Okyq459ovvfeHU1oXnqZNo+YL49iaT02Pv7AsCDnm4UQpUAgzD2kQVy/kq42gCeIHibR
         n0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fo6Ae0t9pGoQOjekMkIjIeCKvqBUCZbbBehs0PB0f5s=;
        b=X2DfPxSyERDnvfSOFCktIR0utzyBgtM0Rr5OBYI7rXfkY/DXSX692eVWBd1kKAwGSx
         4f+3kloVd+AmxrRqDDG86KxlIrLIHS+aeKLU0sBv1QC4OKj4ZawYJ4KDPgeoFv8F4dhn
         qysREkPu5hdbiRq8RSpuQ1dNyqjZ8J5uzDWuz+UWKkbFXYmMh8MBdKYPSmg1PHASdkDm
         o+VcplSrXqSoab0ZTYPQRksJydLseDOWbqI1pO1GgXVmuKxx4UIL1J537iYA6bj35DC7
         uYXpXHszjw0yX0DO//dnPcRc3Q1cIa7t0GMhpDNgX6M+0f2raI0fbaZhKjTnn+k/jQyP
         wdpw==
X-Gm-Message-State: AODbwcDFoWBHiyW7uTq1wrGdV8roG6a6jZc3d/PO5V+2aw0Q4Z66oi/2
        Vbvzn3BrIW5yGoUicNRsxFiGuUOuBA==
X-Received: by 10.159.35.22 with SMTP id 22mr1184367uae.134.1495807307479;
 Fri, 26 May 2017 07:01:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Fri, 26 May 2017 07:01:47 -0700 (PDT)
In-Reply-To: <20170515110557.11913-3-szeder.dev@gmail.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com> <20170515110557.11913-3-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 26 May 2017 16:01:47 +0200
Message-ID: <CAM0VKjkSMnemwPbFihXiQui3wm_wYmQeQmgYrFs5bfsH1jMg1A@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] Documentation/clone: document ignored configuration variables
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 1:05 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Due to limitations/bugs in the current implementation, some
> configuration variables specified via 'git clone -c var=3Dval' (or 'git
> -c var=3Dval clone') are ignored during the initial fetch and checkout.
>
> Let the users know which configuration variables are known to be
> ignored ('remote.origin.mirror' and 'remote.origin.tagOpt') under the
> documentation of 'git clone -c'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/git-clone.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index ec41d3d69..4f1e7d4ba 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -186,6 +186,10 @@ objects from the source repository into a pack in th=
e cloned repository.
>         values are given for the same key, each value will be written to
>         the config file. This makes it safe, for example, to add
>         additional fetch refspecs to the origin remote.
> +       Note that due to limitations of the current implementation some
> +       configuration variables don't take effect during the initial
> +       fetch and checkout.  Configuration variables known to not take
> +       effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.

A few notes to this patch, because I didn't like that "known to not
take effect" expression, and looked into how some configuration
variables are handled during the initial fetch and checkout.  Far from
comprehensive, but here they are anyway:

Concerning the initial fetch:

 - Configuration variables influencing the refspecs to be fetched are
   currently ignored.  These are the fetch refspecs, of course, and
   remote.<name>.{mirror,tagOpt}.
   This series makes fetch refspecs work.  The other two are mentioned
   in this patch, and are less urgent, because their functionality is
   or will soon be available through command line options (--mirror
   and --no-tags).
 - remote.<name>.url is strange.  It's not just ignored, it's ignored
   so much that it isn't even written to the config file when
   specified as 'git clone -c ...'.  Nonetheless, specifying it for
   'git clone' doesn't make much sense in the first place, does it?
   So I think it's actually good that it's ignored and it isn't worth
   mentioning it in the docs.
 - Some fetch-related config variables, e.g.
   remote.<name>.{prune,skipDefaultUpdate,skipFetchAll} or
   fetch.{prune,output}, don't matter during the initial fetch.
 - Other fetch-related config variables, e.g.
   fetch.{fsckObjects,unpackLimit}, are handled deep down in
   fetch-pack and work properly.
 - Transport-specific config variables, e.g. url.<base>.insteadOf,
   remote.<name>.{proxy,uploadpack,vcs}, or http.*, if applicable, are
   handled in the transport layer or remote helper.
 - I'm not sure about submodule-related config variables, but there
   are command line options for that.

I'm not sure about the initial checkout, in particular I'm not sure
how many configuration variables there are that could/should influence
the initial checkout (or any checkout, for that matter).

 - core.autocrlf works properly, we even have a test for that.
 - filter.<name>.smudge is read during initial checkout, but I'm not
   sure whether that should do anything, since no attributes files
   exist at that point.
 - I glanced through builtin/checkout.c to see whether it looks at any
   configuration variables that clone doesn't, and while it does so,
   it seems to only look at variables that are either irrelevant
   during the initial checkout, e.g. 'diff.ignoresubmodules' and
   'merge.conflictstyle', or are submodule-specific, and about those I
   have no idea.


Like I said, far from comprehensive, but I think at least the fetch
part is well covered.
