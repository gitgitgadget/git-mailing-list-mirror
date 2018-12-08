Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C0720A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 06:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLHGwL (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:52:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43795 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeLHGwL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:52:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so4571437lff.10
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 22:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4B9bHPsdKz8JOaDKD7ENIBQ1PuraaqY0ySFr6S1BmxA=;
        b=OU2dNOphTB3hSxUZ4pQwBt+XSNWeZPc9ePw4Er2OHPerXzF5qmspeSN8FQlMdFQX9u
         Nqvh060rAQqWfI4POMSrkVma/6VuWKhA3X9YVbT3ir0QAUMsETzuylyqD/lRGax4lm9k
         8RfGYpX490PRtYVBMHtRUVc0cM39XexvBz10AnGKqPf0yeasfWTbmrs7smuyXltwrHxI
         itNaaH/wy/CPnEwDX6e/bD7JUIn4jErGwnAV3/CGUUpjACznEXtwdQLmAyQ+TD+UUwVv
         A0XdHSJC693Ildrnw0Vh9OtImob1S0xUlG18fvdbg1b2ULhrMY79eDkBiUvoZnolhzop
         3f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4B9bHPsdKz8JOaDKD7ENIBQ1PuraaqY0ySFr6S1BmxA=;
        b=hbTBE0kbUx9CmgWnq42+/SozbpQow1lvTphDq+LNdE9HVrBUWobxQVk5T0OcLy1Bmj
         QdlUDDrg19MAXaj3NvDdY6T0FQyuBr2iCq/1kB5iR62CdR9fRZupkQDA5/JWDI03ArdA
         fJNXpI2BUTI9cl8LUDqu3BySoo7eryvRyEDeU8zX6AFDh8cLHPBrVgwQ5/iFbypajFYQ
         vqQMDNBST6NY/+iwf3zJAv67hhpIUO68K3G72Em9xI2l+qZYidm0K9Y1sJHDW/NmyngD
         E46LoW4LVTCnxIEL6i3+Tks4PGH3i32KpD60y/xyqkN2lBBq0tw4HHCM0MzHfYbfj1XT
         dcNg==
X-Gm-Message-State: AA+aEWauUJaekbsNBaPQsmQL4eVXAnVKRjWfCcvenggDXVklihza62LE
        PZ7uaYNEFHEnQwyl3XCoa0ksqiCsTRH2qlQjbKk=
X-Google-Smtp-Source: AFSGD/WjoIx4Oy8OGZol/sjEnJjBhPwdRMQ9ABcSnwu/peeYKTi3BWVAfR0TxQgQKasCuFWSeG43u1f0FNthKvv22Ac=
X-Received: by 2002:a19:cd50:: with SMTP id d77mr2790923lfg.125.1544251928810;
 Fri, 07 Dec 2018 22:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
 <20181207214013.GA73340@google.com> <CAGZ79kYrgpZDqAhg8c11V_qJTCzzw4-qrVN2z_Y_OAeCbWU6dQ@mail.gmail.com>
 <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zw48s9q.fsf@gitster-ct.c.googlers.com>
From:   Brandon Williams <bwilliamseng@gmail.com>
Date:   Fri, 7 Dec 2018 22:51:57 -0800
Message-ID: <CALN-EhSQZiOsXwOyDJo_muTcP9HsifmqyD1oLxMunv5CfAdHgg@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update brandon williams's email address
To:     gitster@pobox.com
Cc:     sbeller@google.com, jrnieder@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > On Fri, Dec 7, 2018 at 1:40 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >>
> >> Brandon Williams wrote:
> >>
> >> > Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
> >> > ---
> >> >  .mailmap | 1 +
> >> >  1 file changed, 1 insertion(+)
> >>
> >> I can confirm that this is indeed the same person.
> >
> > What would be more of interest is why we'd be interested in this patch
> > as there is no commit/patch sent by Brandon with this email in gits history.
>
> Once I "git am" the message that began this thread, there will be a
> commit under this new ident, so that would be somewhat a moot point.
>
> If this were "Jonathan asked Brandon if we want to record an address
> we can reach him in our .mailmap file and sent a patch to add one",
> then the story is different, and I tend to agree with you that such
> a patch is more or less pointless.  That's not the purpose of the
> mailmap file.
>

Turns out this is exactly the reason :) I've had a couple of people
reach out to me asking me to do this because CCing my old email
bounces and they've wanted my input/comments on something related to
work I've done.  If that's not the intended purpose then please ignore
this patch

> Not until git-send-email learns to use that file to rewrite
> To/cc/etc to the "canonical" addresses, anyway ;-)
>
> I am not sure if there are people whose "canonical" address to be
> used as the author is not necessarily the best address they want to
> get their e-mails at, though.  If we can be reasonably sure that the
> set of such people is empty, then people can take the above mention
> about send-email as a hint about a low-hanging fruit ;-)
>
> Thanks.
>
>
