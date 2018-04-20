Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680231F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeDTR0r (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:26:47 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34957 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeDTR0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:26:46 -0400
Received: by mail-ua0-f170.google.com with SMTP id c3so6194120uae.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tlubmPoiHVRiZeaq9I1kYANnCtuPTciAfHT8bKphkNQ=;
        b=F9ZgFdNtJPT4FTKuaHWPzH+UlvXOV9dG5Hp7l5hn9uf1qKMS8ZmDDJwhawuf+vHynT
         /rKbbrv1o3YwajZRpNVpQ0ngm9hWOoBBrsq3AWMSDd5wsK3He2DRdWRTBCNfI9l5l7aN
         4XHlIru+AiiBk7XGvdC8ylcN7pPYDgJ5FjtrunvPmIW3fMX5JugP7vgrTV3Pv6++07Qo
         HdLXVO+I43LSQN9AF7C82eURfn2H0IFezt3iPsVvio4MyXyaceIxLBsrJJL2pBGvECEH
         UOFG7UxL2eblhb0ASyIrn4/0dGfVg1gWBzwTLJeHnJyVmpjgmJN3FdmtEIA3XnvTAYj8
         J7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tlubmPoiHVRiZeaq9I1kYANnCtuPTciAfHT8bKphkNQ=;
        b=ajGecK8zm7hTp4prTyK5V39RyHq4LxMHeFF4D6WUSsFU5gJTJG9b3yA0RMCWg4Tu64
         KXlEK64op3O4ZOM3/r6mKgvWMcS+MGkXF4Z3bRartdNzi7Fsrfjx+Teg4iefHKbQdgDE
         hI0e2rTBjNjbfkhNeaaDJ50Wiwljlr/jmOa0h5rbi+EDezY0oTrygxpPlKjSo2CYWugo
         Zr7jH2zBwofNvWlX3AF0/7AoN9sMBYJoZs1AOBuDMWldh1oWwrxN3WbyMh8XTbxnKzcC
         Ufd//LFjSFzhqEmWpcXXLRxBp9jEf5QGiQH2A+fl36lnTw1CixMHAmWC1ZNd+uvYDSeo
         aXBw==
X-Gm-Message-State: ALQs6tA9xIbPOSLWqcPSFSEa3N7DJpRdVQgbhLbijqlR6ig5Nxu5Qn+y
        Tw+iF0HAZd2IVrkC18TBOEyc4ThUohhUkmMjEJ8=
X-Google-Smtp-Source: AIpwx4+3/ZPob2qH3MXAyYm5QTOdzkciO1OSfpoA4INcc12r4LHDy3LQ4fbWxc4I6+fCNIv4EyV0eIi4iqnqaSwOSNA=
X-Received: by 10.176.30.132 with SMTP id o4mr8598487uak.154.1524245205822;
 Fri, 20 Apr 2018 10:26:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 10:26:45 -0700 (PDT)
In-Reply-To: <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com> <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 10:26:45 -0700
Message-ID: <CABPp-BEhvLVTL3+0scUucAp9ZMBiiT_0VG3eeKm9qRnHG=y+tw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 10:02 AM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> --- a/Documentation/merge-config.txt
>> +++ b/Documentation/merge-config.txt
>> @@ -37,6 +37,11 @@ merge.renameLimit::
>>         during a merge; if not specified, defaults to the value of
>>         diff.renameLimit.
>>
>> +merge.renames::
>> +       Whether and how Git detects renames.  If set to "false",
>> +       rename detection is disabled. If set to "true", basic rename
>> +       detection is enabled. This is the default.
>
> One can already control o->detect_rename via the -Xno-renames and
> -Xfind-renames options.  I think the documentation should mention that
> "false" is the same as passing -Xno-renames, and "true" is the same as
> passing -Xfind-renames.  However, find-renames does take similarity
> threshold as a parameter, so there's a question whether this option
> should provide some way to do the same.  I'm not sure the answer to
> that; it may be that we'd want a separate config option for that, and
> we can wait to add it until someone actually wants it.

I just realized another issue, though it also affects -Xno-renames.
Even if rename detection is turned off for the merge, it is
unconditionally turned on for the diffstat.  In builtin/merge.c,
function finish(), there is the code:

    if (new_head && show_diffstat) {
        ...
        opts.detect_rename = DIFF_DETECT_RENAME;

It seems that this option should affect that line as well.  (Do you
have diffstat turned off by chance?  If not, you may be able to
improve your performance even more...)
