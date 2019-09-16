Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37551F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbfIPT7U (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:59:20 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:36783 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfIPT7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:59:20 -0400
Received: by mail-qt1-f179.google.com with SMTP id o12so1434511qtf.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIzolD3UqbgrCrD5ajq2o/QdDJK06Fz4CzeATPtDmeE=;
        b=Fs9kG8brP9eLN7zKZd9vIam6LDqVfnKJvHHKdNERH42B0QrkH7ljPLJ1j93OKk+Ukd
         AVWcN4S0Cd38H87ClARtr8s5kzbyes0KicYhAs3SLgl3cK49jW7bzlEFVJgJANZSParB
         2ivxgUlbOIW/8ANyjgDdlBEjfJo0Zq8jh+iDSKvDiubcYiV911JwCKYwz0uv/pZx9GUk
         Qgd6xhbmFU4btVVQ++mzIseRclTHY8/IBsQByThzlz3CrESiis7PtSlPlFMghj7uQ1Mb
         tbFheaTxYX6dtQB+9H8Ko0vnBA/iqF1ID9HarU2sA1wECwgpr+RaPu99oE3/ceZGCGZ0
         KRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIzolD3UqbgrCrD5ajq2o/QdDJK06Fz4CzeATPtDmeE=;
        b=CVRLfE50OkU5b7Brc1I9oJZTvgkxDGwj/F0NyOu9VF7t4wsya/rBQ6PsTIyKIr3VCe
         f0HcCLHv+omEMmb8r/VEruI0Z8vwzpOz2WyQ7tQLHvh8CEaiNQdQBgBKHREVyypKLXpf
         WdDB6HFhzLHbivNuoYv1+YBGHvCoeSblPVGikboTNdfSebKb2eroEnhRWrgL0ISNYFBz
         0RGlW6yuJUDV21Ngw4Zvt5wntuKfB+1MaCH4nlkMXvD1FLIx5uxBMAtW4eR7KB3gddok
         djtQg/z9a+MK+6aWACewOcaO6sABe/QSepUFH3PJL0ihX+QOXBk2YhnsV6ssNKSFgQrh
         zHOQ==
X-Gm-Message-State: APjAAAVay+BHIhA6kvr89HM9mEY5S+gbuo0H5+M2BOcuz1y/6CbhBRWo
        aCDiDx6AgUa3mrkpVpcV9W4=
X-Google-Smtp-Source: APXvYqzKevtl5rETgYD02apAC8Mn/J65e/Gunw/UCuwcA7BvfLocRhw6cNvhkd1NN+lqg5pJR008og==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr149363qtn.26.1568663959627;
        Mon, 16 Sep 2019 12:59:19 -0700 (PDT)
Received: from localhost (adamsmorganips06.a.subnet.rcn.com. [66.44.93.133])
        by smtp.gmail.com with ESMTPSA id m63sm3190234qkc.72.2019.09.16.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 12:59:18 -0700 (PDT)
Date:   Mon, 16 Sep 2019 20:59:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: Git standup on IRC
Message-ID: <20190916195917.GB11444@cat>
References: <20180713170018.GA139708@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1909132353310.47@tvgsbejvaqbjf.bet>
 <20190916195058.GA67467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916195058.GA67467@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16, Jonathan Nieder wrote:
> > (In case it was not clear: those standups are meant to offer a really
> > informal venue to talk about patches you are working (or planning to
> > work) on, _especially_ for people who feel intimidated by this here
> > mailing list...)
> 
> Thanks to Thomas for setting up the calendar
> https://calendar.google.com/calendar/embed?src=nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com

Here's a link to it in .ics format as well, as that may be easier to
subscribe to, depending on which calendar apps folks are using:
https://calendar.google.com/calendar/ical/nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com/public/basic.ics
