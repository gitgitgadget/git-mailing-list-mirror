Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E7D201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbdF3Uoh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:44:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35395 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdF3Uog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:44:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so40133292wrb.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=viRgrsYQr7v5v9cY0ZsGE5d5WM0lm+TP3AHWm5JGRE0=;
        b=YVUOYkDgpzfG/zcwMQ5NgXTz8PSrh4kfPXpLslA07A1DWu4HHoJ4GUJb8fGVjC0bti
         56tiUWyKPd+ooS6EehYzHyVqHbotjudUTgM8lZ5iEkXWOu/3I4Jslxs1ZtwTq0HmE/cK
         j04jf7IYHGrGBVd7tKH0NQnjO4Ozj5cSqBBwUXwXm8fLXxBCAFNxk6Pgezj3Nb7CPGhv
         NTeqGzFMenPY+xGlGd/XMDSdjGKfiyCj73hj/dZL5LtjWldo+vRRja8/aKIJS9j1sm0j
         4N9vFyoBIKmUeaR1ijs2XF9gVWCIZUHzJVdDfVM503wdni0aVfDvssE4Q6C9DyOa30NY
         g+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=viRgrsYQr7v5v9cY0ZsGE5d5WM0lm+TP3AHWm5JGRE0=;
        b=b5OK3ELEwbd3gNXkaSPHc+cfZXAE/G0db4bm1vKSaGI9xprXQjjRJklC3rmFI1U3ig
         O0cmmZdJlEVzlLnxPWvKYZohwq7y1mMtmxQrJqHMwKtXB9fQUEBqO3BM2fVE73daqMs4
         xWLRQUUlSZ9U+fWAifzKoiFeRxu1grALQxKQydBylh89hrO4FAZHROJaaBW5Sl/tar3i
         oxJByAULThT1ooPrQsWGvIYYtW3CoiFph2vjJkH91j4wlvcD4fhdP8Dr7P9rp8fSm7GR
         uVx1tomK8IFPb2OLc+6TH720iCeWnrnps25bp5ZJ+C+E1QqbArL5tlWXjIUVa8VM5rVe
         EoNQ==
X-Gm-Message-State: AKS2vOzu2xiPlyL5HwGdw2h7NrECYxcfO+l727R/ZMea5qu/Gf8lbcAu
        u+m210f6M4nQVA==
X-Received: by 10.223.149.99 with SMTP id 90mr30924628wrs.46.1498855470124;
        Fri, 30 Jun 2017 13:44:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id n189sm3793516wmd.0.2017.06.30.13.44.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:44:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4luxs5hu.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 30 Jun 2017 22:44:28 +0200
Cc:     Git Users <git@vger.kernel.org>, peff@peff.net, tboegi@web.de,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D20EDDE-C3A9-454E-8678-2703676CC99C@gmail.com>
References: <20170628212952.60781-1-larsxschneider@gmail.com> <20170628212952.60781-7-larsxschneider@gmail.com> <xmqqinjetzgc.fsf@gitster.mtv.corp.google.com> <C36BBCCA-6694-40EC-8E1A-36B0CB9D4B2D@gmail.com> <xmqq4luxs5hu.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Jun 2017, at 20:19, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 29 Jun 2017, at 20:34, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> You seem to have squashed an unrelated "table-driven" clean-up into
>>> this step.  While I think the end result looks good, I would have
>>> liked to see it as a separate step, either as a preparatory "now we
>>> are going to add the third one, let's make it table-driven before
>>> doing so" step, or a follow-up "now we have done everything we
>>> wanted to do, let's make this clean-up at the end" step.
>>=20
>> I am sorry. That was a misunderstanding - I thought you want to have=20=

>> this change squashed.=20
>>=20
>> The "preparatory" patch sounds good!=20
>> Would you be OK if I send a v9 with this change?
>=20
> That would be more than OK.  I think we are pretty much ready to hit
> 'next'.

Done: =
http://public-inbox.org/git/20170630204128.48708-1-larsxschneider@gmail.co=
m/

My brain is fried already today ... I hope the commit message is OK :)

Thanks,
Lars=
