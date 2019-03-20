Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC8920248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfCTLXl (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:23:41 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:39387 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCTLXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:23:41 -0400
Received: by mail-pg1-f171.google.com with SMTP id h8so1587908pgp.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRvItQjRWE5lDccomcb6EICtr90J96WN3uV6qk3PPp4=;
        b=ojFb4kBKJlvJhVL2QeVmgOrQNCuZQnmWMMqwQl1l1dxUgPNSBW9LBipC8lgFMayA8j
         Hc0X7theb57XftCnuJk0+xvXYxkE+9QJGZ0ybjZkvkP1uUEXpDclpVnTwvnWJjgadYqc
         e/etoXH6UOYN5dFALIPF/5jUFckgXlG4qnhZ+rJolnIRnhz0xrSPMJ2gyce0z0iUVqkR
         zT1NZj2epo/vZn/ZFS2ftYojQgJjeLwBMeiUhRUzNFt6448AwB5liGrOd9bIWbzGPSlc
         YiAS9S0rx/1I2AeMM+MQYe3gOcF9VYdla4dceZAIQaEUS2R0PbY0eOj0MET6M5gdAz78
         9etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRvItQjRWE5lDccomcb6EICtr90J96WN3uV6qk3PPp4=;
        b=F4aFU8nobRlmZNc40iDyCP6KT7eUqMpsAnSKcLmWnXgePXWkXATC9ve8RFl+E6W53C
         ceF0PIlh7a1B2hHcveOMhR9THULfthIb+2PBuo9gQQo/L+akNTItG4i4neaAWfTTsIUh
         PIq6tZhihMi/XPcvBUEoFI8KrvZ0L7aqRDADuURYDvrELOIQMUaqRuA/ZxJmEvW8MgVm
         8A86HJN1nHwGLaTU1vRJL4nVCLeBZV45jobnP+3bCCi2ILeB8fcC0p1fECcO5p7pUd1L
         jGbQSxiXxAGNdMZAGOQR45kGxdMcZoLAMIGtpBXUaVFXM6j5B/WVmDozCRzTEvnQYPA9
         lnrg==
X-Gm-Message-State: APjAAAULdUADPdHd3taCUI8afbAnWo1DHtBJwRwcFX0NdgSIy4KCvEgW
        n9v21o72Y0JcE4wTCfD2eFgCuOIi0fQkyWmd8cUks0LX
X-Google-Smtp-Source: APXvYqx35bRfw/yRNhc7ENva+deJBz9IbEnakJ4Wq1l7oWY0I3+DlT5f6Dvexxuq7mkZcb1B2Aw+eo/K8Q8uV7BcKVM=
X-Received: by 2002:a63:f310:: with SMTP id l16mr6786688pgh.72.1553081020835;
 Wed, 20 Mar 2019 04:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Wed, 20 Mar 2019 11:23:29 +0000
Message-ID: <CALgYhfPci+m+zG2-83URSkSXCCH-DqGCBguizY9o7YYUaXKDhw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
> * tg/stash-in-c-show-default-to-p-fix (2019-03-20) 1 commit
>  - stash: setup default diff output format if necessary
>  (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)
>
>  A regression fix.
>
>  Will merge to 'next'.

Please hold off on merging this to 'next'.  I'm planning on
sending a v2 based on your and Peff's comments, hopefully
tonight.
