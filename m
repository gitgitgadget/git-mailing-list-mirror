Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5788220248
	for <e@80x24.org>; Tue,  2 Apr 2019 15:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfDBPAh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 11:00:37 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:39726 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfDBPAg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 11:00:36 -0400
Received: by mail-ed1-f50.google.com with SMTP id p20so11961783eds.6
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRo0uw+KfkGQczZ3zhTHdfVo9FKsXdJZnY7BvLp3lR0=;
        b=pjnu+kV0InumIGCoXL00SSjs8tEFBXZxJezeE/KrjshcTiOrpglxgyHAZksPoJnY4a
         w0Oj7z8sBn5Hlp8vCgQ0y6JkgNjys0+/OYauhMWDBsqdeax4qOXHstAI0Y8PbJqOyJVd
         Ye2C3GnGPR9D5kZ8H4/3SD/WOn8Ifw9r0z7Px2zz2Q2fPDptkHsO2NNQEHqZ9cMEAhhr
         wjGBVGYmVcftV/2WpqK1VWYZm1mKnu1lb2na/jM383Woeeu6ktVs4PhTbQu/y+l4iGjp
         DLf45SBUVLg0z2yWihkEfThAjNEYznIBEZUgbG39lgedCfQpTMRPsPfpa9zEY4vauxyU
         YUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRo0uw+KfkGQczZ3zhTHdfVo9FKsXdJZnY7BvLp3lR0=;
        b=o3QEtA8919AxOjfwijQRX+WHIjrzyVPLysE7vK0JkZt/3cRHiXIAr6/33z86tobLLi
         G+5+u5eENEhOg+TNIBq3Hkhg1Mogzby91faRWfUWkE8ewhyhlCORxofowy/XiEtTh3Iw
         HXQwaC/QzKL4gNPfgbbIdd/e5Zsc0GfkL18uv+OQJ1AHUPREiHo7aSWgDnW/9bhGEK5u
         N8IlCvJ6G22y21Wr5/qNDRFxaZhQ/ZgFgtSQcjzOPT/C9Z7b1cvuA0pANVTqRsPs2D5Y
         EeYNn/ir14khldNspa2f4y3ghHFtLbSGN9xPd18B8I+Lneb/dGvBNkDbqly6vNvoYakL
         QZpw==
X-Gm-Message-State: APjAAAWoRDlvEIk/PqUe+FblF19FuufQIZRaHVd8JhA8orLFSVy+c0db
        h0L94HihaDYlnhpyMVDp5XVGfsmy74QYwUiyWso9CA==
X-Google-Smtp-Source: APXvYqyy6s/OxXDpS2wzSeRvub5PBhgynaZlFg4gOVymPGcwhTencwnuoAq/IVYZICmXD0U/7Lc+KmGGhsXhNNDzCvM=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr342149ejd.260.1554217234938;
 Tue, 02 Apr 2019 08:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAP5K-1YJN9jt_6yEbLs=ET6M2tRLMMoio65GJMsJy69Y+LCn1g@mail.gmail.com>
 <xmqq7ecdutq2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ecdutq2.fsf@gitster-ct.c.googlers.com>
From:   Chanseok Oh <chanseok@google.com>
Date:   Tue, 2 Apr 2019 10:59:58 -0400
Message-ID: <CAP5K-1YC=2gW1Wd37Ggp-XpRzhpTVysV2QYdtKOLtQbFY=i3mw@mail.gmail.com>
Subject: Re: [Bug] git log - reports wrong date and time
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out I wasn't using TZ in the right way. One of the formats for
TZ is std offset, where std string specifies the name of the time zone
(such as EDT, PDT, KST, or JST) and offset is the time that should be
added to get UTC. In this format, you specify the time zone
information directly, which means, it is your responsibility to
specify the correct time zone information. Below demonstrates how this
format works:

$ TZ=UTS-3 date

$ TZ=KST-7:30 date

$ TZ=JST+12:22:12 date

Thanks for you response anyway, and sorry for the noise.


On Mon, Apr 1, 2019 at 8:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Chanseok Oh <chanseok@google.com> writes:
>
> > BROKEN: anything other than UTC reports wrong date.
> >
> >     $ TZ=KST git log '--date=format-local:%Y%m%d %H%M%S %z (%Z)'
> > --format=%cd -n1
> >     20190401 210250 +0000 (KST)
>
> I think you are probably on a system where timezones can be given
> only with a more modern and unambiguous style and not in the
> potentially ambiguous abbreviated form.  Here is one experiment to
> show what I mean:
>
>     $ TZ=KST date
>     Tue Apr  2 00:29:51 KST 2019
>     $ TZ=JST date
>     Tue Apr  2 00:29:51 JST 2019
>     $ TZ=Asia/Tokyo date
>     Tue Apr  2 09:29:51 JST 2019
>
> Two points to be learned from the above exercise are:
>
>  - It is not limited to your copy of "git".  Even a system supplied
>    command like "date" does not work with "JST" but it can grok
>    Asia/Tokyo just fine ("JST" does not necessarily have to be
>    "Japan standard time"; it could be Jamaican ;-)).
>
>  - It is not limited to KST (is that Kabul standard time?  Khartoum?
>    Kinshasa?).
>
> Perhaps try TZ=Asia/Seoul or something?
