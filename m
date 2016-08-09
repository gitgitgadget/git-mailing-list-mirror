Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E071F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbcHISmZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:42:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33756 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbcHISmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:42:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so4936015wme.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:42:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lGlACanGCCCNtqic2JhYHy+nXmVqPTZVIYiq1S4DjQg=;
        b=GowMoMNX2QOw5rhzr9K6lhT8JPC6s2t1lakvwHh9OJ3rCJ1BogmegHgoqMU2lmko+e
         761bICyB4rp9BU+9rLG7IFYQD+knGlVU/a4dsOnkLS4kQLtVRSns3Hx83Ps5rGHdmp4U
         qusfqTyMWTKzzAvdu+5hLkcxKpRxAlD298BJ7BEIjGbuI4eox+QQHWXXTesJEEvTmx5n
         9G2oy35Ou2dMGz1I0dq6oP6T6tJyZdXJ2IgiEt2KRO3nzrWbdUK6N8eWpdy18hSqkH5U
         017lzBrHVcYc0hl2DwNn33rxKXAT5eWLgjB2pgfDpLz3E8wEi93jqjjdvKhJH3KcsV0K
         +4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lGlACanGCCCNtqic2JhYHy+nXmVqPTZVIYiq1S4DjQg=;
        b=KZHTR7JfNqo/SaRgCV+loJoGScGwPxG0wo/SxarCOr0jpDcgrSL5Pe4sYUAUONeSkx
         tUCQiOf28nxSYCYe+BfRofig0fV/E2zA6c1SWCFKpT7o/WwVcraByE1udkv3mtSJy50j
         AXmLBQYK3qdKyWeRGB+na665p3TlOEgn2PMLr2G6cP+SLdl1OwrRYxe7Sz7GaJk2XZ4K
         OlzzaggnpEjz7D1CESpOQ8syD//CjHWrvW0WzDvQfPPFaLC2mqByCyykKnqvQrZYl8F3
         ADUzo55ogXODjH3vIWSUvEXJBD7t79/nl6LepO8jEqwj3cpulL0S/ipuTQI7lZBjHM0r
         eiQQ==
X-Gm-Message-State: AEkoouuBCaflu854h5CaAGY0Xhq0qEobO1o9NCC2DmiysqAV7dScJmRj2IRQhGZ6j28IRbps39f3L1OBcUXlfg==
X-Received: by 10.194.104.197 with SMTP id gg5mr89911742wjb.6.1470768136701;
 Tue, 09 Aug 2016 11:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.2.111 with HTTP; Tue, 9 Aug 2016 11:41:56 -0700 (PDT)
In-Reply-To: <xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
References: <1470732818-408-1-git-send-email-ville.skytta@iki.fi> <xmqqpophajqa.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date:	Tue, 9 Aug 2016 21:41:56 +0300
X-Google-Sender-Auth: JcrYC1eaVUQiUYKSjtx1HTgIa9Q
Message-ID: <CABr9L5DX9uHVkNMY4ihLcQtVoOLVXJh-EDA0iiOD9ffPkJSO-g@mail.gmail.com>
Subject: Re: [PATCH] Spelling fixes
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 9:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> There are two "commited" you seem to have missed, though,
>
> t/t3420-rebase-autostash.sh:    echo uncommited-content >file0 &&
> t/t3420-rebase-autostash.sh:    echo uncommited-content >expected &&
>
> which I'll queue on top of this patch to be later squashed (i.e. no
> need to resend the whole thing only to add these two).

Thanks. https://github.com/client9/misspell/pull/61 :)

Also, there's SSTATE_TRANSFERING->SSTATE_TRANSFERRING in
transport-helper.c, maybe you can squash that one in as well if you
think it's fine?
