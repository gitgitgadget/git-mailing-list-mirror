Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33A3207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934568AbcI2R5x (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:57:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36252 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933876AbcI2R5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:57:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so11869111wma.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OaUicme5EKuavzzhKeYa+hv9ZrLd7Uf5k4G34vJSpuY=;
        b=SLsXwc5WdVizKGzCsS3OWxG/d1qKrTY/DJ9dQcnaSxYTalI2U0OrodUcSzfHu26d6B
         iFPMfrpJ0eKR2xXVplTuGtmtiNx2ln94nrs9tv05V8sPsEwhbvKLFH6aZVjmYnz35WSI
         LVDQl7hQwqWblrkzQh/4E3AEpZQC/a7WJIpH/HZwPr0CCg+1GK0i/UgyVdFmZG1U0f+F
         nIWd33VEVndLayzfRrAbcd6Pc64iK/ch3MNQDL6Twao+v9+0QOuiyyBSyR5k37vCHsRI
         kg1wtM2eyMJo2NGMq6Ir9EvTtxokgDb4Qo3jmr0N+tkiuEvJJTWKDCRusvNXGK3JLmJR
         pZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OaUicme5EKuavzzhKeYa+hv9ZrLd7Uf5k4G34vJSpuY=;
        b=RchMHpS3CddBvD7lYD8RQZZq3Ghsf7Yr1gPSa3NOg6gLVYAsMTFpwntkKPVKjekWvH
         g6hnVxfyWxdwB7o4QoURze01T74V0U4YHwBkcrpUnErWav9xDNjqQEUCO0H7c+IRZ/oR
         FX8LYcEWqsNsThL9IAkEYiSGmzOmXEAiS2rjLQYmBelgpM9RYye69pEHTe+bGlSYUHG9
         tqPoFDw3O9qJh7EFY+8lHKlweBCyLhz7oG7BiPv+hLPIanr91CZ8bkq4W8G7BHQyXLC/
         3uc2KoNj5MEHTqhF1QRz1LgyoI4ByH7bVBfRID1cPuoETCCgw+s50l/R1ZKoMqErLtOD
         KWUg==
X-Gm-Message-State: AA6/9Rm3eMeBEdnbud5RnsmrGB/tB4IIaf2ah8yZW7QxYLluYggMlZbrECqpkPHW/sXMGQ==
X-Received: by 10.28.138.140 with SMTP id m134mr3861244wmd.92.1475171870683;
        Thu, 29 Sep 2016 10:57:50 -0700 (PDT)
Received: from slxbook4.fritz.box ([93.219.123.1])
        by smtp.gmail.com with ESMTPSA id pj2sm15356328wjb.8.2016.09.29.10.57.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 10:57:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 19:57:43 +0200
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Sep 2016, at 18:57, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>> 1) Git exits
>>> 2) The filter process receives EOF and prints "STOP" to the log
>>> 3) t0021 checks the content of the log
>>>=20
>>> Sometimes 3 happened before 2 which makes the test fail.
>>> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>>>=20
>>> I added a this to wait until the filter process terminates:
>>>=20
>>> +wait_for_filter_termination () {
>>> +	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" =
>/dev/null 2>&1
>>> +	do
>>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>>> +		sleep 1
>>> +	done
>>> +}
>>>=20
>>> Does this look OK to you?
>> Do we need the ps at all ?
>> How about this:
>>=20
>> +wait_for_filter_termination () {
>> +	while ! grep "STOP"  LOGFILENAME >/dev/null
>> +	do
>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>> +		sleep 1
>> +	done
>> +}
>=20
> Running "ps" and grepping for a command is not suitable for script
> to reliably tell things, so it is out of question.  Compared to
> that, your version looks slightly better, but what if the machinery
> that being tested, i.e. the part that drives the filter process, is
> buggy or becomes buggy and causes the filter process that writes
> "STOP" to die before it actually writes that string?
>=20
> I have a feeling that the machinery being tested needs to be fixed
> so that the sequence is always be:
>=20
>    0) Git spawns the filter process, as it needs some contents to
>       be filtered.
>=20
>    1) Git did everything it needed to do and decides that is time
>       to go.
>=20
>    2) Filter process receives EOF and prints "STOP" to the log.
>=20
>    3) Git waits until the filter process finishes.
>=20
>    4) t0021, after Git finishes, checks the log.
>=20
> Repeated sleep combined with grep is probably just sweeping the real
> problem under the rug.  Do we have enough information to do the
> above?
>=20
> An inspiration may be in the way we centrally clean all tempfiles
> and lockfiles before exiting.  We have a central registry of these
> files that need cleaning up and have a single atexit(3) handler to
> clean them up.  Perhaps we need a registry that filter processes
> spawned by the mechanism Lars introduces in this series, and have an
> atexit(3) handler that closes the pipe to them (which signals the
> filters that it is time for them to go) and wait(2) on them, or
> something?  I do not think we want any kill(2) to be involved in
> this clean-up procedure, but I do think we should wait(2) on what we
> spawn, as long as these processes are meant to be shut down when the
> main process of Git exits (this is different from things like
> credential-cache daemon where they are expected to persist and meant
> to serve multiple Git processes).

We discussed that issue in v4 and v6:
=
http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.p=
eff.net/
=
http://public-inbox.org/git/xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com/

My impression was that you don't want Git to wait for the filter =
process.
If Git waits for the filter process - how long should Git wait?

Thanks,
Lars=
