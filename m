Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EE121848
	for <e@80x24.org>; Wed,  2 May 2018 04:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeEBEui (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 00:50:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45922 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEBEuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 00:50:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id p5-v6so12480287wre.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 21:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KhYQRcNXgVvHXZfqiajeZohJ/CD4bhah6YQEa3ayb/w=;
        b=mqd6PeFL/BtOJj+VCL12sOLwTtqydgFRO+pjOLllm62iGvrl28tDxWyaTQY4Dpp1PX
         0Cg9KZTUHGZd7LuNOW7jY+34e/EQEwBsb8GRPCIq6L60+ZAJCPWQg6nigJWpsk6XnJj0
         LdRJuShJNUJ4kYm6QMUuWyoYaUwgS18EFciMxm5bZYM1WaejGgmgnhRH9lRDjQMM/OlI
         GpyluDcQXs86RUp9qz6+iEJU6UYtd4yium6g3dUWE4oV8ASp7dcOdjwtk/os96FtuEib
         GqFxMKP8LaeDS74/ofy/XeDuS4j+as/FuaDlbUabrgFo2iO0exgEpJQeKrzUjLjafLRJ
         2ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KhYQRcNXgVvHXZfqiajeZohJ/CD4bhah6YQEa3ayb/w=;
        b=EcI90YdMAxZV2LFrhi+lhv+1yby5t7Ps/NK0zI04r9SdzC9fhtFX956ZTfGNvIrLyV
         ik1BcT9Tu6fGECVcrVAoT2tpx64PMXoMEbS6pxGhQvJfJcZqHQ7mEWiJ2jHkbov5RAlq
         dhiVJBN8KXuC2No4EcBfHnzHa21X5w0YqjxUSWzwDpS+flbhTdoMcIg2xTT3HfMc5X91
         GnQesYOoDELFDowMVx4w7L80TFtjQHGJGAtybzWWNE3Fw77tnMAtKhaLdgjQ8CUlfEp3
         /PDIzQYwC6Eu9RP7EbpoOaKNFN9BUG8dQflaQ2uUW41fRa2k+3dvAk+kQCxTGLOqt2Ul
         IbhQ==
X-Gm-Message-State: ALQs6tD5LF9fJDZi+aDsx/a0RvHC3Jg2rIlwUp6V1TcrKRk5pYLFItmY
        X429i3Rvuqhl3nDjq19spY4=
X-Google-Smtp-Source: AB8JxZqarN5VvU0uWjgAq4vG2rBiY6YwNwu+R7luLaSz0DiWvZBiGab/QhSBlLogW4D6970yOvZ5qQ==
X-Received: by 2002:adf:a075:: with SMTP id l50-v6mr14683336wrl.227.1525236635815;
        Tue, 01 May 2018 21:50:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b10-v6sm23889915wrn.42.2018.05.01.21.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 21:50:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revisions.txt: expand tabs to spaces in diagram
References: <20180430210430.14611-1-martin.agren@gmail.com>
Date:   Wed, 02 May 2018 13:50:34 +0900
In-Reply-To: <20180430210430.14611-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 30 Apr 2018 23:04:30 +0200")
Message-ID: <xmqq7eomwtid.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> The diagram renders fine in AsciiDoc before and after this patch.
> Asciidoctor, on the other hand, ignores the tabs entirely, which results
> in different indentation for different lines. The graph illustration
> earlier in the document already uses spaces instead of a tab.

Ouch.  We might want to teach Documentation/.gitattributes that
indent-with-tab is unwelcome in that directory, after making this
fix (and possibly similar ones to other files).
