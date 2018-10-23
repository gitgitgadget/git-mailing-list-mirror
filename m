Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C6F1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJWSiD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:38:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39125 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeJWSiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:38:03 -0400
Received: by mail-it1-f194.google.com with SMTP id m15so1335527itl.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu94p7GM9BJpNkRd7RO5hUOrpqNFe6wFt7m1rBXKwHo=;
        b=LB6o+xns3eYL+qH5C8pYnNJeJaZ66QREbJVc2fiofrLV8aICYZnaPlg9FPnxTzicB/
         iac+vP3grftz2ktcftdLb2E8aKhwVhWRU04tD0lkPuNTGzEcbnQUGy/rx65rhktj7+4A
         VorO+IHY2z7Iyq6IXLSk6FNaEZKHu7ZkUFUqv9zc9mTLhhee1DqmRkvvv8ESFVQH/MVs
         Rt/7STj5Q5XyOeYi2psBxdBvJyd4x8qSiopBri+FAzpfGor0iDjkF3MAsAFhLqJDZvDS
         juXV1A6vhWtE4M2C+j4TvufS/lP3P/RH2f2Oy9/LBJH23FWwL9jL5hnP28uE39pDZ/Iq
         Obww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu94p7GM9BJpNkRd7RO5hUOrpqNFe6wFt7m1rBXKwHo=;
        b=AlMZtLpLDWd1XAIFZa/ov0j+Ey5oG7I5FY6cVdpXLirKbhDPAJ4QL5cYU9LI/vpurE
         U2cSM4o6h7SrcPSKUOXvuTJcwnEF4FqtJtugIwU3VjQTu78ZRPkxYzasDq7wAfhwP+d/
         0xwAMdXu1c02daLnK5lRIzK4tcevrNY37Q8ZSIcF5Uvk6irXjKI3sGBu0uETroAoNuSz
         WFs98PgSLq6QAqluxAjup1I27ZsgWuaSz4FQeTvS6yTeIm73bRK6RHw4DgiM+OBcZ+if
         1RwF7kaQ5HJ9moYo6g+Jr3avLU/aUH1KmIrb7eWYlhiuNb0sFDV/F0IIdj0Tw9TIG5wn
         HQrw==
X-Gm-Message-State: ABuFfojH2XApGyZcflekV0ijpvKzzu/sKWpiMqguaJvsg9pFNrHvU0Nr
        SKfEJgJNerKkcsDb5gbo3sWgEdTVP5DbijdQ3fs=
X-Google-Smtp-Source: ACcGV629SV2jJlkrpNNsJCAlTfkR6JMSkF1kb5uUJ+RPL3yoLFYUO9871Vv9ZlrmqR8Kis/PwxGE5gikoRWG6p05fUc=
X-Received: by 2002:a02:4009:: with SMTP id n9-v6mr38873377jaa.52.1540289717765;
 Tue, 23 Oct 2018 03:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181016233550.251311-1-sbeller@google.com> <20181022173935.GG30222@szeder.dev>
 <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com> <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Oct 2018 03:15:06 -0700
Message-ID: <CAPUEsphThzjDTrJJHwvbeP4w=6M=xHWz+DZStfXS62=5tSCbVQ@mail.gmail.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19]
 Bring more repository handles into our code base]
To:     gitster@pobox.com
Cc:     szeder.dev@gmail.com, sbeller@google.com, peff@peff.net,
        git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 2:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The tip of 'pu' has trouble with -Wunused on Apple around the
> delta-islands series.

FWIW the "problem" is actually with -Wunused-function and is AFAIK not
related to the semantic changes or Apple (AKA macOS)

Indeed, I saw this issue before also in Linux (Fedora Rawhide) when
using the latest clang and presumed it was just expected because the
topic branch was most likely incomplete.

Carlo
