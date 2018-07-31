Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFEF1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbeGaMnx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:43:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34469 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:43:52 -0400
Received: by mail-it0-f68.google.com with SMTP id d70-v6so12057722ith.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qcmloy0ZtEHtUlrgBMZUeKxmMw6O6nGxH2Ki6DrLMvM=;
        b=Ks2WQUqyEZ2EqYGDJGcglVoQb+GJeY/dUpD0+qpE+CwJbXhuKkcozpnBRicJaZ9pac
         OsRu5NV+ruWq/bi49HLIp/5pdvfdmlXTu5TcXNncfnJadNGivsiLKFJ/HmJZAAqz/dPb
         aqjW0co9Z2cxTRMxBtsxzbTMP/QmxPCPnx/KFcMvShHn+PhcQTBqJxhxk8DpaldexJAB
         xCDwW4/1FXCcZIBkdDmdwMu5JJ+MdtoLZwtvh5lbK2ihtpM836QXJIOJbROgPWvbcqNs
         CWOgaKFI57/XBy2JTrTAYVysBbe0puZpZlWmX0uRL10NredVPPT3tPIN5XnFkjFTcucB
         zdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qcmloy0ZtEHtUlrgBMZUeKxmMw6O6nGxH2Ki6DrLMvM=;
        b=k3TooVJYDVBrTbnk7v/hUjHsGDDPHxbCx3XBZEQTB+gPReH47NNtgycnTTGHnNXoMy
         DczdJlZVxcaVlqxU4DBpwpYpptgouQVaYL6dxQ1dPUaoTToz0ImKH4F2pZ9cUQwY3HNI
         EuESjbIqDn3OxIch9f5Ze+7HPMz7WT5csoPe80M5rR1i0XyPF7pW0DnmhPy++5d2SpjR
         3ckol2bQK3gRFc1KPWO1WnJwBXp6ufYJ0dP1yLeuaEik5owSc8Tb3VDIqX7n6Y9DAFQm
         IYJ9pKMqGUt6HKB7a+EbP7PLHmdASbq8l6uQ5AanbDwKFBIbZQ9k1lRxQBA+FONw6+j2
         rjkw==
X-Gm-Message-State: AOUpUlHHGGAvP+h9zz6HhpBspimXPzChBdonFq9OaAN37FqOqSO4fbio
        26aTNi3RmYJqEr7TfAvHyTBI045b1ykdZEONlKhDGQ==
X-Google-Smtp-Source: AAOMgpdpk4a6aMRbZrO85hegbrQA96Q7nzu5w2mQjbW9LR2DFN10MHGYqCjqp44JofZrrRnkiAKarx+/xR+PzWtsj/o=
X-Received: by 2002:a24:282:: with SMTP id 124-v6mr2477736itu.151.1533035045649;
 Tue, 31 Jul 2018 04:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180730123334.65186-1-hanwen@google.com> <20180730123334.65186-2-hanwen@google.com>
 <xmqqsh40e72x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh40e72x.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 31 Jul 2018 13:03:53 +0200
Message-ID: <CAFQ2z_NL+8LVmv+E4osq2+nx+qVE4P80it8vjLUwib=HJ5k4Lg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 11:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> > + */
> > +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int=
 n)
>
> I'll make this "static" to this file while queuing.

Does that mean the patch is in?



--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
