Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607EF1F462
	for <e@80x24.org>; Tue, 28 May 2019 21:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfE1VBk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 28 May 2019 17:01:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46727 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfE1VBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:01:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so200596oid.13
        for <git@vger.kernel.org>; Tue, 28 May 2019 14:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VCxCm0S0QqqBlsZ5MSsdPbS5WHWeyxdoyQQ8JktA9oE=;
        b=CGjqVmoYUl/ifzHR/ztmj1ikxyiRZ2JlvPBSvihHrgzf7wNYweGml/pB0x0zGy34Ge
         xuVlW42zZyUHIALfQ/NLGqi1XUwF6lIETxPkoHxdSTKuCLEKaLFExv1nR9/AUwFmegP9
         0D36Ich7RHOmrWklVoayp8po3wvbD7cjlroKnoLuw190fz53WBaCxXr1MoOyzTrwo2Pq
         GWDqkYkHUyB3qB+4cHRCxCFu2jOsOprNW2MCUxKolBvfc8iSKCIdkpnRYj5uJWe9+NB9
         YOAKcgg3ujAjmQMeKNQiALag70Nq93+6LOFv6YrjLOz9zVCnSMvheOBGclToOyx2nnFZ
         8Kow==
X-Gm-Message-State: APjAAAUsAQbBW2MOxc5eplpHz0TIa47i4hxIUYYGvHJVK2r19WR5sI4T
        HvPUluC84YoOeU2Fuak+jcAZ+4v9zVNgbf5pyRdW8A==
X-Google-Smtp-Source: APXvYqwRrZZ7nOwBCgBSpuRRMlOMpj8YP7vD0mXalMHhGWlVUyNPfHlqJ8wqcM4Fvkx91kvkPrLciKV0TsyoSog+iso=
X-Received: by 2002:aca:4ec5:: with SMTP id c188mr4226413oib.33.1559077299501;
 Tue, 28 May 2019 14:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170403.16672-1-marcandre.lureau@redhat.com>
 <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org> <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
 <xmqqtvde4jxv.fsf@gitster-ct.c.googlers.com> <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
In-Reply-To: <a7d42d82-7d84-bf25-55ce-5c57a7ce70e9@kdbg.org>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Tue, 28 May 2019 23:01:27 +0200
Message-ID: <CAMxuvaxW9fc4ft=aERSUt4+n237bdtDpKJMvyKq=H7yz-VLWbg@mail.gmail.com>
Subject: Re: [PATCH v3] userdiff: add built-in pattern for rust
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On Tue, May 28, 2019 at 10:31 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 28.05.19 um 18:34 schrieb Junio C Hamano:
> > Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Ok, I am adding:
> >> ...
> >> sure, I thought it was already covered.
> >> ...
> >> I think that would be fine, ok I am changing it
> >
> > Thanks, both.
> >
> > The previous round has already hit 'next' (which means that we won't
> > replacing the patch wholesale), so whatever you do, please make the
> > update relative to / on top of what is queued as d74e7860
> > ("userdiff: add built-in pattern for rust", 2019-05-17).
>
> Ok. So, Marc-André, would you mind resending an incremental patch,
> because the word-regexp that is currently in 'next' would catch certain
> expressions that should be multiple words as a single word?

Beside a few extras tests, the diff is:

@@ -134,11 +134,10 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
         "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
         "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
 PATTERNS("rust",
-        "^[\t ]*((pub(\\([^\\)]+\\))?[\t
]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t
]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",
+        "^[\t ]*((pub(\\([^\\)]+\\))?[\t
]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t
]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
         /* -- */
         "[a-zA-Z_][a-zA-Z0-9_]*"
-        "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
-        "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
+        "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
         "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),

So it is simplifying handling of type parameters, and lowering the
complexity of literal numbers.

Both of these changes were based on your recommendations. Would you
mind sending a follow-up patch yourself?

I can send a seperate patch for the 3 extra tests.

thanks
