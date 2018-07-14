Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2251F915
	for <e@80x24.org>; Sat, 14 Jul 2018 23:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbeGNX7x (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 19:59:53 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62218 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731483AbeGNX7x (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 19:59:53 -0400
X-AuditID: 12074413-201ff7000000703b-b2-5b4a899b82a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 17.C7.28731.B998A4B5; Sat, 14 Jul 2018 19:39:07 -0400 (EDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w6ENd619010630
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 19:39:07 -0400
Received: by mail-lj1-f177.google.com with SMTP id u7-v6so24476686lji.3
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 16:39:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlEBffJ795pmO9l2NSMAew421wyHYHh4Cahq73UPrbFaUSn3ReOe
        /YcBnQVdBpgqe3MqYa6hsgyETIp8NiaYggcAzT8=
X-Google-Smtp-Source: AAOMgpfWuVRY2AIKGXZ1XBy/rhBSHERRej+/lYjN0xSOuWneImVRgpULnhEgVhU2fSuvJDK5LjkiX9iwCOp2V/C4DOY=
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr6291898ljd.67.1531611545760;
 Sat, 14 Jul 2018 16:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <CA+P7+xq9SeoZjYYWhM14-u4kGgwmNVPs6c+wFR2EbwK+_hVetg@mail.gmail.com> <1438bdfd-cb13-8da4-2dd2-16362b242ff3@gmail.com>
In-Reply-To: <1438bdfd-cb13-8da4-2dd2-16362b242ff3@gmail.com>
Reply-To: mhagger@alum.mit.edu
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sat, 14 Jul 2018 16:38:54 -0700
X-Gmail-Original-Message-ID: <CAMy9T_HuO1a1_R+avedw-dmV4uWjOU9f0Hkrfo=gk8HTXcA7AQ@mail.gmail.com>
Message-ID: <CAMy9T_HuO1a1_R+avedw-dmV4uWjOU9f0Hkrfo=gk8HTXcA7AQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] object_id part 14
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        sandals@crustytoothpaste.net,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.us>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqDu70yvaYPMWQ4uuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGXsPbuVueAyV8WGpZ4NjNs4uhg5OSQETCTOvt/FAmILCexgkpi4
        Iq6LkQvIfsoksfv0ZEYIZyKjxMyjU5kgOsolOrZ+YoGwiyRm9N5gh7ArJPr7WllBbF4BQYmT
        M5+wQDTvYpSY+mI9WAOngK3E/XcvGSHWyUm82nADzGYT0JVY1NMMtoBFQFVi6ryJzBBDEyXW
        rTnHBDE0QOLh5e1gy4QFdCS63nwFWsbBIQJU//gjF8guZoGPjBIn774H62UW0JRo3f6bfQKj
        8CwkN81CklrAyLSKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIySIhXcw7jop
        d4hRgINRiYf3gp1XtBBrYllxZe4hRkkOJiVR3oktQCG+pPyUyozE4oz4otKc1OJDjBIczEoi
        vKvEgXK8KYmVValF+TApaQ4WJXFeZpO9UUIC6YklqdmpqQWpRTBZGQ4OJQne6x1AjYJFqemp
        FWmZOSUIaSYOTpDhPEDDp4HU8BYXJOYWZ6ZD5E8xWnJsetQ9iZlj0spJQPLP+6mTmIVY8vLz
        UqXEeZ+ANAiANGSU5sHNhCWlV4ziQC8K85aDVPEAExrc1FdAC5mAFup1eIIsLElESEk1MPrF
        7xYr0PQQv9d/8a3dgffyq2Wmaj43ubP6jp+fz9V/GpcTv8scP8RvL3n/g+lckWshH66X7+m4
        Vz9F5nn2p0XdC6S+81Ro1SpzLXz1et/CMOlgcyWRO1z3Drpx9nuf/bTR10DOzXGZzJmdRy9q
        SMRuexOnvn7Xc2F1iyaB9Qs8D8Qd3uZ2eJMSS3FGoqEWc1FxIgBJ+2IAJQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 6:15 AM Derrick Stolee <stolee@gmail.com> wrote:
> On 7/8/2018 11:12 PM, Jacob Keller wrote:
> > On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> This is the fourteenth series of patches to switch to using struct
> >> object_id and the_hash_algo.  This series converts several core pieces
> >> to use struct object_id, including the oid* and hex functions.
> >>
> >> All of these patches have been tested with both SHA-1 and a 256-bit
> >> hash.
> >>
> > I read through the series, and didn't spot anything odd, except for
> > the question about reasoning for why we use memcmp directly over using
> > hashcmp. I don't think that's any sort of blocker, it just seemed an
> > odd decision to me.
>
> I also read through the series and only found the 100/200 constants
> confusing. Not worth blocking on, but I'm CC'ing Michael Haggerty to
> comment if he knows how the magic 100 was computed.

The magic 100 blames back to our chief magician, Junio:

    8ac65937d0 Make sure we do not write bogus reflog entries. (2007-01-26)

Since then, as far as I can tell, it's just been copy-pasted forward.
It would be easy to compute it precisely based on the length of the
two OIDs, represented as hex strings, plus the few extra characters in
the format string.

Michael
