Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFAD1FA14
	for <e@80x24.org>; Fri, 26 May 2017 16:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944197AbdEZQXB (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 12:23:01 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34368 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754563AbdEZQW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 12:22:58 -0400
Received: by mail-vk0-f41.google.com with SMTP id y190so7941691vkc.1
        for <git@vger.kernel.org>; Fri, 26 May 2017 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y6k7jUtkQ2oJKAI6C2cgmlxsq7H+Ky285dTUuLv9SVs=;
        b=JAXD5Pp5B+zfwRmAx6eAgGm6r9CSieR//PM/lWaOXmyN31YcmdeSYsa7KcMacBNuGd
         hzvQTjurbZPmE/kuPFjgV59QVgM5JTX9JSKOy4QbS8CiIvU3nc+BpQkiDIXAL0Pj9+lu
         0zUEefzqFJNOPTDWZ/XPbLQ8e4ijqJjWVGe1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y6k7jUtkQ2oJKAI6C2cgmlxsq7H+Ky285dTUuLv9SVs=;
        b=ta8j51JCduD5Uhoyd5yRxooOxl4YC/ylzOb7nO+zv1z4ZgWilm+1V6J2vMJdQwHkoY
         F5tJpwAqnAyBzyGPCBgsrL4wDgdxd25Z2moxq35s2zrVOyGYDxAnRMUG+UCLBiVCKjo9
         PU9fFFAJKV16eAmxXQQnTSbRaK/KY7DIkHyMDaS0wmNn4ATZDnJcdc4LEOPqmy/HE5Ng
         9AwM7JiLfHvIlK/7uTa9VLtv5ySnneAIU4IpjhOBTE8xxmUQu6SWh9t65YU4jxDDHl9n
         Qem4xdlgDN8rwbXCMxfZ3mlpTsjchahHVsbBa2lSfSxd2npUGOPXEh2sJ2BM+Yevx3f1
         fnLA==
X-Gm-Message-State: AODbwcBUK+Fd45TmGTqntMSW+DDLNnFt6gvWL7oROQbqNnUTVEqiDXXc
        O1PvPXnEZdmFvyvYXzLUWrf0lO5lxnCK
X-Received: by 10.31.114.66 with SMTP id n63mr1021531vkc.59.1495815777847;
 Fri, 26 May 2017 09:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.33.227 with HTTP; Fri, 26 May 2017 09:22:37 -0700 (PDT)
X-Originating-IP: [136.30.24.42]
In-Reply-To: <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net> <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
From:   Elliott Cable <me@ell.io>
Date:   Fri, 26 May 2017 11:22:37 -0500
Message-ID: <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
Subject: Re: persistent-https, url insteadof, and `git submodule`
To:     Jeff King <peff@peff.net>
Cc:     Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi! Thanks for the responses (I hope reply-all isn't bad mailing-list
etiquette? Feel free to yell at with a direct reply!). For whatever it's
worth, as a random user, here's my thoughts:

On Sat, May 20, 2017 at 2:07 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 19, 2017 at 11:55:34PM +0200, Dennis Kaarsemaker wrote:
>> > On Fri, 2017-05-19 at 14:57 -0500, Elliott Cable wrote:
>> > > Presumably this isn't intended behaviour?
>> >
>> > It actually is. git-submodule sets GIT_PROTOCOL_FROM_USER to 0, which
>> > makes git not trust any urls except http(s), git, ssh and file urls
>> > unless you explicitely configure git to allow it. See the
>> > GIT_ALLOW_PROTOCOL section in man git and the git-config section it
>> > links to.
>>
>> 33cfccbbf3 (submodule: allow only certain protocols for submodule
>> fetches, 2015-09-16) says:
>> [...]
>>     But doing it this way is
>>     simpler, and makes it much less likely that we would miss a
>>     case. And since such protocols should be an exception
>>     (especially because nobody who clones from them will be able
>>     to update the submodules!), it's not likely to inconvenience
>>     anyone in practice.
>
> The other approach is to declare that a url rewrite resets the
> protocol-from-user flag to 1. IOW, since the "persistent-https" protocol
> comes from our local config, it's not dangerous and we should behave as
> if the user themselves gave it to us. That makes Elliott's case work out
> of the box.

Well, now that I'm aware of security concerns, `GIT_PROTOCOL_FROM_USER`
and `GIT_ALLOW_PROTOCOL`, and so on, I wouldn't *at all* expect
`insteadOf` to disable that behaviour. Instead, one of two things seems
like a more ideal solution:

1. Most simply, better documentation: mention `GIT_PROTOCOL_FROM_USER`
   explicitly in the documentation of/near `insteadOf`, most
   particularly in the README for `contrib/persistent-https`.

2. Possibly, special-case =E2=80=9Chigher-security=E2=80=9D porcelain (like
   `git-submodule`, as described in 33cfccbbf3) to ignore `insteadOf`
   rewrite-rules without additional, special configuration. This way,
   `git-submodule` works for ignorant users (like me) out of the box,
   just as it previously did, and there's no possible security
   compramise.

Just my 2=C2=A2 =E2=80=94 thanks for your tireless contributions, loves. <3


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
