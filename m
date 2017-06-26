Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4641207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdFZScj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 14:32:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34016 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdFZSci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 14:32:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id f134so1773263wme.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PbmnCCpCVsEK7oDrAWmiK1IGhSDTput8tqVnEid/s2U=;
        b=Y/SKydF2Wooz+SRefnXh14A8YhMFfqK1QTOY/+dOEzqqsq7+UmRUvTtG4BVktpUwWX
         cerPINS9bON7rkMgArcK6IqYlAxgMR4XOCCg+UKizJk+z4SMfXKKDfpb9uDTC9dhnyl4
         i+CqgEYYVeOzaILVA65GXdRcu+Xfk0czjVQjnzu8D3I9he5UxykN10rMzogCyTdwHjos
         UothRXhRpQA7gJknG7hud0JoIvdwBzbYsVT8VaOdlDGupJCfEMz8+q/y5/TaJTvAqTyB
         2H4ylpL8AVQ9PI2Q6mvBTSvy7SrWHtCRba11rF6WsIkqa8GtJbYlCr0qaV7T3B5HhVRP
         namQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PbmnCCpCVsEK7oDrAWmiK1IGhSDTput8tqVnEid/s2U=;
        b=nTZ6xGp5HgJr1LeDWZJ0FVJ3MoscTOtv/PwJEYjdQZ7JPplz2J2U7dnbxvJDc0yQCj
         zlZ8ixNL29+ruwYc+kt0PruSq/NEo6nwM/PEpJfKaBf4Od5GGU4FHmxFY2LeOsevtJTu
         lGbQJOgmCdjS6iX+R2xoOwc113OGdaM8p3ztrDAZg3e85pasNWyvPWb+xGDkuVfh0lIQ
         WTPGeUwXg45r2yTiVMFyjMCcyA/jwt0e00dHLpMZkhMW6SjG6h/calSoa0W3btDj2cJL
         PYUPqvM6wwKWrgJSQiXzOoEJQcBZ832ZQzZD4Lq8zU3x70sX19xy0f34ThYGdScQpcCL
         WOFw==
X-Gm-Message-State: AKS2vOxmL0soCGyXNv1pksjfhU/NGGRoWti3FnDbVaSkpJ6zUmE/eeNd
        lsVnmoWUhmMzIg==
X-Received: by 10.28.20.200 with SMTP id 191mr603129wmu.1.1498501952338;
        Mon, 26 Jun 2017 11:32:32 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4308.dip0.t-ipconnect.de. [93.219.67.8])
        by smtp.gmail.com with ESMTPSA id c71sm308155wmh.21.2017.06.26.11.32.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 11:32:31 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 3/6] t0021: write "OUT" only on success
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2y663la.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 20:32:29 +0200
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>,
        peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AA7EA12-9EC1-48E3-A32A-BB7A406CE40F@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com> <20170625182125.6741-4-larsxschneider@gmail.com> <xmqqlgof7lw7.fsf@gitster.mtv.corp.google.com> <0FC46284-650F-411D-845F-0DF4F32071FF@gmail.com> <xmqqr2y663la.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jun 2017, at 19:50, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 26 Jun 2017, at 00:17, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>=20
>>>> "rot13-filter.pl" used to write "OUT <size>" to the debug log even =
in case of
>>>> an abort or error. Fix this by writing "OUT <size>" to the debug =
log only in
>>>> the successful case if output is actually written.
>>>=20
>>> Again, use of "Fix this" without clarifying what the problem is.  Is
>>> this change needed because the size may not be known when the new
>>> filter protocol is in use, or something?
>>=20
>> How about this?
>>=20
>>    "rot13-filter.pl" always writes "OUT <size>" to the debug log at =
the end
>>    of an interaction.
>>=20
>>    This works without issues for the existing cases "abort", "error", =
and=20
>>    "success". In a subsequent patch 'convert: add "status=3Ddelayed" =
to=20
>>    filter process protocol' we will add a new case "delayed". In that =
case=20
>>    we do not send the data right away and it would be =
wrong/misleading to
>>    the reader if we would write "OUT <size>" to the debug log.
>=20
> I still do not quite get "we do not send the data right away" as
> opposed to "at the end of an interaction" makes it wrong/misleading
> to write "OUT <size>"?
>=20
>    A new response "delayed" that will be introduced in subsequent
>    patches accepts the input, without giving the filtered result
>    right away, and at that moment, we do not even have the output
>    size yet.
>=20
> might be a very reasonable rationale for omitting "OUT: <size>" in
> the output when "delayed" request is seen, but that still does not
> explain why it is sensible to drop "OUT: <size>" for error or abort
> case.

Well, "rot13-filter.pl" *does* have the output available right away
even in the delayed case (because of the mock implementation).=20
If we print "OUT: <size>" all the time then this would lead to
misleading log messages in this situation.

It's not necessary to drop "OUT: <size>" for abort and error. It
was just the way that required the least number of lines of code.


> Having said all that, I tend to agree with the actual change.  When
> we abort or error, we aren't producing any useful output, so it may
> be sensible _not_ to say "OUT: 0" in the log output from the test
> helper in these cases.  And if the change is explained that way,
> readers would understand why this step is a good thing to have, with
> or without the future "delayed" step in the series.

How about this?

    "rot13-filter.pl" always writes "OUT <size>" to the debug log at the =
end
    of a response.

    This works without issues for the existing responses "abort", =
"error",=20
    and "success". A new response "delayed", that will be introduced in=20=

    subsequent patches, accepts the input without giving the filtered =
result
    right away. Since we actually have the data already available in our =
mock
    filter the debug log output would be wrong/misleading. Therefore, we
    do not write "OUT <size>" for "delayed" responses.

    To simplify the code we do not write "OUT <size>" for "abort" and=20
    "error" responses, too, as their size is always zero.

- Lars=
