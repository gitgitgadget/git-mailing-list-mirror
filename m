Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7C41F403
	for <e@80x24.org>; Sun, 10 Jun 2018 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeFJLQT (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 07:16:19 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:43731 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbeFJLQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 07:16:18 -0400
Received: by mail-qk0-f173.google.com with SMTP id g126-v6so11401356qke.10
        for <git@vger.kernel.org>; Sun, 10 Jun 2018 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7XdjMn/OG4bEilZBBF1Fg7SkuwxnGOGG29WwPq3phY=;
        b=sKNVZD95XXoPf0FsiwBwc21hksBQApuyEbVs7BhvaoqaWhXFKsrWWzSAHn/vao4Vuw
         tVcPqbYvCPb3s21kDk1TeQep3aqDnC21U/zFhIa2h3ymTPlSta8yjNSWnkKMNHiU8pUG
         3HAq4tJGkYEl5SScmX/bx1nzH/JPPVNShv3/Ni5XMiSiXJdjZMknCHSZV8kbmAfSR9zs
         kk41QSQoCc8dODuspn93+Scftb0bz4T4jsa7y6hz2ob5cY676UH5Ky7yn6xNr6F9+3uH
         JyJYOlLMv6C3dpVV475GJMg6NkSe30/upw54yx7SFeAtErqu96xZgg7eDdVF5iJ2LhAr
         2pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7XdjMn/OG4bEilZBBF1Fg7SkuwxnGOGG29WwPq3phY=;
        b=TAx5CrN+BR4WQXA7ZD3LoqXmwbvTNNLsch+AN4vlwWsr1LWUevA+mjimCDRji+ZqPo
         NlYwUsFFxDvDaNd6I7liH6aY57jVkNxk3tYTpyCQGlgaqmfTcwrshySVhJANdNGukqZ8
         do3e2mP3UvMYQd2NDLXCi2UFIPH+vMM35O4BCuyIDyvU9rTTWxS9fy4/UFukhV1o7N3I
         /2UKwWs8pRhHTpPX6KVR5s/h78offqdFCMyz8I+Sp668IBq6cvq4NeIANnEKLm1bN0bo
         sl6SWsnUbrATBT7dT7T5OXurr22Gcgh7j5NNEJJ1W2kgJsZAPNncB0Ooo7iCFmy4g+Ba
         SPdg==
X-Gm-Message-State: APt69E1fwWjt1XTvjq3f4gWnjV4aTfN4XZSdFs7r0++0rBhPrYO1jtqp
        QUivU5Wt1Nk5USQnVnQY0m7C7Vc7d5XBukAlyTg=
X-Google-Smtp-Source: ADUXVKJc1A7tQPGnGSMhLVHeMceeFSfVoLDnXpYFc4QuPk2jhnuVrCn3ed5HUTXb2kKs6tcF7d4nDbs0At+kj+5UGOY=
X-Received: by 2002:ae9:e602:: with SMTP id z2-v6mr11213821qkf.182.1528629378058;
 Sun, 10 Jun 2018 04:16:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3ff2:0:0:0:0:0 with HTTP; Sun, 10 Jun 2018 04:15:57
 -0700 (PDT)
In-Reply-To: <CANdbtkOj1jv2++2jSW-FGhPUu3eUyRxupqahKLNBeiDG46HtCw@mail.gmail.com>
References: <CANdbtkOj1jv2++2jSW-FGhPUu3eUyRxupqahKLNBeiDG46HtCw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 10 Jun 2018 13:15:57 +0200
Message-ID: <CACBZZX7WLihOWQjcwz+-is69GUzA5JaFDZxvUydk=crv1u_UtA@mail.gmail.com>
Subject: Re: can not send mail
To:     =?UTF-8?B?6Zm26Z2S5LqR?= <qingyunha@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, 845767657@qq.com,
        =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 2:04 AM, =E9=99=B6=E9=9D=92=E4=BA=91 <qingyunha@gma=
il.com> wrote:
> Sorry to intrude, but I can't send a patch to the maillist using
> qq.com and 163.com SMTP server.

Do you have a git with this patch: http://github.com/git/git/commit/5453b83=
bdf ?

It worked for =E8=B5=B5=E5=B0=8F=E5=BC=BA on 163.com, maybe it'll work for =
you too.
