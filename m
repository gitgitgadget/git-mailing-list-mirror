Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588A12036C
	for <e@80x24.org>; Wed,  4 Oct 2017 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbdJDVWc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 17:22:32 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:55914 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdJDVVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 17:21:34 -0400
Received: by mail-qk0-f171.google.com with SMTP id x82so3006563qkb.12
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=duJ6L0AEanJPmh6jlWO7UXgMLG860BiNp40s7jswcI8=;
        b=Z61y1jaanQcoEu/wTMjP4J4ZIJVs+5b779wZR0ZaAvYBfNhFW5186WXB7SBkwt0G7F
         N8UeFeQgzJiEkwj+51eD4PGNxtPPUJ8ModM/Dib49r5F2BuPlspJlkGHlXyZLJtAGkq/
         tXE33roQCoElRw7tFhnkHseFA6EgchHRPS99zzMxaKZ0fX5u6zT/uynVf4fsFVLZbUzs
         s0iGXkoWE43GNU6mv73IClT9pbKGSmrKLYGUiNgiUdgA1XZoJNPDlg0wlCB9PU5SSoah
         vfQN+m4/WWo54WaWhRefqk8cLr3tleDGr/VUQZ8uR6Jcpj/kAcQpu4gyg+gWtQ+2+XHe
         v+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=duJ6L0AEanJPmh6jlWO7UXgMLG860BiNp40s7jswcI8=;
        b=YiPtIxPztnEnBuzeGc4SRn8QaZgNxuL3sWVe6BFQ3+OHSzN1sMtkrSexeezrbeJOPf
         SFAT4RUDrvujUihb2gaKGjd4zCOLfw2yYDtmnQ6RJXH48gUQcyQxhovRUdo6K7n5LoTC
         JC/xwxoQYOAdHymhr8ZizaVoyybeKPX2h9XbK3T6aVcDrjLbSEuJl9PeVgypfsJswXZM
         VCSQZcKxT8SqWZD3jlMweVUSedn5bdCZ+bYLbk2EJWKeFeJ/J4CwVH3h3Idb0sxP4Iys
         FawTaSHxW+Jz4FcP/cMkbBSkdP3IWoC1LLlfGzJ8UuAJD5i0J0C5cy1NzY/FyXXaJdxL
         SDrQ==
X-Gm-Message-State: AMCzsaVjSjqELytFrUwZGnnxhrQBq3fLbGvQeNHuEKO9RFBwYJ5Nyr4y
        siA1sJa3cUoUySwu4G+S5kBPsCzQjCGp+K7do0sk1HGv
X-Google-Smtp-Source: AOwi7QDffKPJbVFcyLWWD3lGcjdifDC+bpwGZWDjAbsoGYLvDJVJKVPXh0cVDSfGqz0UNLwx/kvSWQMxOQlIFX3qtUo=
X-Received: by 10.55.144.69 with SMTP id s66mr27618405qkd.111.1507152093580;
 Wed, 04 Oct 2017 14:21:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.35.12 with HTTP; Wed, 4 Oct 2017 14:20:53 -0700 (PDT)
In-Reply-To: <20170928211859.uw7dep6gypsifivy@sigill.intra.peff.net>
References: <CAPMsMoBK+EQZQx4FUs_EqN+BE+93-mtu9kzViqQ6B=LUOFESbw@mail.gmail.com>
 <20170928211859.uw7dep6gypsifivy@sigill.intra.peff.net>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Wed, 4 Oct 2017 22:20:53 +0100
Message-ID: <CAPMsMoCCE=tux5Pi=eC8_YtFb93TYOgrZdOS9CXnuLyRr+1v=w@mail.gmail.com>
Subject: Re: hacktoberfest
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

seems my last answer was blocked due to HTML :(

here's the answer: Seems a nice start yes. I've been on vacations, but
next week I will go trough the current issues and add the
hacktoberfest label to some issues if you agree.

I went through the open issues a few moments ago. Some were closed
(solved or not applicable anymore), and some got an hacktoberfest
label, hoping new contributors pop up. Feel free to have a look and
add new issues to the label, as well as remove some of those I thought
it could be a good fit. There are easy issue, and some not so easy
(not very hard, but a bit more work) probably.

Issues labeled:
https://github.com/git/git-scm.com/issues?q=is%3Aopen+is%3Aissue+label%3Ahacktoberfest

Thanks,
Pedro

2017-09-28 22:19 GMT+01:00 Jeff King <peff@peff.net>:
> On Wed, Sep 27, 2017 at 11:05:49PM +0100, pedro rijo wrote:
>
>> While the git repository itself is not hosted under GitHub, the Pro
>> Git book, git for Windows, and git-scm website (at least) projects
>> are, and could use this movement to get some more contributions, and
>> eventually more maintainers (at least git-scm website had some
>> maintainers problem some time ago).
>>
>> I've been helping on the git-scm repository (mostly filtering issues
>> and PRs), and I know there are still some issues which need to be
>> addressed. If the remaining maintainers agree, we could filter and
>> provide more instructions to some easy (or not so easy) issues, adding
>> the 'hacktoberfest' label and try to use this movement to solve some
>> problems
>
> I'd love it if more people wanted to contribute to the git-scm
> repository. I think one can probably find some low-hanging fruit by
> looking at the open issues list (though I'd be happy, too, if people
> with bug or feature suggestions opened new issues).
>
> Here are a couple small-to-moderate bugs that have been languishing:
>
>   https://github.com/git/git-scm.com/issues/701
>
>   https://github.com/git/git-scm.com/issues/987
>
>   https://github.com/git/git-scm.com/issues/994
>
> -Peff



-- 
Obrigado,

Pedro Rijo
