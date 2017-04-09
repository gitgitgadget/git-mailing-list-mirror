Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0691FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 18:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbdDISlH (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 14:41:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34288 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdDISlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 14:41:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id x75so6237313wma.1
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 11:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aW78fS/h/xr8Yb9dLnSGP/fdxdEohY4gxl+p/L43Qd4=;
        b=n7flO7LGS7k1mxRKdo+eZ9n2rjAy5i4QUh7ER3opCGQsmBBshPYbuHBku0S5q0AMQq
         xPegj8pymDZ6ewseqGJ2WV7OgPJm1jw3AGeW8enstzpICrEejJDrCFyL29o2FjBbYIze
         N2CjZNEoDJM8kbzXbu3o/J2n8IJ70O2PgIFkymN/kyz5CaSeTvCim4n9cFmZLL+qSWdE
         NjbWISyptGhr4rzvQTZaHkJtKbhyCHA4g9w2oeJpEPrSVk8pdGQUQMoSCFUEhCzC3LYx
         m6wlkyh8KC23q/uNbIaMSFI2dMzq7L+LRbRERSrSjV0XqIemRPNozyiZbSTmQxx+zaKj
         4wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aW78fS/h/xr8Yb9dLnSGP/fdxdEohY4gxl+p/L43Qd4=;
        b=rwmPcGGxiXJt2iJMEWs+qQgc5smsq8CfmGzWLmlhMNNnkCNj+LCWfffVxt78CU2cMF
         zy9AQY0mhGiiKuL0cWW83cki/LImqoutF9P1tS+satmC0t7sOGeN1YjoFJc0fzvNTyt4
         qBnxGIzF1RK2fPVz07m82STzsHiEPo7yoLbMbgMW9Js1pUlYkWgDSEvTcI+gH2QCye1r
         beUh14bl3O7Mk2IVFTd0/k7AZ8/2gLgrQ9vqH2XcSgYbudRYyRT4pYrV907knlpc4yCf
         xktIc1jYvwCwGFfO2GMHjtwgZ6mSrYXN1c848MHjxQerAsQQGN21YlJr6AaScx4F8El2
         pGpw==
X-Gm-Message-State: AN3rC/6T59p7YxggxKeS2QZQ3Bxi1EKCrH12KU8PPjtK52BfmQvfNG9mFLlUK+2dpBvPqw==
X-Received: by 10.28.6.213 with SMTP id 204mr7171522wmg.68.1491763264312;
        Sun, 09 Apr 2017 11:41:04 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id t66sm6792243wmd.26.2017.04.09.11.41.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 11:41:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <7fbf63df-c61f-3d4b-99a8-eea52049709d@gmail.com>
Date:   Sun, 9 Apr 2017 20:41:02 +0200
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6410F3B1-3A85-4B2C-9425-17912F57622B@gmail.com>
References: <20170226184816.30010-1-larsxschneider@gmail.com> <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net> <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com> <7fbf63df-c61f-3d4b-99a8-eea52049709d@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Feb 2017, at 23:11, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> W dniu 27.02.2017 o 11:32, Lars Schneider pisze:
>>=20
>>> On 27 Feb 2017, at 10:58, Jeff King <peff@peff.net> wrote:
>>>=20
>>> On Sun, Feb 26, 2017 at 07:48:16PM +0100, Lars Schneider wrote:
>>>=20
>>>> +If the request cannot be fulfilled within a reasonable amount of =
time
>>>> +then the filter can respond with a "delayed" status and a flush =
packet.
>>>> +Git will perform the same request at a later point in time, again. =
The
>>>> +filter can delay a response multiple times for a single request.
>>>> +------------------------
>>>> +packet:          git< status=3Ddelayed
>>>> +packet:          git< 0000
>>>> +------------------------
>=20
> Is it something that happens instead of filter process sending the =
contents

Correct! I'll clarify this in v3!


>>=20
>> I completely agree - I need to change that. However, the goal of the =
v2
>> iteration was to get the "convert" interface in an acceptable state.
>> That's what I intended to say in the patch comment section:
>>=20
>>    "Please ignore all changes behind async_convert_to_working_tree() =
and=20
>>     async_filter_finish() for now as I plan to change the =
implementation=20
>>     as soon as the interface is in an acceptable state."
>=20
> I think that it is more important to start with a good abstraction,
> and the proposal for protocol, rather than getting bogged down in
> implementation details that may change as the idea for protocol
> extension changes.

I'll send out v3 shortly as proposal for a complete solution.


>>> I think it would be much more efficient to do something like:
>>>=20
>>> [Git issues a request and gives it an opaque index id]
>>> git> command=3Dsmudge
>>> git> pathname=3Dfoo
>>> git> index=3D0
>>> git> 0000
>>> git> CONTENT
>>> git> 0000
>>>=20
>>> [The data isn't ready yet, so the filter tells us so...]
>>> git< status=3Ddelayed
>>> git< 0000
>=20
> So is it only as replacement for "status=3Dsuccess" + contents or
> "status=3Dabort", that is upfront before sending any part of the file?

Yes.


> Or, as one can assume from the point of the paragraph with the
> "status=3Ddelayed", it is about replacing null list for success or
> "status=3Derror" after sending some part (maybe empty) of a file,
> that is:

No. As this would complicate things I don't want to support it.=20
(and I clarified that in the docs in v3).


> If it would not be undue burden on the filter driver process, we might
> require for it to say where to continue at (in bytes), e.g.
>=20
>    git< from=3D16426
>=20
> That should, of course, go below index/pathname line.

This would make the protocol even more complicated. That's why I don't
want to support splitting the response.


>>> git< index=3D0
>=20
> Or a filter driver could have used pathname as an index, that is
>=20
>    git< pathname=3Dpath/testfile.dat

In v3 I've used an index to help Git finding the right cache entry
quickly.


>=20
>>> git< 0000
>>> git< CONTENT
>>> git< 0000
>>>=20
>>> =46rom Git's side, the loop is something like:
>>>=20
>>> while (delayed_items > 0) {
>>> 	/* issue a wait, and get back the status/index pair */
>>> 	status =3D send_wait(&index);
>>> 	delayed_items--;
>=20
> This looks like my 'event loop' proposal[1][2], see below.

I implemented something similar in v3.


>> That could work! I had something like that in mind:
>>=20
>> I teach Git a new command "list_completed" or similar. The filter
>> blocks this call until at least one item is ready for Git.=20
>> Then the filter responds with a list of paths that identify the
>> "ready items". Then Git asks for these ready items just with the
>> path and not with any content. Could that work? Wouldn't the path
>> be "unique" to identify a blob per filter run?
>=20
> Why in the "drain" phase it is still Git that needs to ask filter for
> contents, one file after another?  Wouldn't it be easier and simpler
> for filter to finish sending contents, and send signal that it has
> finished continue'ing?
>=20
> To summarize my earlier emails, current proposal looks for me as if
> it were a "busy loop" solution, that is[2]:

In v3 the implementation still uses kind of a busy loop (I expect the
filter to block if there nothing ready, yet). An event loop would
complicate the protocol as the filter would need to initiate an action.
Right now only Git initiates actions.


> Footnotes:
> ----------
> a) We don't send the Git-side contents of blob again, isn't it?
>   So we need some protocol extension / new understanding anyway.
>   for example that we don't send contents if we request path again.
Correct - v3 doesn't send the content again.


> Also, one thing that we need to be solved, assuming that the proposed
> extension allows to send partial data from filter to be delayed and
> continued later, is that Git needs to keep this partial response in =
buf;
> this is because of precedence of gitattributes applying:

As mentioned above I don't want to support partial data as this
complicates things and is of no use for my Git LFS problem case.

Thanks,
Lars

