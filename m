Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B39E215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 20:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeD3UqE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 16:46:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37742 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754120AbeD3UqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 16:46:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id b23-v6so13941730lfg.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YIwO1cyXbUGqWPUuGA0mC/D5SHbvp6ajoweozbUC800=;
        b=olQLCrcYULjgVwfhA6qII4UjkqtS69E7XQGKMf1hmVRbPeVnJD2fs7iD+4RRTPQJI2
         tyJeO+YfPRtll1P1oXynVLFqF4cRO5xeTL2fsjXp2fmUZ3gGMKEay6y9ctxJwOBmBmYa
         V6/NZb7v+aUsPDhZNW6a9DPf4TeweBekpviOJ3CqALMFVLsU2isveX6rx0GGZrV8EcyR
         Rs3Ws0BZuu1qPFEk6MsUiv8YAO1OJm6c5NuIWUA73YRpWPkSfDarzVxp10QXrmcbLPPw
         uxJcjBpPgZTCsasPVt+Z6haSXryQNAsTplsMumQZjPIawf+ID6nWqDs+zHf/eT7kHsAy
         HFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YIwO1cyXbUGqWPUuGA0mC/D5SHbvp6ajoweozbUC800=;
        b=kNVfUXTNyccz1AyGguWkd7+i/QDHQAeKleDOdscu/i+OMhDpDz1sRRFg4KXsbkFJy3
         WV71L+fwcYJxVA3ypmGwBvlDkeHSeiyI8GM/ArGbjVxcXzl2VVS2s58zSJICN9BpGas4
         MC4zcM4tsa0Z0yv9yYUNYVtuRVkk5bPgx9DAjWlhpGltUetMZ5LBZGNppStWGWkJeJ2M
         GzkLSggjc9ah3pVVeyEwJ5U6XaOlLqE1B0k3lIzKS8H1bFw7frunPI0J4yrHX0GzG3gd
         di2aBV9K7ptYdwDF9uUq2hvqpzJVHa7vCapYgvioE6fd552lnLizueis9UJH1Z1UmKOS
         pIdA==
X-Gm-Message-State: ALQs6tA/XbJmglI0VBv3nymPaz4rHD0Dv4QrCwA41FdP6e/vZUDuczq8
        g+s01x9yJrPW6KrXrejaDn17uJk79iWinUgQNMI=
X-Google-Smtp-Source: AB8JxZq7XHAPgEum9IJRZ7NF5JcRXvTIgc1Yr1GcO4TP0aIKuzofK0jXQrgRPVTubyVmZK9feVBkaR++nR+qU6E0TQs=
X-Received: by 2002:a2e:1082:: with SMTP id 2-v6mr8836048ljq.9.1525121161696;
 Mon, 30 Apr 2018 13:46:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.146.199 with HTTP; Mon, 30 Apr 2018 13:45:41 -0700 (PDT)
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
From:   Avery Pennarun <apenwarr@gmail.com>
Date:   Mon, 30 Apr 2018 16:45:41 -0400
Message-ID: <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 5:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I think at this point git-subtree is widely used enough to move out of
> contrib/, maybe others disagree, but patches are always better for
> discussion that patch-less ML posts.

I really was hoping git-subtree would be completely obsoleted by
git-submodule by now, but... it hasn't been, so... no objections on
this end.

The gerrit team (eg. Stefan Beller) has been doing some really great
stuff to make submodules more usable by helping with relative
submodule links and by auto-updating links in supermodules at the
right times.  Unfortunately doing that requires help from the server
side, which kind of messes up decentralization and so doesn't solve
the problem in the general case.

I really wish there were a good answer, but I don't know what it is.
I do know that lots of people seem to at least be happy using
git-subtree, and would be even happier if it were installed
automatically with git.

Have fun,

Avery
