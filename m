Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1794220248
	for <e@80x24.org>; Fri,  1 Mar 2019 06:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCAGKe (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 01:10:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfCAGKd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 01:10:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so24485188wrn.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 22:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3v8EiOQYVxh5dxxaJ9KpPJub/r5QxPryUUgorjN03K4=;
        b=qe2Fj5ThYB4gCJMjIzlQtwOs/Z0ImMewr3xEXKP++kMsCq9PxDtZtK0og1XUwBq391
         TW5GZR4mB8qViIlYaSNBfBNNqBhEGLvczabIJUczQimTh1OSTg8KFZybt78QHb8jMhXt
         +vpDkV7A6BvzVUnV7A82WqKRcUQqHp5jgrC575+JraiBQDAczW/bdsaZdo7ZxUW57XS6
         s+dlZ9jEZL8lnRjw9qYLbxPmedx1kWUyhBXwlLS4iXhTlYp0Ta31dSUuL8hl1Kw39ZFL
         ycE6Rv0satglGQPpjzXPx8BUQgEacAHsxODlZvMbP6lKO+1+x7Exf6mXgJQCihZyXHLu
         P7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3v8EiOQYVxh5dxxaJ9KpPJub/r5QxPryUUgorjN03K4=;
        b=KsAKklzYlRCneLP5BBYjTC8Ws+T7rrypHqPNpYTVWdo0Lo871iY9q7GBPUbczGGOPF
         ZZHKh8P7Rj8J9ivGOWc5K1UREn6bpuJTPSLFPyBIh/1DThoT1cnjcyi6yu8aAR+JhvAP
         4EqYswVfBDlbCW/i4F8+N4E/DuGTTHbXQYsF0O+0DiswyeSPT8RieoKguJHqlsPFq7DO
         JB/CEjNU33wPurl4xqhnHMSJ/eTJU5mayVwAj67LrSTUYkBU+1gOtoH0wsFEtnx60HaT
         xYpJfN3nv8nGqphj0KqeJvfet45Yh8pQgEkzc0CIWIdTxzriJay+E5Vvz545aXJdiNaD
         HUzQ==
X-Gm-Message-State: APjAAAXNZeg0BFoyXDYaP8uRwUwmdwguM5SBq4Y9K/xpvK40y5NUBJO5
        PZw443Rnrmw9HTwyRzrdEyxFYkKI6cc45Rbe6Hh9aw==
X-Google-Smtp-Source: APXvYqykXGakF2FnhH9F00Sw5IHr3NHpOe6EKReMELSnQEh0nhpT1Zph9V8OfMZandPjr4EqMbkJK1r+EsiMt5rTeTY=
X-Received: by 2002:a5d:694d:: with SMTP id r13mr2045241wrw.38.1551420631775;
 Thu, 28 Feb 2019 22:10:31 -0800 (PST)
MIME-Version: 1.0
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a4f-cdb13ec8-58ea-47aa-a64a-517db120961e-000000@eu-west-1.amazonses.com>
 <20190228211122.GD12723@sigill.intra.peff.net>
In-Reply-To: <20190228211122.GD12723@sigill.intra.peff.net>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Fri, 1 Mar 2019 09:10:20 +0300
Message-ID: <CAL21BmnWuiZtcjZMPw2M+fyx1N1qSMKqDULQzaioMaB9P95SDA@mail.gmail.com>
Subject: Re: [PATCH RFC 04/20] for-each-ref: tests for new atom %(rest) added
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D1=82, 1 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 00:11, Jeff King <p=
eff@peff.net>:
>
> On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:
>
> > Add tests for new formatting atom %(rest).
> > We need this atom for cat-file command.
>
> While I do normally encourage splitting up commits, in this case I think
> it would make sense to squash this together with patch 3. There's
> nothing to say here about what %(rest) is that isn't already said in
> that commit message.

Agree, will squash.

>
> That said, I'm still not sure that for-each-ref should be supporting
> %(rest) at all. We should hopefully already have coverage of cat-file
> using "%(rest)" (and if not, we should add some to make sure it's not
> regressed by the conversion).

If we want to use ref-filter formatting logic in cat-file, we have to
add this atom in ref-filter. I agree that we do not need it in
ref-filter, and that's why I left %(rest) in cat-file docs (it's in
the end of the patch). But in the code, I am not sure we want to make
one more array with specific cat-file atoms (or atoms for other
command).

>
> -Peff
