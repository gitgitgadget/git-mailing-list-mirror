Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7D91F453
	for <e@80x24.org>; Wed,  7 Nov 2018 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeKGSUJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 13:20:09 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41359 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeKGSUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 13:20:09 -0500
Received: by mail-ot1-f42.google.com with SMTP id c32so14088173otb.8
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KA6lIo4NJEAh/IPAfWj3gotdyeS1VT6VGlLzzhhsII=;
        b=orzCdUdrXYVPV0k0Wfrf1aBiTqYsXEHmIos0IV9zWL2iPOMoehwn1zXiaMYiRVIszq
         n4reCmlIoWgtbGamxaOAUbm7APt9Pw3N1nDftaqXutvss6GsE3V5tru757N4B9GHzjyB
         5CjkA0wWqBLhFHew2Du8xM4hsLlqzFwEbQAOCv4/I2hV+H8v36gixSMo7rABaMMFUdjv
         e734j38h8q7D6EQkiABmZsKCwiX+00/8CuFrRl7O3kBgU5r4X8CpvkS3NMPKxgqwrfEx
         Rph+opeFHo1e++eFznnozRoiESvWR20DPbd06TDMsa6Ldw0w0v7RyiirSGTgN4G+5KSc
         tBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KA6lIo4NJEAh/IPAfWj3gotdyeS1VT6VGlLzzhhsII=;
        b=eUAauKehZAE4y1GVKC3JyoGDB97Ez5uiilwxnxx+o2EJtpHcnJRcSTp/iyMLHDjrLv
         SW5UKCGVWQJP5RyA0EGbHMei+tDaRGP/+mh2oX9C0O+HFBqw8NUJSy6dDUAR0HmtIuaU
         XGuVybSLd+bah+xasEnt4aivHjOXhe+qui8+wZe8Ay3MHG8QAnVDJz4SbKMdQTCmIh4v
         RAaRl5ox8gnSO1BOTwuUvMgb1B2s8+cgKx1RNwil8+e0WUfmpEGV1r7DVZ3H83V7pe0F
         ERA/8pEfqz5qpIh5/dmM6mMdhNYYi9/rY4OkU65BBBmkPNCwXxmqYgkR3eRMPql9eZCf
         b6vg==
X-Gm-Message-State: AGRZ1gJGHIWCFohkttal5eztvu9BuaMhtD+vGNPTu2Ninm6aj/51DZ9T
        ZgR49LZTus6J6pT4NKIPm2bQrTY0rmJ4UCn2cGU=
X-Google-Smtp-Source: AJdET5d4dEdiKA62ewrlV8wns+jQa/wwm0NWMcL8wJN/0vW9ROE53IoPuubMELY40+wbRNQGdwGddEF9Y6A7AXa62sw=
X-Received: by 2002:a9d:2a26:: with SMTP id t35mr612933ota.16.1541580645912;
 Wed, 07 Nov 2018 00:50:45 -0800 (PST)
MIME-Version: 1.0
References: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
 <xmqqa7mleond.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7mleond.fsf@gitster-ct.c.googlers.com>
From:   Christian Halstrick <christian.halstrick@gmail.com>
Date:   Wed, 7 Nov 2018 09:50:34 +0100
Message-ID: <CAENte7hN6=ChSWHKo=cawvwV_2xVDW0uCRY+yAjAgCz8_TtpmA@mail.gmail.com>
Subject: Re: What exactly is a "initial checkout"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, rene.scheibe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, I know understand the problems which are solved by this
special behaviour of a "initial checkout". And also important I understand
when exactly I should do a "initial checkout" - when the index file does
not exist. I'll share my new knowledge with JGit :-)
