Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45F1C1FD09
	for <e@80x24.org>; Tue, 30 May 2017 09:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdE3JCT (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 05:02:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33109 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdE3JCS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 05:02:18 -0400
Received: by mail-it0-f65.google.com with SMTP id l145so9048822ita.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 02:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jwxGhP9CcYYvI5ddE2GOtSrd9quKuuJxY4s5VefFESA=;
        b=nR9tY+7pmWW1Or5Zp2qmhWKLwEojL8y0sDk6KQd+uHY4eGv85tl0WPzatx1QfipuqV
         GVrSHS91NoLySyRqlNMw43R3s3k3L4RkySZ7XD1nXHIMLi2Q8D+pmzaQ5RW/YMTqPV1i
         eSJDhcFvJsTjyhMHhJ8CP/okg7+M9k7H8eOlwfc2twPIRKq/0N2I+9fymJ/7Xr63lV7t
         4MOiXw6K/+cpQb1eosUzN4DSzXwWumhaRaHmtO/fQ7kNdjrmNmce65ODgBwqgrDH9GuP
         uu481ZJRlXTWLqlVSq74gpeeCxVUkGrm1FUXB3oMDLKL6sM+Xxg8F5aczrwCLjEVz+0C
         XEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jwxGhP9CcYYvI5ddE2GOtSrd9quKuuJxY4s5VefFESA=;
        b=HRxkmqUYFRIYZbwsXIcbr2ZAK2bUn4rmYKkLmCgfLe5PhhWJ2RSI/XOSqP9mWjo7Xk
         suo7FQUVdgHLt9czDk/2uQPQ+0SiORXTI7E4n3dLja8t4cRt4U4vSvliTOgL1F4h7cW5
         qsfwYDPa2Xofto8CmCA4a+TzcXhZdpWYit/zum3SnNs3O+EZWIHR8ewBfK7edEQ43yOs
         MhXgcfqcOjja1KbMHQsOzzM4lq6BMe8Qrfzacoh6L+wGJ6EkrZJT5UgYk0TwFT5Iuyaq
         C+SRIpEBuJV4W4H9qBRhd3vA7KHxP3zhR1eJD7yI6VW3njhXC5dFT3AlF7PBOCT9jx6H
         aIeg==
X-Gm-Message-State: AODbwcBO+CHrJqHO4NM5afwPjHUHY2Osofv5hzvkyfSLoEJ3oigqD08s
        oyg7Fu/texTcKuSz3LyX2D2sLvPOSg==
X-Received: by 10.36.37.78 with SMTP id g75mr781001itg.94.1496134937198; Tue,
 30 May 2017 02:02:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 30 May 2017 02:01:56 -0700 (PDT)
In-Reply-To: <20170530071244.32257-2-szeder.dev@gmail.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170530071244.32257-2-szeder.dev@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 30 May 2017 11:01:56 +0200
Message-ID: <CACBZZX740rcQKnfkRXgn0+fmeUDaWL-Kz5WzKeyUvBhXWPwPhg@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] Documentation/clone: document ignored configuration variables
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 9:12 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
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

We should add to that: "Instead supply the --mirror and --no-tags
options, respectively".

>  --depth <depth>::
>         Create a 'shallow' clone with a history truncated to the
> --
> 2.13.0.35.g14b6294b1
>
