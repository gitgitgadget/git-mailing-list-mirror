Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B83D1F462
	for <e@80x24.org>; Tue, 28 May 2019 23:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE1XIj (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 19:08:39 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35287 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XIj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 19:08:39 -0400
Received: by mail-it1-f194.google.com with SMTP id u186so578496ith.0
        for <git@vger.kernel.org>; Tue, 28 May 2019 16:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VXbn8n8ntyoU+t9yiZTFA1NgEhTwhzMI+oJ0eu9+3TQ=;
        b=e5J9VxO+f7pt+hUR9skmxedhvYjFqqN6imU7HNTQ3sfN3Znx5mEFoveS9qfYhl/1n7
         Uwt8P7BgZXxmwBOJVVboMMzke3gG0lq9L4XTr5EOb+jS/YOjvpyBYbbd6rWGUBXHEz0t
         6ZlWUmQfRBQRVBeIer/GxaFEdnjh05qA2wwKNWnZH1fQ6KnGpwI1x6WXyP7RK5jLYu6N
         e4cg9ub+yPZ9CrIhLXOoT83i3/tD0vjArc05ObI7MG2ZcxLRMuUYGW08nVjWcxIs2cvU
         MRW6iwXpDSqDxC0dhyB8F9fMciyAFtXTKsatBZzyM33Uom4oeum9ztZr5qlV0B/a0Oko
         UUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VXbn8n8ntyoU+t9yiZTFA1NgEhTwhzMI+oJ0eu9+3TQ=;
        b=ocjnmg+oEt3/P4w7PlszRf1yfJUm5Qz3n+tVmINtqJUWjj9ECuKYASBlCTJ/6tiYMh
         fRVwHDvqMILU/ANhlN+soLZtMgkkeYzVg/62cC9iUmlTIg6BstWDr+zIkzxhsTFSJdzt
         yKe1VIv0RAefru3aT9gdk6G6Va9Jd1dscgxLEN2bkQJKlAac6oEPYLZEnaUEa6I4WjRJ
         OjjDTenz7eWu4LZL75tgPdAjr3nO7efxAbrMm110YYaiCRoYOFVbOo6GX4Qjwn8u4YJ/
         b3PBDALUXWfD4wv9LsHghxU9gGxaYhX1calG6+Pxz9PgxkOjamnYz2dcU8Cd5YQRBHtO
         RXqw==
X-Gm-Message-State: APjAAAUPRqe0J/zGKuYKnMSFYfNQnDGBEpC/yWshiDRve7laR2zQLrf8
        knS0E2ZSjP9hMzpp+4PR8LGxwpD9rjxfxfTL3qRZixx/RJM=
X-Google-Smtp-Source: APXvYqwdcdOt+bx8Z1NWD0ieJEUJzgRyqVYnMkunDgSb3HLr2jHQQJO+mk05e5NJOJ525JjBHn/234O6ymV2OZktMIw=
X-Received: by 2002:a02:a494:: with SMTP id d20mr4180266jam.62.1559084918158;
 Tue, 28 May 2019 16:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com>
 <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com> <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Wed, 29 May 2019 07:08:26 +0800
Message-ID: <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=884:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> =E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:
>
> > Hi Junio,
> >
> > John Lin via GitGitGadget <gitgitgadget@gmail.com> =E6=96=BC 2019=E5=B9=
=B45=E6=9C=8815=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:54=E5=AF=AB=
=E9=81=93=EF=BC=9A
> >>
> >> From: John Lin <johnlinp@gmail.com>
> >>
> >> Before this patch, there is inconsistency between the status
> >> messages with hints and the ones without hints: there is an
> >> empty line between the title and the file list if hints are
> >> presented, but there isn't one if there are no hints.
> >>
> >> This patch remove the inconsistency by removing the empty
> >> lines even if hints are presented.
> >
> > I would like to ask for the final decision on this patch. Thank you.
>
> If I recall correctly, the test part of this patch conflicts badly
> with a topic in flight that splits 'checkout' into 'restore' and
> 'switch', which is a more important topic between the two.  So if I
> must give _the final_ decision, then we need to drop this patch, but
> I'd rather not ;-)
>
> Doing this change on top of the switch/restore topic, once it
> stabilized more and graduated to 'master', would be the best course
> of action, I would think.
>
> Thanks.

I see. Thanks for your kind explanation. I'll wait for the
switch/restore topic to merge into master.

Best,
John Lin
