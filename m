Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38992021E
	for <e@80x24.org>; Mon, 14 Nov 2016 09:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbcKNJLm (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 04:11:42 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33449 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbcKNJLP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 04:11:15 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so13394895wmu.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 01:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qQ1nyRR+U3vicG6NRX3sZPZgaykVUxf3ts9sTH46hm8=;
        b=R/8a4JubeiYuQnpxzWN/SOjstrO7tll4ab8xXaB7oCDafNx9lXTBtQdymlFY8302Mf
         ECTP48DHAI1boQFHas58kDt10GECB9SFVEId1Yrl/BUawOyDEl0PwlsAzmC31iJQDjyN
         c0RXsvIKMrjTnZQZv3xgu7Sh1hbmwyU7LD3hHrjn5qh9ns0sRA3C0loL1dCdi7W4XJ3V
         VSKvQhdO5va5UeGVbw0ZltevE/Rly3jcCSTsMmDwBvQsJlyKfe3zqf1vrjqdcq18clL/
         tFd8BYaOkAymq106l8TVxY/Q2ijherx2gdB6Egze9YS0E0zURwEV9gQkP8ghTYz3Qpzx
         gwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qQ1nyRR+U3vicG6NRX3sZPZgaykVUxf3ts9sTH46hm8=;
        b=KwR+6HHZNlyofyyNc5Rt6nc4+VGmQd+y/3Zh8ftcbQxjcWjZ+2zGvS9QPifDF9JuRt
         9M4xtTSJO5nwhQR+8yOa6/J8LdMlJKY2/8CEviZ/vNFUBwt5pZCiVtEJp/iI++43Db7B
         3KKB7VcVbV+iqMSq0LKFmfbcSiFMRtg2XO6jJH9s+c+890zU7vPTMY2OPoYNMf9j78Lj
         CuO5c7vNYKeLTUB+jPN6zaS6ksfz8lNslF2Be8Dr1+pAoAaGGtJUxdrbwfnqxHj7igb4
         WOsKEbH/YT7OoHyloZRK62zYUv448y9R0SCJvGoK32fcMCy6VqshNMlNnHilg9GW0uCO
         Kpig==
X-Gm-Message-State: ABUngvcVTsJ+iVJQ2ixSJxpw7orGJz5qI2G2M/5u+mui+TSnczWc5a9upIoC12qcTeSFbA==
X-Received: by 10.194.248.233 with SMTP id yp9mr18343545wjc.228.1479114674148;
        Mon, 14 Nov 2016 01:11:14 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id k74sm28153486wmd.18.2016.11.14.01.11.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 01:11:13 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variables
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 14 Nov 2016 10:11:12 +0100
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de> <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com> <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org> <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org> <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611121237230.3746@virtualbox> <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Nov 2016, at 02:13, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
>>> Thanks.  Dscho, does this fix both of these issues to you?
>>=20
>> Apparently it does because the CI jobs for `master` and for `next` =
pass.
>=20
> OK, thanks for a quick confirmation.
>=20
>> The one for `pu` still times out, of course.
>=20
> Earlier you said 'pu' did even not build, but do we know where this
> "still times out" comes from?  As long as I don't merge anything
> prematurely, which I need to be careful about, it shouldn't impact
> the upcoming release, but we'd need to figure it out before moving
> things forward post release.

What is the goal for 'pu'?

(1) Builds clean on all platforms + passes all tests
(2) Builds clean on all platforms
(3) Builds clean on Linux
(4) Just makes new topics easily available to a broader audience

My understanding was always (4) but the discussion above sounds=20
more like (1) or (2)?

--

Git 'pu' does not compile on macOS right now:
builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used =
uninitialized=20
whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
...

More info here:
https://api.travis-ci.org/jobs/175417712/log.txt?deansi=3Dtrue

--

Cheers,
Lars=
