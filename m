Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02FB1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbcJKW0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:26:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36820 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbcJKW0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:26:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id r16so1382957pfg.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IN57G2hieYXJmFgEMwrTVl5LEbYH9TvUfWrL1eDBt2o=;
        b=hEEOgyX4VBzIR9y/pDBh3bvy6kLIjNBQJG4YijYtTn61rCyRuuIAUxXDuhCqWtSfpD
         7k5YZEoJrHvld4ChfiN5CwBfTAGGFvc3Yx+pT4+Mful/6J1SXQvfseL5/qvGUTIG9b7J
         BFX1pWMVRSPYB5uIwWimVQJPWjLiesQs8jxUV8Wu/wM05ak7rK5DZ20a/bNyRV5spMfu
         YZWHm2ZjLkc/J2YC1KFziq+VyeWKoxDFHyc7qOWwRcrPhI1EJh+hAlCTsdFJhrUimlfk
         wYCryoRzu34VUukVTAU1m7d/c10C3mZbC/B7n4ZTPo6h1yalQ8s8mhAt0Q1PyINAglV4
         gcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IN57G2hieYXJmFgEMwrTVl5LEbYH9TvUfWrL1eDBt2o=;
        b=cXwYtBA6efLPwsLZ+YmGfIB7l57Z3fxTKvNmtjnH0oc8jxGJG6dxp1qoY0U41RuPrU
         KnCtvZN7Q66osITBGgf/upByLCiRNhmG3Yqu0a2yKv/ItyQymggdZIqL3b0zMjdg5uvw
         T0kbXjxgkSjEsuPP9qEIVjhKYN7cuHY3IxFj8hJxqoMPscafYn5Rd5LcObgr1zvgIuUN
         Q/P1Z5e5qOr/TUmN5bJRGRcKhHYE8GM7A8uUSACdjW3VQNtFi556ZDbk7G7EFKYypyGZ
         Cv3Q/aKbsX+IaEa358bRZ6RCFLa9f/QojF1uqKvBQL6HRGSjdz0+Qx43D6sTyhCY0vh8
         PapA==
X-Gm-Message-State: AA6/9RnBj1Ev8JtSQViIYhSUOgNhx+pZgjE2KYcXJANlxKa/3PuK46kS8mqKLI1U8VVMIw==
X-Received: by 10.99.110.201 with SMTP id j192mr4542832pgc.133.1476224767319;
        Tue, 11 Oct 2016 15:26:07 -0700 (PDT)
Received: from [10.80.3.199] ([209.37.102.131])
        by smtp.gmail.com with ESMTPSA id e6sm6669561pfb.57.2016.10.11.15.26.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Oct 2016 15:26:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
Date:   Wed, 12 Oct 2016 00:26:02 +0200
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03278DA5-34B8-42F1-B52E-A42A3BCD5FB8@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-14-larsxschneider@gmail.com> <e09a63ee-dad2-a8fb-e47f-0559d9507e1c@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Oct 2016, at 01:06, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
> Part 1 of review, starting with the protocol v2 itself.
>=20
> W dniu 08.10.2016 o 13:25, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> +upon checkin. By default these commands process only a single
>> +blob and terminate.  If a long running `process` filter is used
>> +in place of `clean` and/or `smudge` filters, then Git can process
>> +all blobs with a single filter command invocation for the entire
>> +life of a single Git command, for example `git add --all`.  See
>> +section below for the description of the protocol used to
>> +communicate with a `process` filter.
>=20
> I don't remember how this part looked like in previous versions
> of this patch series, but "... is used in place of `clean` ..."
> does not tell explicitly about the precedence of those=20
> configuration variables.  I think it should be stated explicitly
> that `process` takes precedence over any `clean` and/or `smudge`
> settings for the same `filter.<driver>` (regardless of whether
> the long running `process` filter support "clean" and/or "smudge"
> operations or not).

This is stated explicitly later on. I moved it up here:

"If a long running `process` filter is used
in place of `clean` and/or `smudge` filters, then Git can process
all blobs with a single filter command invocation for the entire
life of a single Git command, for example `git add --all`. If a=20
long running `process` filter is configured then it always takes=20
precedence over a configured single blob filter. "

OK?


