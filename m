Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A521F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 07:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408659AbfJXHkZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 03:40:25 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38632 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 03:40:25 -0400
Received: by mail-lj1-f176.google.com with SMTP id q78so8764266lje.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T90iZ9iPRB5EgkomjHDnRuNjJUHIgrwTGI3XRchiIgU=;
        b=VonoUBDUDrFv7QOURLodNWJBfHFB9ytpfWyJ3rlrnYMIWeW8RKv1+6P41pAllyYsJp
         Cd8XK7tyK8uQOuFKYESuPI13hoBQxD/L0jen1UJfMXf7SH77hzezO2Op52LhSdOd/nGT
         MHly7/Q5PdaEM7A8RQQeww88QAalZssqK4T+t8JZoRBfKlJG9NR4EXmWjPFn9IAlYDe8
         VcD70MgFbSL0dUs71kyveF+FvdXa2NGRBpQepvX/6enO7rvFvz8kLQ/uY9pNhnWotiZs
         MY9FclU29foVzAFR9etPLt90vBPfb29Ax7fERzAuilS19CS71B3MBuWuw0zj7Vw4Rwqp
         yT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T90iZ9iPRB5EgkomjHDnRuNjJUHIgrwTGI3XRchiIgU=;
        b=ZteSC7gLatKYsDPJFPKda6a0EZhkxZlKgmkSlN5TmTYm3WBgT3hdy8t47ftfkNQatV
         ZW+aJKzI+v+NtuCa7DVC8dRzvZNl7EHR4DWfzg9/cG9ATGkJHPQzwwX6dVkTSpuKo4Pz
         vhF6r2nGzbATk2lCiYTiq2fe+ihVwHcM+cPq0zFlHz40YxHgY2AjqQzO3GTcunuPF/o0
         WoxpK9LM5myhWDpYqRkC7XsdiaizP+wLpCyNauWuccngdpxaiG3JuoAhEX91HSMgCyWF
         d3y3yvcE963Me2u+0i78ZNNjADFqmrAhIXY8PRGduQ8WUty2ftJfpntVwnXSn3ShUqpQ
         GVsQ==
X-Gm-Message-State: APjAAAUDuEgj9oj2djkNmXFCcahlC8405pDysx4Rq3h+vMcNT9F10Ixw
        kP8u0xYmpgKm7ocQKTDHpBkTOy5H7qeGP+uE1yuBBxVbkYY=
X-Google-Smtp-Source: APXvYqyD5M7JVxxJbhmycDZKhk2Pmu8aPPDYP+RexgbHsfM8HKEEbsRRR/lAH9K457cKtkNoDsBwngIuyFVHLbIAoTQ=
X-Received: by 2002:a2e:9702:: with SMTP id r2mr8001902lji.194.1571902823228;
 Thu, 24 Oct 2019 00:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com> <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimoehp7u.fsf@gitster-ct.c.googlers.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Thu, 24 Oct 2019 09:37:08 +0200
Message-ID: <CAGr--=JQXfbJaxvYo1ue__eRHyEgKDd3mjTgxXxT=7seTU_oYA@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would _love_ to see git-gui development moved to GitHub (or a
similar solution like Gitlab or Bitbucket). I have only submitted a
few patches, comments and new topics to this project. But I find the
use of mailing lists to be a _lot_ less efficient than using a
repository hosting service (like GitHub).

Advantages with GitHub
- Tidier than emails (very much so). Threads are neatly separated in a
single list, comments to threads are listed under their respective
thread. Threads can be linked.
- It's a lot easier to get a total overview of all issues. Especially
useful when you'd want to see open issues. Pratyush mentions he has a
text-file on his computer where he lists all the currently open
issues. We can't see this text-file. And even if we could, we'd still
have to navigate the mail archives to find the discussions and read
the emails one page at a time.
- It's a lot less hassle to submit patches (PRs), easier for everyone.

Disadvantages
- Git GUI contributors must have a GH account.
- All the data (threads, discussions, patches, etc) is not backed up
to such a large extent as it is when everyone has a copy of everything
in their email inboxes.


Best regards,
Birger
