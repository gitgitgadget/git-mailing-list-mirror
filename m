Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A891F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 03:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfKSDzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 22:55:40 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38864 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKSDzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 22:55:40 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so7551742qvs.5
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 19:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HKM/OKmHnJpQvb1eiwk2z8fYZGHYwRWUlmus9FW/LtI=;
        b=tpWkMoIQJ9r6VXLAesvs9MEc3c/9vBrUu4tNwDGzsuDSh+38t3Ual5QejwrfCQaKfA
         yXZT5wfdG+UQ8tvmHlxqMvOu0Lu88Y2t6OMOGftf6YxBr0nArjcWizFNWGGXs/82GfT9
         bVbxHymUsyD3AwP3itI2AUfuJ0ZWqbtJn3RJb6yEws/ho2aC+1R1SYb+lzF3CSdff4Nv
         ZqRVBC8BNzlYgR3ECafRpglrDjYysuCNdWW7LdO54xDBmN0+2g+MlpnUZcCl5m0ZvcMu
         AzEJHXt3vvJ0k4AekKQejZWbY0OqtRhXOU5qms79u7ADpfhVw9zRS8DtkFqiTfJK/0hP
         n2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HKM/OKmHnJpQvb1eiwk2z8fYZGHYwRWUlmus9FW/LtI=;
        b=mqvpujyedlnSVQCPFPPKjlorGetC8eOMyc47uH60tOVPKOk/ku+J1wCdTyAWc6vgDw
         2QEVUsa42J4yt6HfxGqVSoEQJaLRlKP3jB6O1MxIH+OLW338CqUWVDrk61PP2232HIvD
         cW8iG1J2Cx9RgKmiVUXuyNBzdUSLPRWw62G6QENKwMGQa4u9s+lRdmi6nnpVczofrHGO
         MBPFufbqcoPvlmThW0eZaDihevcZRTeflLxam0ksBPwpWYJWKWX74xzU+aDyZEAwSQQS
         +z4O54ir079tFIef2miPvTIvc+3HfGdPXdLc5JPNlUb0uHL/zryjeclNl9qjzsPW/7hG
         WjJg==
X-Gm-Message-State: APjAAAWrlb4RdzTYzkNVO3EjZLnByIw2tHNRysbmOeuUOKeZAxMieMPp
        wGoKffkwNN/Hwi+/pE4CTZHP8y5U
X-Google-Smtp-Source: APXvYqyHKO0dHqjKXnt9YtgTOVvgSpf+AFZExhUWDqEDz1gr8TPZiOQy0WZ/AVPxyeJkrYpTMczW6g==
X-Received: by 2002:ad4:4c4d:: with SMTP id cs13mr29965118qvb.165.1574135739270;
        Mon, 18 Nov 2019 19:55:39 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id s21sm12018919qtc.12.2019.11.18.19.55.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 19:55:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] doc: mention that 'git submodule update' fetches missing commits
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqsgs4nn6k.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Nov 2019 22:55:37 -0500
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B605234-8F49-4FEB-9156-22367E01B08B@gmail.com>
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com> <0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com> <xmqqsgs4nn6k.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

First off, sorry for not answering this summer.=20
Dscho suggested [1] I try to convince you.=20

> Le 20 juin 2019 =C3=A0 14:09, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> The additional text may not be wrong per-se, but isn't it fairly
> obvious that there is no other way than to fetch, in order to
> "update the registered submodules to match what the superproject
> expects =C2=BB,

Well, that=E2=80=99s true, but I think that it is important in the =
documentation to be thorough as to what git commands talk to a remote in =
what circumstances, and which don=E2=80=99t (this is something that is =
sometimes not obvious to new users in my opinion). Since by default =
=E2=80=98git pull=E2=80=99 will fetch missing submodule commits, it may =
not be obvious that =E2=80=98git submodule update=E2=80=99 will also =
fetch from a remote if need be.=20

> How else would the subcommand come up
> with the missing commit out of thin air?

Since 'git pull=E2=80=99 will fetch submodules changes, and is usually =
run first, the commits are usually already there, but I think it=E2=80=99s=
 worth mentioning that they will be fetched if they need to.

I like thoroughness in software documentation :)=20

Philippe.

[1] https://github.com/git/git/pull/596=
