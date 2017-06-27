Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D15C20401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbdF0V66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:58:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36379 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbdF0V65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:58:57 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so32916124wrb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ZQ30N6HbbGGNZw2MTMw5TJTgL4mBSNPgEVMNanntdw=;
        b=C0po3Md69tA2Okfflya6BZuRc+24/42kvKbKNOUFxg6l3wlfynJsTG0sC10y1S8VGi
         tgr2nyUVk6/1xg2clZsoLWhJBO3UrXhNfcMoFGHQU/YGkyJkWhwAHJ4PrbBIzNWYTIiz
         ek48d4Xy0kHZFgXCJvgqu6giFri0+VkMHUWmk/uyhY/f1ZMTHomNL+bn0DG8pWTlWgWc
         YNN8+1srTBIzuxz09F/EJlu07yzbZhKCqmtje93gkXq5YEHmhCAOSxbQppIDjCWY8BTA
         zKylqGjbhMETNJl0NypOBGebdHHki2RSpdLpr34AwJxo/UUgauSLK0tdShoG0j6Mmp1j
         dRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0ZQ30N6HbbGGNZw2MTMw5TJTgL4mBSNPgEVMNanntdw=;
        b=FNgtWgzN+lmSIeujBEFeCMqp5GlpyAMGEimughWOJtMVjDl4t0WIJkw7q/9Zz+A8St
         ReaT2FG0Yc4d/tEodcJmLGit/gHE7T28pRF+I0/TTrAmricqszE0rT/nD35OXOKKkD+s
         MGwEJFtTl5aXqFC877Be0muggRBvGp0HmYurIqGsUkSS4pc5P9Fyl7/zqjUaWYk9ZuBo
         Hv31osGWbAWMdb6bgjKg23hvrXii3f8CiLjXPxaG2gqkMLsnhJ9WsYFvjCo4ONOTR1pS
         QtkoHbSylVw8MPiyC0i9BbEseShcDV6vqBYe/WMn/BzOJcuItRrV8VVg6qetLFU1c0lQ
         oSzw==
X-Gm-Message-State: AKS2vOx0FXnU8Q5fvtUk/uIQwPSD+Jgm4FwFgkTtY6zr4g56jkY0jAbh
        dAi1cgVJXL+3pA==
X-Received: by 10.223.154.141 with SMTP id a13mr17303498wrc.139.1498600736432;
        Tue, 27 Jun 2017 14:58:56 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4DFA.dip0.t-ipconnect.de. [93.219.77.250])
        by smtp.gmail.com with ESMTPSA id n31sm320499wrn.59.2017.06.27.14.58.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:58:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgodyv7k.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 23:58:54 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AC7FBAA-59AE-4CC3-A9CD-725B53FD1ED4@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com> <20170627121027.99209-7-larsxschneider@gmail.com> <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com> <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com> <xmqqlgodyv7k.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Jun 2017, at 23:30, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> I treated that as low-prio as I got the impression that you are =
generally OK with
>> the current implementation. I promise to send a patch with this =
change.=20
>> Either as part of this series or as a follow up patch.
>=20
> Sure. I was just being curious what happened; I agree that it is a
> good idea to treat this as a lower priority clean-up item and leave
> it to later.

I posted it here:
=
http://public-inbox.org/git/7FF53F59-1240-4BED-999F-FE9C9AD7E6AC@gmail.com=
/

If you are OK with it, then I will post a v8 with all changes combined.


>> Yes. I guess that was a premature optimization on my end.
>> This is how "write_entry()" in entry.c would change:
>>=20
>> -                               dco->is_delayed =3D 0;
>>                                ret =3D async_convert_to_working_tree(
>>                                        ce->name, new, size, &buf, =
dco);
>> -                               if (ret && dco->is_delayed) {
>> +                               if (ret && =
string_list_has_string(&dco->paths, ce->name)) {
>>                                        free(new);
>>                                        goto finish;
>>                                }
>>=20
>> OK?
>=20
> Actually I should be asking the "OK?" question---the above was what
> I had in mind when I commented, but you are a lot more familiar with
> the way how this code is supposed to work, and I didn't know if the
> emptyness of the list can be a 100% substitute for that bit.  If you
> think they are equivalent, that is a great news.

Yes, I think this should be equivalent.


>> At this point I want to ensure that checkout_entry() is called
>> with the CE_RETRY state. Because checkout_entry() needs to pass=20
>> that flag to the convert machinery.
>>=20
>> This assert was useful when checkout_entry() changed dco->state
>> between CAN_DELAY and DELAYED. In the current implementation the
>> state should not be changed anymore.
>>=20
>> Would you prefer if I remove it? (with or without is both fine with =
me)
>=20
> If that is the reason behind the assert, I am OK with either (1)
> moving it _after_ checkout_entry() returns (to ensure that the
> function no longer mucks with the state, or (2) removing it.
>=20
> Leaving it at the current position does not make much sense to me.

I'll remove it.


Thanks,
Lars

