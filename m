Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B2720986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935741AbcI0SRp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:17:45 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35211 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbcI0SRn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:17:43 -0400
Received: by mail-qk0-f196.google.com with SMTP id j129so924144qkd.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1YChorHEXWNtDzH1uRSLrOe2mxZ2aA6k/zvUOJrhPmc=;
        b=0ygVD6Ij51t0CrZ+lh/ydnxd8cRl2h4/3GyQ6t13+CKt6UkTFjTgCjqrDowdzqXTlx
         0Dh5J8fTcqmNX/4+5X66MMSFwWMniQnTbhtSJlTlHwCyST2nS66RHrhjs2uWfmJM9H9v
         GYDIE2HfqgAZLkzn0I/pdCSSo2TK6CAOKAyeQ9F6rA+g9PPB84+dBlXEJe5ZipSd0tR9
         Y+SB/aEQln4UJbkuAdPKqqOTReWqY56Bzz+SXLyXmCk1ITFCo0FYfTLEMz6zMSlrF3iZ
         H+Cq1z/BpSZsWQHeHKNnSR6M6j0w9Bg2y1dY28qbfNvQKa3lGnHur2DSUavBCHJgl8kJ
         P1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1YChorHEXWNtDzH1uRSLrOe2mxZ2aA6k/zvUOJrhPmc=;
        b=U7K95q6okzQInOfZAACEzh2z6nuwomImltdxTwMDOal5LwOGtjggFxE5KiFzAPq+sv
         bpr8TdFQtDGVI50Eu4HAmOFriUhjWKQYYerSqNlClrrPmBawFkUq9ol4gV8/LZ4PfL5D
         /bkCMvV017qW5/06U1uQmrVtLWH5779BTj0KwJcdRLg5SAfwoybAx9ng9X/Op1bGy3sy
         XWBXOmUqER/DnrK0H4LlzxwWLaIIA1P39OcBU8fNAkKB2HjuCsKeM/KjhnjcRD7BwJgm
         5oL1illztFA+BiPhtiuMn0qz76V30b0Js8jw83TryT0pZZpXko6TyX1Y4HFtX0wHhEEH
         2Qww==
X-Gm-Message-State: AA6/9Rk8RSQicllcthaoDBP9njZUw4JJekoBuNPHOapMETOjz9mx0+p+/+RWX8prDty9KA==
X-Received: by 10.55.100.150 with SMTP id y144mr1356112qkb.281.1475000257539;
        Tue, 27 Sep 2016 11:17:37 -0700 (PDT)
Received: from 172-16-18-121.dynapool.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-06.NATPOOL.NYU.EDU. [216.165.95.77])
        by smtp.gmail.com with ESMTPSA id a192sm1838321qkc.26.2016.09.27.11.17.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 11:17:37 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] gpg-interface, tag: add GPG_VERIFY_QUIET flag
From:   =?utf-8?Q?Lukas_P=C3=BChringer?= <luk.puehringer@gmail.com>
In-Reply-To: <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Sep 2016 14:17:35 -0400
Cc:     santiago@nyu.edu, git@vger.kernel.org, peff@peff.net,
        sunshine@sunshineco.com, walters@verbum.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <15BEFDC3-81B2-47FC-A213-F37B4E6020D2@gmail.com>
References: <20160926224233.32702-1-santiago@nyu.edu> <20160926224233.32702-2-santiago@nyu.edu> <xmqqbmz9p7m0.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for checking. I am fine with Lukas P, unless git prefers full =
last names. In that case I am fine with changing too.

Best,
Lukas P

> On Sep 27, 2016, at 1:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> santiago@nyu.edu writes:
>=20
>> From: Lukas P <luk.puehringer@gmail.com>
>>=20
>> Functions that print git object information may require that the
>> gpg-interface functions be silent. Add GPG_VERIFY_QUIET flag and =
prevent
>> print_signature_buffer from being called if flag is set.
>>=20
>> Signed-off-by: Lukas P <luk.puehringer@gmail.com>
>=20
> Are you and Lukas sure that "Lukas P" is how luk.puehringer wants to
> be known by the world?  Just checking.
>=20