>> +If the filter command (a string value) is defined via
>> +`filter.<driver>.process` then Git can process all blobs with a
>> +single filter invocation for the entire life of a single Git
>> +command. This is achieved by using a packet format (pkt-line,
>> +see technical/protocol-common.txt) based protocol over standard
>> +input and standard output as follows. All packets, except for the
>> +"*CONTENT" packets and the "0000" flush packet, are considered
>> +text and therefore are terminated by a LF.
>=20
> Maybe s/standard input and output/\& of filter process,/ (that is,
> add "... of filter process," to the third sentence in the above
> paragraph).

You mean "This is achieved by using a packet format (pkt-line,
see technical/protocol-common.txt) based protocol over standard
input and standard output of filter process as follows." ?

I think I like the original version better.


>> After the filter started
> Git sends a welcome message ("git-filter-client"), a list of
>> supported protocol version numbers, and a flush packet. Git expects
>> +to read a welcome response message ("git-filter-server") and exactly
>> +one protocol version number from the previously sent list. All =
further
>> +communication will be based on the selected version. The remaining
>> +protocol description below documents "version=3D2". Please note that
>> +"version=3D42" in the example below does not exist and is only there
>> +to illustrate how the protocol would look like with more than one
>> +version.
>> +
>> +After the version negotiation Git sends a list of all capabilities =
that
>> +it supports and a flush packet. Git expects to read a list of =
desired
>> +capabilities, which must be a subset of the supported capabilities =
list,
>> +and a flush packet as response:
>> +------------------------
>> +packet:          git> git-filter-client
>> +packet:          git> version=3D2
>> +packet:          git> version=3D42
>> +packet:          git> 0000
>> +packet:          git< git-filter-server
>> +packet:          git< version=3D2
>> +packet:          git> clean=3Dtrue
>> +packet:          git> smudge=3Dtrue
>> +packet:          git> not-yet-invented=3Dtrue
>> +packet:          git> 0000
>> +packet:          git< clean=3Dtrue
>> +packet:          git< smudge=3Dtrue
>> +packet:          git< 0000
>=20
> WARNING: This example is different from description!!!

Can you try to explain the difference more clearly? I read it multiple
times and I think this is sound.


> In example you have Git sending "git-filter-client" and list of =
supported
> protocol versions, terminated with flush packet,

Correct.


> then filter driver
> process sends "git-filter-server", exactly one version, *AND* list of
> supported capabilities in "<capability>=3Dtrue" format, terminated =
with
> flush packet.

Correct. That's what I read in the text and in the example.

>=20
> In description above the example you have 4-part handshake, not =
3-part;
> the filter is described to send list of supported capabilities last
> (a subset of what Git command supports).

Part 1: Git sends a welcome message...
Part 2: Git expects to read a welcome response message...
Part 3: After the version negotiation Git sends a list of all =
capabilities...
Part 4: Git expects to read a list of desired capabilities...

I think example and text match, no?


> Moreover in the example in
> previous version at least as far as v8 of this series, the response
> from filter driver was fixed length list of two lines: magic string
> "git-filter-server" and exactly one line with protocol version; this
> part was *not* terminated with a flush packet (complicating code of
> filter driver program a bit, I think).
>=20
> I think this version of protocol is *better*, just the text needs to
> be updated to match.  I wanted to propose something like this in =
v9,...

I didn't change that behavior since v8:
packet:          git< git-filter-server
packet:          git< version=3D2


> By the way, now I look at it, the argument for using the
> "<capability>=3Dtrue" format instead of "capability=3D<capability>"
> (or "supported-command=3D<capability>") is weak.  The argument for
> using "<variable>=3D<value>" to make it easier to implement parsing
> is sound, but the argument for "<capability>=3Dtrue" is weak.
>=20
> The argument was that with "<capability>=3Dtrue" one can simply
> parse metadata into hash / dictionary / hashmap, and choose
> response based on that.  Hash / hashmap / associative array
> needs different keys, so the reasoning went for "<capability>=3Dtrue"
> over "capability=3D<capability>"... but the filter process still
> needs to handle lines with repeating keys, namely "version=3D<N>"
> lines!
>=20
> So the argument doesn't hold water IMVHO, and we can choose
> version which reads better / is more natural.

I have to agree that "capability=3D<capability>" might read a
little bit nicer. However, Peff suggested "<capability>=3Dtrue"=20
as his preference and this is absolutely OK with me.

I am happy to change that if a second reviewer shares your
opinion.


