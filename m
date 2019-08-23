Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1C61F461
	for <e@80x24.org>; Fri, 23 Aug 2019 07:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfHWHUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 03:20:43 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36764 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbfHWHUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 03:20:43 -0400
Received: by mail-ot1-f51.google.com with SMTP id k18so7938006otr.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ui9PhJxl7Bo2pI0E2rsc1ZM7c4SIx5/O+Fi+pOKJAUM=;
        b=EL23oJUJ12ugK6AwIryKZ5XLcHVRICXcHlzgjmT0En/DrSk9LAQdHXdBIvYmRgCZed
         H63PPFM8FueA1Kz0Qj2Qm+gr3MDcmEkgKGoxQ9z5+U6OcNbCOYUVGo4ZcHdq4UVVIVcP
         xlYvgOOflXW3029IcOdkeId2ARt19+X5b+4SVb2rYLm73ra6mBx9+KJaIQTd5yWrGqAr
         Retdb0wohl/8qdu+MsCxABN0hpQ2xBe5xwZQKak6uY5xtXrrAHlmrnMcBOYN06+QwO8+
         QujMi6qqn5BOucmJ4R8+hAkt3Wrj8pH1wQm0iBtirCEJ6qvcky9QsxCO5Pe3Jb+oz1xK
         ys2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ui9PhJxl7Bo2pI0E2rsc1ZM7c4SIx5/O+Fi+pOKJAUM=;
        b=JvKUu1PZGCxvFdQtxuDYscSEzPDtHoVaUpOIxgQdqfv3tipAknrc8XsjS8mXPxwilQ
         JzsX3PSGlx3VG5HTkBOfASDtMPfp90VH0TPPguyBu1E8MEc3KnmMsHyVA9BcS8A3apco
         Pa6y//1DmA8yPpZRZKB9HhkmOnhZKIpMVM8gZKgG7Jy6kVtNk/OO0L1RAXKjz6n4nslY
         PYp8rGVjdcPZH7UGiSSI9seJ0O3yX9BIlfgdZDD8+EodSdoEpKH6hdzo5iH3aJpqtW+1
         zJ//C22eAcUZLcBEnZ+PcKgz4Hdx9IWYvU/Cy75nnzWX6tB7ZPx0KaBuuZAif8D3zxqK
         RJHw==
X-Gm-Message-State: APjAAAVHjZAt39r4Y3Hebn9Nw9M4ERTsM7XRL8TBlOn19TkSbjvApkqi
        SqYWi0iNcDm/4a51TxRfTkfaC0yYYVj7gBh1lCsDiQ==
X-Google-Smtp-Source: APXvYqxxxNDauzlj+oGlduWm9x1zYh6PL7akNLDU3BihLWvFQ5Sr2klV740nm2VGLCzrm7/CTl4Qkgnj/ZjpfGuXXWE=
X-Received: by 2002:a9d:7087:: with SMTP id l7mr3073919otj.281.1566544842108;
 Fri, 23 Aug 2019 00:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <20190822150614.o25g37pwfcaos2zn@localhost.localdomain> <xmqqy2zlp3qn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2zlp3qn.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Date:   Fri, 23 Aug 2019 09:20:47 +0200
Message-ID: <CAGV3M54RZn9pWe=R-qfm0UCU6TOhLc7-6H60Zf03gOe5Sq6wzw@mail.gmail.com>
Subject: Re: [BUG] You can't have single quote in your username
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
> The logic there exists in order to remove cruft around the name on a
> typical e-mail header (remember, most of the very core-ish part of
> the Git was written and got solidified back when the Linux kernel
> was the primary client of the system, and many commits were created
> via "am"), e.g. sender's mail client may send something like this:
>
>     From: 'Foo bar Baz' <my@name.xz>
>
> and we do not want to take surrounding sq pair as part of the name.

I see but _standard_ rules to escape characters should apply as I
understand this. 'Foo bar Baz\'s' should be allowed as it should "Foo
bar Baz's". They should resolve to the same name too
