Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEE21F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJJUDF (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:03:05 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35941 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJUDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:03:04 -0400
Received: by mail-wr1-f43.google.com with SMTP id y16so5571502wrw.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3seC/ePTtqIErY0COh+1UHGFA6fwLotakER0sWCjowU=;
        b=QyE7aMi0us3YRc6kmkor12OHkk5fBFawqIcQFMw2VHvEhGbDipPXQIBapNh7xhXz2d
         3WYrNFsl0jsXlGbFvmHsLK1Xc2BBA8b1+Cc0YfUo0SrPrESgkjCFgJhU95V7SMj3Fo3a
         ZtQwwnDLc8QjvdDZnfvjOUWo58Fkvy5Yj/OYtKV3kK1nNy/q33eJLQkqVxHYFgngISej
         +mH7USbuFbjDVxmvNm675K/Fr/AKHbzQyb+NFEeQyDTnRiQ19bTcptxNZ560Ct6dFr6Y
         vZyaqNnNQno893j39W3nHUCZ39+SwFVudLRgoI49UwIWSC4XV2LsqDy/nR4c6HFt5s5G
         02Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3seC/ePTtqIErY0COh+1UHGFA6fwLotakER0sWCjowU=;
        b=CztgFqoqvpke+yH5gm2JBZ4DnKOOGh+PR18GDiuF9mXnIZuweoDFyGORF8uKo2c3LK
         SIxlHAvElNMhzbRax31q/arVcPfyQBAdK83k9fk8tDEYyOyQRpGl3zcCzhGrYG4PAAKo
         5oIfERL5XWlRO8+rK4o4BKameyeOqbIc9dyiLN6dxcFrXNhksbCJOGHm7UFd1/c5mbSO
         iey0R6YO/FJsTYW0W3JviyaiiwMKIgKcUJTNAfPYZ35a/1Z9Uz5oPgGzQhPwCnXXXRk+
         PuDhuBIXzxgeu9a7OGlacBnFi+OZHIwjnroU1YzL49z3j4XQd/jxtn8NuOC4IvYsruFL
         ZZOg==
X-Gm-Message-State: ABuFfoh3zxj8bDpgLtSUzFRyDVH+6c0SqLgIghdrERE8eSqzsHd3qyhs
        zxnsJLY/Vik0O4Cby1UY245l/2Jrif2pgXvvhFY=
X-Google-Smtp-Source: ACcGV63Vbtm17P6CcITT1QMu7BADiNUXD//eFrdZM8sUPrNmYvmxywL7JJ+9FgU0VzS/FFeRvxE4zwqUKwuwqlMzwOQ=
X-Received: by 2002:a5d:6b92:: with SMTP id n18-v6mr6782459wrx.295.1539175263506;
 Wed, 10 Oct 2018 05:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
 <87bm82fcmm.fsf@evledraar.gmail.com> <87a7nmf9zj.fsf@evledraar.gmail.com>
In-Reply-To: <87a7nmf9zj.fsf@evledraar.gmail.com>
From:   Thiago Saife <tsaiferodrigues@gmail.com>
Date:   Wed, 10 Oct 2018 09:40:27 -0300
Message-ID: <CAOO0rQ+3BPydQUaY67REd3-W9co-92DYa=TAUaGurN+QQUvSwg@mail.gmail.com>
Subject: Re: Translation to Portuguese
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Avar.

What it means? I should not continue the translation? Because
Brazilian Portuguese states as Translations started for, but it's not
finished yet.

On Wed, Oct 10, 2018 at 6:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Oct 10 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Mon, Oct 08 2018, Thiago Saife wrote:
> >
> >> Hello Git Team.
> >>
> >> I would like to help to continue the books' translation to Brazilian
> >> Portuguese and I don't know how to proceed. Thanks in advance for your
> >> help.
> >
> > That would be great. Have you seen
> > https://github.com/git/git/blob/master/po/README ? It describes how to
> > create a new language. Also CC-ing the l10n coordinator, Jiang.
>
> It has been pointed out to me off-list (thanks) that I missed the part
> where you mention a 'book', and we already have a Portugese translation
> of Git. Sorry!



--=20
Thiago Saife
(11) 97236-8742
