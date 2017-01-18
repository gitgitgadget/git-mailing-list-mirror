Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAE11F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdARVLF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:11:05 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33468 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdARVLD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:11:03 -0500
Received: by mail-lf0-f44.google.com with SMTP id k86so22151959lfi.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2l618uqghdmWxX2eB9awlpVvdYImu1iuwaMtWVfi08c=;
        b=PazAdP56oE1ganQ10sZT0dkcaHblo2KNVQyQ0SsXoDy1w4nu1re/1OiTYccMojs5EK
         MCr6bRQu1PqNOgguimesF2tyCaC9spjHeS3PzGpPtmR81yDaFa/1AtHQfT1CKSZi7toQ
         UJGBockfrmcE3m7r6+jR/oRBrMe82UNb98nGciob15FPZHhK0oBLGti5MQp9l8diJGjm
         7Nhvk7L73ELWhWkdr4QSZj3iFmUG4KRhR8Ud8+MZzdJdTLbe3++V7+YtKaWILTed2uCe
         7PcujVkq7h0i8AJ/4NZLHK/wv4batfqlpiyAY1w/3YzyXU749hbizm3M/nN8eqMQCaBH
         q4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2l618uqghdmWxX2eB9awlpVvdYImu1iuwaMtWVfi08c=;
        b=kajxRNlE/fc+Fxjj2T/7Yxnk0UtPvekqdu81EHe5ucGfZhRhGVg/zZ/GWwEL2CtD80
         0mrGW7bSr0mtJz8YBOS+X7gtAo6MJFTHm1acFOZYAEgPX/5DDKZT2KvO4lZ9K8Pp6thp
         1fHMsk+HPhFALLDhU1NCc2A+V7KfgeSS8CzdrSg8sKf4TJ/aYNtNJkDdBNspOfVCjEzo
         ud+p1GhjesEMMJ0RukuYCnVETZX/fLpgXA50EvxI8ehFPY11qwPSI3op7kLulIPf5sNz
         7VX05+kJuF4KK8dvqAQPMpRvreUxNsBVjgKMcjMaEgc7nsaBEwhLsOc9nMXpUISKHr5h
         RaaQ==
X-Gm-Message-State: AIkVDXLjr7nVzNtRFH1qluGLoYyn6ysjmtfiGcFnpHuT5O73ZZhVZLrUSNpEmQ1VebmCwwLmG2Zzq8tN204XGA==
X-Received: by 10.25.75.79 with SMTP id y76mr2103321lfa.143.1484773856753;
 Wed, 18 Jan 2017 13:10:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 13:10:36 -0800 (PST)
In-Reply-To: <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
 <20170118000930.5431-2-jacob.e.keller@intel.com> <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 13:10:36 -0800
Message-ID: <CA+P7+xrv35w0RYNEZ88K_EWC57A4utBQTibtw6+TJBCtzA9Ybw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] doc: add documentation for OPT_STRING_LIST
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 11:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not know if it is clear enough that 'option' in the last
> sentence is a placeholder.  I then wondered if spelling it as
> `--no-<long>` would make it a bit clearer, but that is ugly.
>

To be fair, this is exactly how the rest of the doc spells these
things, so I would rather be consistent with the doc as is, and a
future patch could clean this up. See OPT_SET_INT, for an example of
`--no-option`.


> The "Reset the list" is an instruction to the end-users who interact
> with a program written by readers of this document using
> OPT_STRING_LIST(), and it feels a bit out of place.  Perhaps
>
>         End users can reset the list by negating the option,
>         i.e. passing "--no-<long>", on the command line.
>
> I dunno.

Maybe we can rephrase this "The list is reset via `--no-option`"?

Thanks,
Jake
