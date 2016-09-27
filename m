Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1181A20986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755683AbcI0SZK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:25:10 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33685 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755322AbcI0SZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:25:09 -0400
Received: by mail-qk0-f193.google.com with SMTP id n66so1315321qkf.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i7iXdIcwHBnx0+UZULkT5Af8844Qv75bfoxhuqk8UkM=;
        b=QNx8HDaCdt9IaLio5m6HMkaGvkCm6UxPQAf7+6zuOxaDOaMiIako3z7zBTnC+M+eTh
         RTskIl7xF49qtUYkG7c4lknegZTeJFm30P6YXJ8Gg2JlZqhD0VPpcpCWrzu+GRC9GHe3
         wT55K/x7FTvbMoyviR7qbH+CILmctx0OM/YBYfQIL5Tscu/8lX4kwXnPzo4rHl26Q5hX
         vtM4FRvuCKEIYr+XwyTNOYbbqonTNl6qYXkvq0TaJPA5SeBGewJRTnGoW6dwRzka311v
         fRmSn4cMKXN1iTnBIbLI26Yb9eUF55NRmqfS6CW8jmbG0yHnAJB0uuSLQb0QFoqu5fZi
         Rq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i7iXdIcwHBnx0+UZULkT5Af8844Qv75bfoxhuqk8UkM=;
        b=KqnCsth15Jll/MN6r3vTef3lkW9qjAQ5mxwXOY2Zk9FuVBek7R3vAifAQc0a0CrruF
         PwYMlHmwyK5hIfjv5ZnfsTv+JDVPbPblKNFOtHOYqj8GS8BkpKXdo9lsASHeyFvEhioJ
         5wEPCvl/QvmfZBC7Tj5vfEe5w10bKzkzIv/hyDF/TvJc7oAuY2ToffpVgjDt30nE9aYK
         t/jgP6peIdcS81T/VDr1NzY3Wl/jiF+Iss3ayxRjWRzROCTmRwAYTxE+Ig7jsu48/Eo3
         QQg2vQ6xXyr/LGRyBkc2HI5iaXOJcbUlHZB6aQr16oR2sXRjc9Z+chksDPqB0ybl82Of
         9Rhw==
X-Gm-Message-State: AA6/9RnCySwg0AHZe86rElXkMD0pAnMOs51+sNKecP5yaTjbMBIQpxDRteNZlHVw4u9nIA==
X-Received: by 10.55.16.9 with SMTP id a9mr14996233qkh.268.1475000708380;
        Tue, 27 Sep 2016 11:25:08 -0700 (PDT)
Received: from 172-16-18-121.dynapool.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-06.NATPOOL.NYU.EDU. [216.165.95.77])
        by smtp.gmail.com with ESMTPSA id d27sm1845945qtd.37.2016.09.27.11.25.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 11:25:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
From:   =?utf-8?Q?Lukas_P=C3=BChringer?= <luk.puehringer@gmail.com>
In-Reply-To: <xmqqponpnqyf.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Sep 2016 14:25:06 -0400
Cc:     santiago@nyu.edu, git@vger.kernel.org, peff@peff.net,
        sunshine@sunshineco.com, walters@verbum.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D863101-CA73-4718-A1E7-A1664A5BDB58@gmail.com>
References: <20160926224233.32702-1-santiago@nyu.edu> <20160926224233.32702-2-santiago@nyu.edu> <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com> <15BEFDC3-81B2-47FC-A213-F37B4E6020D2@gmail.com> <xmqqponpnqyf.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good, I will change it to 'Lukas Puehringer' then, when we send you the =
updated batch of patches, that address your latest comments.

Thanks,
Lukas

> On Sep 27, 2016, at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lukas P=C3=BChringer <luk.puehringer@gmail.com> writes:
>=20
>> Thanks for checking. I am fine with Lukas P, unless git prefers
>> full last names. In that case I am fine with changing too.
>=20
> We do prefer full names, so that it would be consistent with court
> document when you are involved in copyright inflingement case ;-)

