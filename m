Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464821FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbeARV1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:27:00 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43468 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeARV07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:26:59 -0500
Received: by mail-wm0-f47.google.com with SMTP id g1so24588046wmg.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0a1QJsAyPWmyEy7ZZ1SD9XOIxWYbAUygm3T55ptBc04=;
        b=FycC9DkDUSfebDVU7YyZeHqCnbnCzKdY7bXOu2zDPkQoslirxJrRHbr0ovv22itX7J
         GjM7wyGQIdII6bRLhCPd1KLWlm/3TelR0McgwHtSjXH4uU8h784b1C6myE72fY5Pubjg
         MN6TkMSKGU9OUsUV4D5fBQNuYjCbs1UOkgpGpounP2VFzoD8gk+QaozyPaucGpkI+sjp
         Wgm9ZwlrVFJLt59Ko+Z4mzQqfpSGSlO8WZuNlYXUXFjY9T46Nwpxup9OUMnDlVOwGXBm
         u+ZIwXSv1AqbF7famemKNqCfFwZCy3DDxde9OHxDrhqSlaBPXe9qJxxhWKSBBJFjb7kd
         yRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0a1QJsAyPWmyEy7ZZ1SD9XOIxWYbAUygm3T55ptBc04=;
        b=j7tbJuKtU00fW5GM68RlSt7lN54HRuvc/rzRtbcZWC/a3mYjODP/ZShNFp4ReEcZWz
         e/BKaUpMgFr0vyrmZZ4jsIxaSZAmv4P2FPi1PN8LdVPpfSlpK6kX5T0HrXk+Uj8or0kK
         qNwlALyl4ZRoYwmn1xN+2eUmLRsohssBC5vyczpAM3oN6opzeCy/XWwQwNNqbq4io/bG
         wsPDOyPeaM+ntougifUkDXmmhPSVd6bjQSiY7x81Ly/KO01LMiEJCn1AVcZkzaBSZNHN
         xNQwDCngvUrHQNxwMUkrig156UTtaZvQtH6HkgD+FFRMT18mOO76GJ0vk9bySjrzcl3R
         Mouw==
X-Gm-Message-State: AKwxyteQ+8qy3jf+QyOwajE8rHD54mk2W0OEfXfrGnNxf6Avb7elxH2+
        kJkVTldJBC2KXW/g4SL8mk6Jam9jeBzTV16Cb4JH9Q==
X-Google-Smtp-Source: ACJfBouOdV9wEKsu2CUxq9fUt6Un69/zZ2hko7Q7oWiK0Cc9sXtXG835jZlE+rFXeawWyIhcbBjXPosdCmf0tyRLH70=
X-Received: by 10.80.164.233 with SMTP id x38mr9762907edb.293.1516310817747;
 Thu, 18 Jan 2018 13:26:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:26:37 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801182214350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
 <CA+P7+xrLrU=s4EgPYs7HP4JRBj1fW2YJNUEpswJENBxHAvz5LQ@mail.gmail.com> <nycvar.QRO.7.76.6.1801182214350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:26:37 -0800
Message-ID: <CA+P7+xrWc9mO8AuVomUbFr-JBfzmggCs9qE4yois27t4drHSMQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 1:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Would it be possible to open the editor with the supplied text when
>> there's no commit?  The text after <rev> must be oneline only..
>
> I actually want to avoid that because my main use case is fire-and-forget,
> i.e. I want to edit only the todo list and then (barring any merge
> conflicts) I do not want to edit anything anymore.
>

Agreed, for the case where we copy a commit message, I do not want the
editor either.

> But I guess we could special-case the thing where `-` is specified as
> "merge commit message provider" and an empty oneline is provided?
>

It's for when there is a new merge, for when we are creating a new one
using "-", yes.

>> It's difficult to reword merges because of the nature of rebase
>> interactive, you can't just re-run the rebase command and use
>> "reword".
>>
>> I suppose you could cheat by putting in an "edit" command that let you
>> create an empty commit with a message...
>
> Or you could "cheat" by adding `exec git commit --amend`...
>
> Seriously again, I have no good idea how to provide an equivalent to the
> `reword` verb that would work on merge commits...
>

Given that there is a work around, and I doubt it's that common, I'm
not sure we need one, plus i have no idea what verb to use....

We could allow reword on its own to simply reword the top commit?

That being said, since there's a simple-ish workaruond using "stop",
or "exec git commit --amend" I don't see this as being important
enough to worry about now.

Thanks,
Jake