>> +Afterwards Git sends a list of "key=3Dvalue" pairs terminated with
>> +a flush packet. The list will contain at least the filter command
>> +(based on the supported capabilities) and the pathname of the file
>> +to filter relative to the repository root. Right after these packets
>=20
> I think you meant here "right after the flush packet", isn't it?
> It would be more explicit.

I feel "right after these packets" reads better, but I agree that your
version is more explicit. I will change it.


>>                                                     Finally, a
>> +second list of "key=3Dvalue" pairs terminated with a flush packet
>> +is expected. The filter can change the status in the second list.
>=20
> I would add here, to be more explicit:
>=20
> This second list of "key=3Dvalue" pairs may be empty, and usually
> would be if there is nothing wrong with response or filter; the
> terminating flush packet must be here regardless.
>=20
> Or something like that.  The above proposal could be certainly
> improved.

How about this:

"Finally, a
second list of "key=3Dvalue" pairs terminated with a flush packet
is expected. The filter can change the status in the second list
or keep the status as is with an empty list. Please note that the
empty list must be terminated with a flush packet regardless."

TBH I like the original version and I wonder if the new version
is redundant?!


>> +------------------------
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< SMUDGED_CONTENT
>> +packet:          git< 0000
>> +packet:          git< 0000  # empty list, keep "status=3Dsuccess" =
unchanged!
>=20
> All right, looks good.  Is this exclamation mark "!" necessary / =
wanted?

Yes, to draw the attention towards the two flushes.


>> +------------------------
>> +
>> +If the result content is empty then the filter is expected to =
respond
>> +with a "success" status and an empty list.
>=20
> Actually, it is empty content, not empty list; that is response =
(filter
> output) composed entirely of flush packet.

Correct!

"If the result content is empty then the filter is expected to respond
with a "success" status and a flush packet to signal the empty content."

Better?

>=20
>> +------------------------
>> +packet:          git< status=3Derror
>> +packet:          git< 0000
>> +------------------------
>> +
>> +If the filter experiences an error during processing, then it can
>> +send the status "error" after the content was (partially or
>> +completely) sent. Depending on the `filter.<driver>.required` flag
>> +Git will interpret that as error but it will not stop or restart the
>> +filter process.
>=20
> Errr... this is literal repetition.  You need to decide whether to
> put it before example, or after example.  Or maybe split it.

Agreed. I removed the repetition and changed the previous paragraph
to:

"In case the filter cannot or does not want to process the content,
it is expected to respond with an "error" status. Git will handle=20
the "error" status according to the `filter.<driver>.required` flag
but it will not stop or restart the filter process."


>> +------------------------
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>> +packet:          git< 0000
>> +packet:          git< status=3Derror
>> +packet:          git< 0000
>> +------------------------
>> +
>> +If the filter dies during the communication or does not adhere to
>> +the protocol then Git will stop the filter process and restart it
>> +with the next file that needs to be processed. Depending on the
>> +`filter.<driver>.required` flag Git will interpret that as error.
>=20
> Uhh... until now the order was explanation, then example.  =46rom the
> duplicated description above, it is now first example, then
> description.  Consistency would be good.

OK, I moved that down after the EOF exit explanation.


>> +The error handling for all cases above mimic the behavior of
>> +the `filter.<driver>.clean` / `filter.<driver>.smudge` error
>> +handling.
>=20
> You have "error handling" repeated here.

True. That might not be nice from a stylistic point of view but it is
precise, no?


>> +------------------------
>> +packet:          git< status=3Dabort
>> +packet:          git< 0000
>> +------------------------
>> +
>> +After the filter has processed a blob it is expected to wait for
>> +the next "key=3Dvalue" list containing a command. Git will close
>> +the command pipe on exit. The filter is expected to detect EOF
>> +and exit gracefully on its own.
>=20
> Any "kill filter" solutions should probably be put here.

Agreed.


> I guess
> that filter exiting means EOF on its standard output when read
> by Git command, isn't it?

Yes, but at this point Git is not listing anymore.


>> +If you develop your own long running filter
>> +process then the `GIT_TRACE_PACKET` environment variables can be
>> +very helpful for debugging (see linkgit:git[1]).
>=20
> s/environment variables/environment variable/  - there is only
> one GIT_TRACE_PACKET.  Unless you wanted to write about GIT_TRACE?

Agreed.


Thanks for the review,
Lars=
