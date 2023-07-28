Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD45C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 02:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjG1CNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 22:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjG1CNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 22:13:46 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8282D6A
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 19:13:45 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690510423; x=1690769623;
        bh=BI33iYLOTq1Af4GIZHoMYBne4YSJuoRRO95EJyaamg8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eZRHcyM3oMX9fG4UsJqaN3Aq2mZeyRu7tyGtfVmCkUtQ3ieWwTbRA3igwwUczdnCN
         Hmpn7aQbT66eZ+qLgocBaa7NBRNdELfrC6oHrGTb8h/V6BwSi6uqgX4sC/OY2G47uA
         rKfc+lgHQapfZiOv2QiV2hD+KBT8h9Ax0GOL6Jh9hPb0CHweC2uJU8m9tdDtOVu6YP
         0nl3t369X0EnXnp6CZwdalMj8I15W8Vu4kfBBOzVCE06muwOvUkGHR8DtdzmBCSb3p
         nVTlZeNqlrO+i6EynbG3QkxeNAi2nh8+q6L8TV/6yXHWeA8FFld9ljh/J2QP1MzAPG
         DgrfbnhAkxN8g==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2023, #06; Thu, 27)
Message-ID: <dnydxyrjutreobayldz5ystptwyhafaebhycm2ymhj7nhiwbyo@ubfnxgbnf7cz>
In-Reply-To: <xmqqh6po95a5.fsf@gitster.g>
References: <xmqqh6po95a5.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/27 06:46PM, Junio C Hamano wrote:
> * ja/worktree-orphan-fix (2023-07-26) 3 commits
>   (merged to 'next' on 2023-07-27 at e475016065)
>  + t2400: rewrite regex to avoid unintentional PCRE
>  + builtin/worktree.c: convert tab in advice to space
>  + t2400: drop no-op `--sq` from rev-parse call
>=20
>  Fix tests with unportable regex patterns.
>=20
>  Will merge to 'master'.
>  source: <20230726214202.15775-1-jacobabel@nullpo.dev>

Now that this patchset has been merged to `next` I was able to confirm
that the Cirrus CI builds on `freebsd_12` are passing again.

source: https://cirrus-ci.com/task/4872784707321856?logs=3Dtest

