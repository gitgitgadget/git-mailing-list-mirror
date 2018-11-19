Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9A11F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeKTC5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 21:57:34 -0500
Received: from mout.web.de ([212.227.15.4]:41167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeKTC5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:33 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ6KJ-1gK7mh164B-005KE1; Mon, 19
 Nov 2018 17:33:24 +0100
Date:   Mon, 19 Nov 2018 17:33:23 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
Message-ID: <20181119163323.GA15913@tor.lan>
References: <20181117151139.22994-1-tboegi@web.de>
 <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:eQrMOwcAfpJ4deYBnXJ3t8FaFslB4bocXSl2kU+oXQ9QRNjygiV
 iJBmSYdP1mVGPtuZ7sBNGlOuKqZAU/R1JWao9eHlKOAR4ae0w/9licvPwo5JjQTVmxG6zHI
 MK5/FnFMBqO5pq3xvfq8ML8RizuByYVqvp5qCnNwbYBeOC1A4+Ul7xFHTKwXUa4b67GVAWp
 O0MfZ5RyzP9GdHlx4HWIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vxsmg7K7a3s=:WUFyGf4oUJ7ShImo6DFRPy
 +j2kKl9nEtzXVyjKWIa8FJDjgSjJKAu0NySf2GC4X9SnTfFSyQn6VNHvINrFEJXc7SX/3D1jY
 FKsTC1f2gwQ8buBm2bpjlym/OpSH4wwiW7ZSezeOGjicGrOYifzU8B0yyYS4xKKxzlyWzKcHY
 XqCWfDivI/4wwycytGnQWF32i4Zk009CGZrkcKpei71I4q/M50tK9BrS/UQFIvl1TGADc885Q
 I1uXQzvzRnbtUSLwFGze/K63FM6OhLIvu3Q94JPYH0plWB+CpCSHoh0Nz+Na3pLGdCZ3gUe5E
 QrHusqjukHRcaHy5d6Fcu/EZrdqxpFA6osisriDZ4bsaIFe9h61sRRwn7QIR1NXUZ3I6fE+RW
 JsiXjhBgWlIXqCTrqG+fkiwwq8OuHYt1G4a2CUNZHWUkKQDOIvuwPK5j94q9Jhnb2MIl2gTcU
 gk9O24sFZwHZLMUcqjqcNM0TbXAUJyneXGUjlsJPIlwqcacTDOwyRLm/qRI0nWNhxuqpUIVq4
 07kTGs/lo1qczQ+fobzUqDBp5sZ1HheKKycG0kYYrh1ApWtM6CEMBVD9gb0fG3hX3I8ejAMPk
 IOTAMMW3PxpHs+xNNDt4Daa46X6NmUoUpKyUzE2rnFYa9d4sCxXruiL893J3OVeSUyg69JJXS
 r9iXIYHhMdjm/aTaEfZZDjKil/VyGGRBq5olJ6JWHxisgi7UvkOlFv91lqpzzuR4x18rjcu6o
 c/UHPQrqGan04uwGBr5zPpMWv52nb8gh4nWviyfH9PQv0idvKbPVUIRYAXngNwdShn4ON3oRw
 XcshJV9q44R8Iho5OhUyHv4Ax5jQ57Y8S1dkpATKy7lQAYAC2th0N5YRFXk+gOrDienSFh7c8
 4wI4nplBeDTINv+Q1oJzcrK+UlotecXK0rFUVxA0c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 03:18:52PM -0500, Derrick Stolee wrote:
> On 11/17/2018 10:11 AM, tboegi@web.de wrote:
> >From: Torsten Bögershausen <tboegi@web.de>
> >
> >Currently Git users can not commit files >4Gib under 64 bit Windows,
> >where "long" is 32 bit but size_t is 64 bit.
> >Improve the code base in small steps, as small as possible.
> >What started with a small patch to replace "unsigned long" with size_t
> >in one file (convert.c) ended up with a change in many files.
> >
> >Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> >---
> >
> >This needs to go on top of pu, to cover all the good stuff
> >   cooking here.
> 
> Better to work on top of 'master', as the work in 'pu' will be rewritten
> several times, probably.
> 
> >I have started this series on November 1st, since that 2 or 3 rebases
> >   had been done to catch up, and now it is on pu from November 15.
> >
> >I couldn't find a reason why changing "unsigned ling"
> >   into "size_t" may break anything, any thoughts, please ?
> 
> IIRC, the blocker for why we haven't done this already is that "size_t",
> "timestamp_t" and "off_t" are all 64-bit types that give more implied
> meaning, so we should swap types specifically to these as we want. One
> example series does a specific, small change [1].
> 
> If we wanted to do a single swap that removes 'unsigned long' with an
> unambiguously 64-bit type, I would recommend "uint64_t". Later replacements
> to size_t, off_t, and timestamp_t could happen on a case-by-case basis for
> type clarity.
> 
> It may benefit reviewers to split this change into multiple patches,
> starting at the lowest levels of the call stack (so higher 'unsigned long's
> can up-cast to the 64-bit types when calling a function) and focusing the
> changes to one or two files at a time (X.c and X.h, preferrably).
> 
> Since you are talking about the benefits for Git for Windows to accept 4GB
> files, I wonder if we can add a test that verifies such a file will work. If
> you have such a test, then I could help verify that the test fails before
> the change and succeeds afterward.
> 
> Finally, it may be good to add a coccinelle script that replaces 'unsigned
> long' with 'uint64_t' so we can easily fix any new introductions that happen
> in the future.

The plan was never to change "unsigned long" to a 64 bit value in general.
The usage of "unsigned long" (instead of size_t) was (and is) still good
for 32bit systems, where both are 32 bit. (at least all system I am aware of).

For 64 bit systems like Linux or Mac OS it is the same, both are 64 bit.

The only problematic system is Win64, where "unsigned long" is 32 bit,
and therefore we must use size_t to address data in memory.
This is not to be confused with off_t, which is used for "data on disk"
(and nothing else) or timestamp_t which is used for timestamps (and nothing else).

I haven't followed the "coccinelle script" development at all, if someone
makes a patch do replace "unsigned long" with size_t, that could replace
my whole patch. (Some of them may be downgraded to "unsigned int" ?)

However, as we need to let  tb/print-size-t-with-uintmax-format make it to
master, otherwise we are not able to print the variables in a portable way. 


> Thanks! I do think we should make this change, but we must be careful. It
> may be disruptive to topics in flight.
> 
> -Stolee
> 
> [1] https://public-inbox.org/git/20181112084031.11769-1-carenas@gmail.com/
> 
