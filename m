Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284541F453
	for <e@80x24.org>; Wed, 24 Oct 2018 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeJXXXA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:23:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35344 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:23:00 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so6941262itp.0
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2lsgpCqAtaXBVcd0Aai/YnVTx9WiGDmsjXBN4JaFrM=;
        b=bIjknAu/EyjXeBFRaiiEBGnDwYPxogK79JuWAkRdvb9Ri7eKrxl6gjN6ONcAjcFMwq
         snO2Uhfc6rKMhKoUTl+HzCHB/xGQbVgM0tAelTpfRQV+rHLJAO+U/KUpbCkyDa+GRTp9
         x37O8x/ZGYaEtwW67zr8A6c8V0aMU16ccbZ7kw1Gdhy/XYZlk38UAldrnZ60nk2W3LEr
         pnyC1DVD1Og3W0GIrd8fNwQbUyyHSlBu/Qkt8S4daoRo0G7e5b1QF3+cwPB17EvXEKTn
         aTFh+XptxCPJv/432B+TAwUDPb1NKN2kom7obKARzzCNOnAhZFunswLPJCX+9ydoeqwO
         y84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2lsgpCqAtaXBVcd0Aai/YnVTx9WiGDmsjXBN4JaFrM=;
        b=HkoIxXNOClUia+OrWCuzQoTBzJlt4gcnIydnV1UpsKYUXOW2k+TQIItt2dh+dz4KjK
         k9ozH0+bx7pLLFjAw7Hi6h5Xl8yzeauYvS7MEcDMywlOG5MVVXMjmFALkxopXD0hnVP1
         NOvRmQyo0EMrkpgYnJTLmZRKgQBK//CtA8zwFNwYROv6GGPyWXnjhXBgVJ+i0eQpFXPd
         MpU3K8Qyf7h8RS3lI/qrj4fE+acH1O5uj1YqQt+LzML+dzYLidzXEHwdCybNxQhamDAe
         6UbndQFYk5pG9fRQjgJlHAREdlPA/tt03FUApgHrKb0B9qBnDi2PpDw5iF4dVyD1YQoN
         JWQQ==
X-Gm-Message-State: AGRZ1gKZLGH79SJnFngT347/AkCIBBbJ4c4Edg9NSBcDqcf5ezXQ0tDm
        TGhduQtIa3ItzLpv132ilbF8C+RfjW7NgwBBT2E=
X-Google-Smtp-Source: AJdET5fEEhHwf+AnWK1Ce/dQa+aDX/98YKQTrlBZDUrylEWCcZj6p+AvrFD+JTE9T7n9hoWIe+61a/e2sYiz4cYAvl4=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr1724239itc.123.1540392874051;
 Wed, 24 Oct 2018 07:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-3-peartben@gmail.com> <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
 <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com> <xmqq8t2oqchi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t2oqchi.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Oct 2018 16:54:06 +0200
Message-ID: <CACsJy8Bkx5QS_4QV13FHpbZmhO=0oc3_BsBPQKdtjq6aouALFA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 4:56 AM Junio C Hamano <gitster@pobox.com> wrote:
> How we should get there is a different story.  I think Duy's series
> needs at least another update to move the split pieces into its own
> subdirectory of Documentation/, and it is not all that urgent, while
> this three-patch series (with the advice.* bit added) for "reset" is
> pretty much ready to go 'next', so my gut feeling is that it is best
> to keep the description here, and to ask Duy to base the updated
> version of config-split topic on top.

OK. Just to be sure we're on the same page. Am I waiting for all
config changes to land in 'master', or do I rebase my series on
'next'? I usually base on 'master' but the mention of 'next' here
confuses me a bit.
-- 
Duy
