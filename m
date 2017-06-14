Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776C320401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdFNKXO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:23:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33810 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdFNKXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:23:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id u101so38336766wrc.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QXTi15cDnsod2pbyWDI3fT6MF4pKm3SsD9F0wmXs+yQ=;
        b=k7XI42RxyBAszfHXj8QmdNLcsGchiZOdAbMtmIkhqZX5FcRHeTH6k/OnOgzYxRBKh8
         XtATMaW3ZXeCZ1q3VIIRGSXEDVtN3+4hDDKUxw5XEPVqFA72FiWsiQ2AcLa4b0ikNCkn
         +AELJe+MukGsJE3QEAiJttib8FuD7QqrabLNnvZn7wDJS+3XHw5xE1Kt/BYscaM+TDm7
         BlyZzudNjY50tA99j7pra4PjRSI20WHv5N+zdtIiG+NkWj5FtnWzW8ZKhlvvsIfc3zne
         iqS5HEVA031hkcV8lBY8eUTfNee2neee9jsJs75IBYdXgxbqftNDCg1jS2qJ4/vpFFRV
         S8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QXTi15cDnsod2pbyWDI3fT6MF4pKm3SsD9F0wmXs+yQ=;
        b=jXNoa+4Jec4KfSbhg/UhWaJjcy/poSWRN0wdSveqAwZim993YtteSjqo+u3v1VRJ7e
         tRrwgJNdZbWT6OM5hdOnTTcNvzHvlEF837mVkHycaXtV/9Mx3qO+mO6FdJLEcrwbUY/N
         srS+0tI5m//21FOemnjDiruK9t0I7JJ5B3x44HjXIZkI7cJO8JmxfRTsDHkch7yMZDdp
         Ju3qa8+AaADsLRUpVsfkU/1HHI0mUWcas8n7ytKvCom5oN/f4Rr/GQKfVITzx3rjAqb3
         LCMdG48WC862JkNvN4bWFBqgq5ZvYhz6O+rlSJe7Dt4X9EgpUsPUQ2FEG7SIHYiLBHs+
         5mSg==
X-Gm-Message-State: AKS2vOz1Lqz1rANMqYLjZcY9EjUUJAtg+0cO9b2AxZ6u+pWKtwJYjcPW
        WNzNakciK6mOjw==
X-Received: by 10.223.128.80 with SMTP id 74mr4167923wrk.9.1497435792268;
        Wed, 14 Jun 2017 03:23:12 -0700 (PDT)
Received: from [10.146.248.57] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x94sm625691wrb.47.2017.06.14.03.23.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 03:23:11 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk24e51my.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 14 Jun 2017 12:23:10 +0200
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        philipoakley@iee.org, jrnieder@gmail.com, avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6A28A03-241E-4201-B0B1-DBC0FAC4329A@gmail.com>
References: <20170613081807.33196-1-larsxschneider@gmail.com> <20170613090427.igjz7erniblh3wie@sigill.intra.peff.net> <FEFF27D2-1A56-4F37-8114-126613C144A0@gmail.com> <xmqqk24e51my.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Jun 2017, at 12:01, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 13 Jun 2017, at 11:04, Jeff King <peff@peff.net> wrote:
>>>=20
>>> On Tue, Jun 13, 2017 at 10:18:07AM +0200, Lars Schneider wrote:
>>>=20
>>>> changes since v1:
>>>> * mention submitGit
>>>> * link to mailing list address instead of mailing list archive
>>>=20
>>> You might want to link to https://git-scm.com/community/, which has =
a
>>> section on the mailing list at the top. It gives the list address =
but
>>> also talks about the archive, that you can send to it without
>>> subscribing, etc.
>>=20
>> Agreed. I removed the mailing list email address as this is not
>> useful until you have subscribed to the list.
>=20
> Wait a minite.  As Peff explained above, you *can* send to it
> without subscribing, so "as this is not useful until you have
> subscribed" is quite wrong, no?

Oh, I didn't know that! I "subscribed" before sending my first
message :)


>=20
>>> The text itself looks good, but two minor grammar nits:
>>> ...=20
>>=20
>> Agreed!
>=20
> This I think I've already squashed in to v2 before pushing the
> result out.
>=20
> I do not terribly mind what you did in v3 to the list address,
> and I do agree with Peff that mentioning the "community" page
> is a good idea.  But
>=20
>     Git community does not use github.com for their contributions. =
Instead, we use
>     a [mailing list](https://git-scm.com/community/) for code =
submissions,...
>     ... and bug reports.
>=20
> looks quite wrong.  If it were
>=20
>     Git community does not use github.com for their contributions. =
Instead, we use
>     a [mailing list](mailto:git@vger.kernel.org) for code =
submissions,...
>     ... and bug reports.  See [the community =
page](https://git-scm.com/community/)
>     for further information.

Looks good to me (minor nit: maybe s/the community page/our community =
page/ for a
more personal touch?). However, I would apply these changes only to =
CONTRIBUTING.md.
Markdown links wouldn't work in PULL_REQUEST_TEMPLATE.md as the user =
would see
the Markdown in plain text and not rendered.

Example here:
=
https://github.com/larsxschneider/git/compare/master...larsxschneider-patc=
h-1?quick_pull=3D1

Thanks,
Lars=
