Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413331F453
	for <e@80x24.org>; Sat,  9 Feb 2019 04:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBIE5P (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 23:57:15 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52553 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIE5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 23:57:15 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so8842187itc.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 20:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7mUW0jqSfdeVQGHqaaS3JAaz6im+BYRwgPnNQyre7o=;
        b=faqRkyLLXVr630GSwUU+9fveNIzxFAXi11xOs7S3IrgPJ/+3/MvY03HopdEVvNQy81
         1Qzwe6em218v5olCzPeNfjUPp6VhWMQOJtZhXgX0wOXG6l0Z6tExNNKRJDjaa2jOs7Tk
         XVukphx5RpFeCnhvz80TS9xwj2a5TbJnHQ+UNZ4PCYOumjNQUW2gNpnWEHi5bN/QEpbD
         GsiTFM1TJwyOs8neA90GJLSU/ImevqZKU84avBQx/12i47WAuGo01hxs3pGwK44AAKGK
         LxhS+VXQklNSF4sqQq/cdzoovJ9fAZ6VZMOeslyOjxtvUo5SstLxV8NCdzqwILqLS47E
         q/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7mUW0jqSfdeVQGHqaaS3JAaz6im+BYRwgPnNQyre7o=;
        b=unCm16gB3OlWNbI2WKQ+kHCvK9UzjmINmC2F5JRXXLzQao3h+MgKebIt6mglnxU/gn
         BBw1l1hcIwx5o71zmtWYn54lEwI0htXCRLRW7uVzm/biQaDwh52rGfZhrMtoWUE2ZVsA
         VKu7CWUTxJLyPM0Hsm3z9hJCZniIcoU3HVS5YaRN3AbkcLYrApD8E0/Piagvw7Piq8bh
         FhXD0xpjiu9BmdDOirlVteIsv6Nz6LjpH6BgKPbONZPuQzewfF4A92FtiPS+1z9lRIll
         UjJsErVmJxBGxMUj24jA7+OUydtoyOJFyiyjVrSJ2XL2kl4akjzEjTcC2pzMvz+2Bzsp
         Uqdw==
X-Gm-Message-State: AHQUAuZh92gfKgOtZOrB+1sKqM3rNDUo/T3qMBerS4Gp/GwpxPA4ZdGX
        XvRXzbJDybtwgdws6HDKMIBnBDFFyyFK8crmKAA=
X-Google-Smtp-Source: AHgI3IaLJCHfry8s/AM0y5QBKNVb0NdlzbD9dWJ95gT4bpBmubsUvnAQ8CFj3z9J56E6yEMiZDuP4i47Msn4rG++rKg=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr13798233iof.118.1549688234055;
 Fri, 08 Feb 2019 20:57:14 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
 <20190208100221.GA22283@ash> <xmqqzhr6kxcj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhr6kxcj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Feb 2019 11:56:47 +0700
Message-ID: <CACsJy8AzQLvWNq4hGGva=W4CKJAKHXiopF-cVw--wdJE2npdGQ@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 12:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Wed, Feb 06, 2019 at 10:25:25AM +0000, Luke Diamand wrote:
> >> I've recently started seeing a lot of this message when doing a rebase:
> >>
> >>    warning: could not freshen shared index
> >> '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'
> >
> > There are only two places in the code that could print this. The one
> > in read_index_from() can't happen unless is_null_oid() is broken (very
> > very unlikely).
> >
> > The other one is in write_locked_index() which could happen in theory
> > but I don't understand how it got there. If you could build git, could
> > you try this patch and see if it helps?
>
> ... meaning, if it hides the symptom, we'd know the codepath that
> causes a NULL si->base_oid to appear here is the culprit?  Or do you
> mean that it is expected si->base_oid sometimes is NULL and we should
> have been pretending as if si were NULL (i.e. split_index is not being
> used)?

I didn't go that far when I suggested my patch. Looking more at the
code, I think we may have written the "link" extension with null oid.
Which could trigger this case and is definitely wrong.

> I take it as the latter (i.e. "helps" to narrow down the bug hunting
> field, not "helps" by fixing the bug).

Yeah definitely not the fix (how can I write "I don't know why" in the
commit message for the fix). At least now I know I'm on the right
track.

Szeder recently fixed some racy bug in split-index.c, which seems fit
in this rebase scenario since we'll be updating the index very often
in a short period of time. Perhaps that uncovers some case that we
don't handle well. I haven't been able to connect the dots though.
-- 
Duy
