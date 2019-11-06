Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BFF1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 22:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKFWH4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 17:07:56 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46887 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfKFWH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 17:07:56 -0500
Received: by mail-wr1-f52.google.com with SMTP id b3so383277wrs.13
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 14:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=niemier-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xsPildYjx0lYXi/lUaUiV8/OTAQM3fbRv5QIzxnx87M=;
        b=b2PKIBRmtUyptSHWuMxcQXmHkh+O+twHJviFOI3W2CAQYM87WnlxdpzDAQGeXwj2zU
         0nC8S5g+fTqf5+6Uu0LihEUzBs+4b1PJ8ucucJT2J0kGi6lUTSiRyAVpmxnaHM3geDHh
         rqRx5FKHZpwLbYat6f5ZvG58eUK6VIdzNJAhzuZobaU1ZdE9q1BxXiaZM6b9DmCF7TUM
         N0Y4tTXPeYQm0oI/U/Z0RHrrkJtN0QBe0oPpALO+O5cO6UURJtqHhWDSw3lghvbBvVZp
         1MlX40nclW46TR5AjmLkSvisreIkmBk9u+hd1MCIUxB5Ae4os8lML8V43V83ONq4xmKk
         7lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xsPildYjx0lYXi/lUaUiV8/OTAQM3fbRv5QIzxnx87M=;
        b=ajLdwt7ofpoxvm2kUgdZ0EtCyFZoCdORte0kviPMmxqhR8YPVY6EawMfCUQpIFf6FL
         dQYlInrujss8LVnEk2OvaFeDNwdF47+W0bVfwFHRJaJDMB1DjXjODZ6bIvj44MMgh3Lm
         C+bEZ3tqzAYAMqCBbsziyhG7LjHSXmNaQlgPp2n+SnFJbGytTuShXB7mFaUIWLhbbz4c
         uVkQckZhk/V0/YbqPgF1PEY0ZZOjyPM9Heaxa7Nd+zvf9s3d5JPxlamTIulvlqBWPYEk
         5URYwxomS2SYZYfiQL4NNkQZn5mjhuCIm/OQDcln/U4ypkOlQHF6W0g31ekvzjxltKqX
         uUcw==
X-Gm-Message-State: APjAAAWlS41OQQ++Yd5zWS/osI0jMLAsDxYEwQONA2hBQL8rCHeSoct6
        XumokCZF5By84oEoGvZDwLOGOsQf9u9vKA==
X-Google-Smtp-Source: APXvYqxfLD5HU5XuEq/38btTOAbjCW2JyxW1xOhoq9ajlexfnwurRCXIKJ1nbaD21tELwg5znUMgbA==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr4653112wrm.102.1573078072464;
        Wed, 06 Nov 2019 14:07:52 -0800 (PST)
Received: from [192.168.188.32] (83.25.107.61.ipv4.supernova.orange.pl. [83.25.107.61])
        by smtp.gmail.com with ESMTPSA id x9sm75108wru.32.2019.11.06.14.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:07:51 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] feat: add Elixir to supported userdiff languages
From:   =?utf-8?Q?=C5=81ukasz_Niemier?= <lukasz@niemier.pl>
In-Reply-To: <672bdea4-180a-89e0-c420-df2704ed887e@kdbg.org>
Date:   Wed, 6 Nov 2019 23:07:50 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED332708-76D5-447F-A2D7-6495CC6A76DC@niemier.pl>
References: <20191106174844.23482-1-lukasz@niemier.pl>
 <672bdea4-180a-89e0-c420-df2704ed887e@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please use "subsystem: short description" in the subject. For example:
>=20
>   userdiff: support Elixir
>=20
> would be sufficient in this case.

Ok, will fix.

> Please add your sign-off before the three-dash line so that we know =
that
> you are entitled to publish this patch. See =
Documentation/SubmittingPatches.

Yeah, I have seen it too late to fix. Will do.

> It would be enlightening to know what Elixir is. (I haven't googled =
it,
> yet.)

It is language with Ruby-like syntax for BEAM (Erlang virtual machine).

https://elixir-lang.org

> If it were a popular language, I think I would have heard about
> it. But it may well be possible that I have lived under a rock for too
> long... ;)

It is quite popular among few services (Pinterest, Discord, Bleacher =
Report),
but it is still pretty new, and still need to get a little more =
spotlight.

> This list is sorted, basically, but your addition perturbates the =
order.

Oh, sorry, I missed dts.

> The default hunk header pattern picks up lines that begin with a =
letter
> without leading whitespace. The tests that you present here do not =
show
> that the language specific hunk header pattern is better. The default
> would have picked up the correct lines. And, in fact, when I remove =
the
> pattern from the code, these tests still pass!
>=20
> I'm not saying that the pattern is bad; I say that the tests do not =
show
> its worthiness. More tests are needed. For example:
>=20
> --- 8< ---
> defmodule RIGHT do
> end
> #
> #
> # ChangeMe; do not pick up 'end' line
> --- 8< =E2=80=94

Yeah, I will provide such

> BTW, I guess that any def, defmodule, etc. as the first word on a line
> in the docstring would be picked up incorrectly. Is that a problem?

No, as this would (almost?) always be the definition of the =
module/function,
so it is not a problem at all.

>> +	 "|:'a-zA-Z0-9@_]+'"
>=20
> The opening bracket is missing here.

Whoops.

> Would it be an option to collapse all but the first pattern (because I
> do not want to start the pattern with an optional part) to
>=20
> 	"[:@]['\"]?[a-zA-Z0-9@_]"
>=20
> This assumes that @"x1 and @'y2 cannot occur in a syntactically valid
> program.

No, these aren=E2=80=99t valid.

> Remember: the patterns can be loose; they do not have to
> validate the input, but can assume that it is syntactically valid.

Ok

> Does the language not have any two-character operators, such as =
'<=3D=E2=80=9A?

It has, I should add them as well (it even has 3 letter operators).

--

=C5=81ukasz Niemier
lukasz@niemier.pl





