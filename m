Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266901FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 10:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762484AbdAKKUv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 05:20:51 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35899 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762451AbdAKKUt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 05:20:49 -0500
Received: by mail-wj0-f196.google.com with SMTP id dh1so9845387wjb.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 02:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vuUdoB+7lD+WpUJN09t3cVLU7Ytv/ysKqvD3Wzek62s=;
        b=h3OTRdMOV+17w9C8Rb+sVnX9ljrN5Oz8UxTeUC23zvtLFEoU864blJpS6CidYUWEMT
         UFLpKSt2x9aFmBq7AbOwsTzPC+FIDR6LXl4F3GYGEJf0/FqcBs/L9DgE7bIHqf1Wlu3S
         4/WWA1Bg74Rs6gP5Bk7V9gUpDWkqcwnqbh0n40eIf8HLnbGK/AKjfcxS3U8DbBeCyo7u
         zBmbA0CRpjo3riZe5JSdR+dMFIDQwAxNoTdPmcJ9kFbSMLsNj5bVvJmsQoHHal0mY6/s
         Sj3g7tygyQ3FUdTvcisZr4/TA/E8BrTBfEFjGbgJ/nvIIONVAvugZyyWFheGuLhd59pN
         bNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vuUdoB+7lD+WpUJN09t3cVLU7Ytv/ysKqvD3Wzek62s=;
        b=tQZz7P+aqM2JWllGytYhmckDMnafyxoGf2gl7RcOLmndtrAAQBsP4AAzYA6nRxRrdv
         qUvCbHgN9kd180fPuITGlRvQc/MKAqQ+rmTtR/l6dD2om74AZuNWfZhquM2V7v3iTA5j
         34+ENa9K15Vssek4tma+9Q+76qBqWOHp1kyyQoUiPziypAPPIpsjco9tnFQ7Hr8Wp1pv
         6V9NurR7p+ptsgbTGFdhy6VdCBxL9ORJPSbj083+zlDh+zJ2zlRRhtP8u+lswpWTXUgC
         cbwno4zEpUn6EE/QvLA73HlBNTKaWF4umTeJumBsAQ6GGIolaJWPQH6HNHe0AKOTbM1q
         V8Mg==
X-Gm-Message-State: AIkVDXJaiOHDabo6GJ5CSLQ6U0qyioHA3VsXI7jDo90X6exBHLXsc4wOHnHsJDIyxK6XSw==
X-Received: by 10.194.66.101 with SMTP id e5mr4413347wjt.172.1484130048492;
        Wed, 11 Jan 2017 02:20:48 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5866.dip0.t-ipconnect.de. [93.219.88.102])
        by smtp.gmail.com with ESMTPSA id d29sm8251921wmi.19.2017.01.11.02.20.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 02:20:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
Date:   Wed, 11 Jan 2017 11:20:47 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A1064BB-DA72-44DB-A875-39E007708A69@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com> <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com> <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jan 2017, at 23:11, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 09.01.2017 o 00:42, Junio C Hamano pisze:
>> larsxschneider@gmail.com writes:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>> Some `clean` / `smudge` filters might require a significant amount =
of
>>> time to process a single blob. During this process the Git checkout
>>> operation is blocked and Git needs to wait until the filter is done =
to
>>> continue with the checkout.
>=20
> Lars, what is expected use case for this feature; that is when do you
> think this problem may happen?  Is it something that happened IRL?

Yes, this problem happens every day with filters that perform network
requests (e.g. GitLFS). In GitLFS we even implemented Git wrapper
commands to address the problem: =
https://github.com/git-lfs/git-lfs/pull/988
The ultimate goal of this patch is to be able to get rid of the wrapper=20=

commands.


>>> Teach the filter process protocol (introduced in edcc858) to accept =
the
>>> status "delayed" as response to a filter request. Upon this response =
Git
>>> continues with the checkout operation and asks the filter to process =
the
>>> blob again after all other blobs have been processed.
>>=20
>> Hmm, I would have expected that the basic flow would become
>>=20
>> 	for each paths to be processed:
>> 		convert-to-worktree to buf
>> 		if not delayed:
>> 			do the caller's thing to use buf
>> 		else:
>> 			remember path
>>=20
>> 	for each delayed paths:
>> 		ensure filter process finished processing for path
>> 		fetch the thing to buf from the process
>> 		do the caller's thing to use buf
>=20
> I would expect here to have a kind of event loop, namely
>=20
>        while there are delayed paths:
>                get path that is ready from filter
>                fetch the thing to buf (supporting "delayed")
>                if path done
>                        do the caller's thing to use buf=20
>                        (e.g. finish checkout path, eof convert, etc.)
>=20
> We can either trust filter process to tell us when it finished sending
> delayed paths, or keep list of paths that are being delayed in Git.

I could implement "get path that is ready from filter" but wouldn't
that complicate the filter protocol? I think we can use the protocol =
pretty=20
much as if with the strategy outlined here:
=
http://public-inbox.org/git/F533857D-9B51-44C1-8889-AA0542AD8250@gmail.com=
/


Thanks,
Lars=
