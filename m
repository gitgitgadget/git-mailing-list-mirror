Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988EC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345AB20770
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgIOWep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:34:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgIOQLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 12:11:07 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MekrN-1kse312bzx-00anjb; Tue, 15 Sep 2020 18:03:58 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id C45561E01E7;
        Tue, 15 Sep 2020 16:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b4VslPQVtu2X; Tue, 15 Sep 2020 18:03:57 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 85CFB1E01E6;
        Tue, 15 Sep 2020 18:03:57 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 5C5FC8051F; Tue, 15 Sep 2020 18:03:57 +0200 (CEST)
Date:   Tue, 15 Sep 2020 18:03:57 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200915160357.GC18984@pflmari>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915152730.GA2853972@coredump.intra.peff.net>
X-Provags-ID: V03:K1:emfyIpBAxI7aJ/ZZ/VgWpt6hWj+ZAGvuisyjWzCoJZvMOxTNLJk
 Xxq1M5RjMysbb99UTlz3QbfGrzbOfyQPqIxkhbIhtl+2ItbtkmjcvGr1ZrpNKQUAyIPv960
 VpoeS0OwWULSGMzCC+9lSlg/SEo6vMM55SxCZehGtV3t9YIXhhhzHYrjTNKEYiAY5VEpEIO
 If/1vnq15eQp37Qd80rHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jme4LElHrOQ=:J9gY18MxniwyHsyyQlsUIq
 9AetBayitbZrtGVnPLMUCoqknXIotJYe82biYjUOwye2kNXlmXRaC53wYu/eMEgsB4HW61Tra
 6yIJ/I6YyuCis//QaFMGLgqr9ydLY4K1gZrl3f8sarA7VgwSyoESame7j/96SpbsYw0hh8xjY
 7HovvJV5oX4vbbLceCp7jHPUP8B2TM3G/DbJOlg8THlKEEE869c6aVRjRhWtQED6yuntETO8m
 evo/pS/1bHr0vai87eFWGM4N1H64a1zqizgrAvZThGPrW8AxLu1oM9xRnYRS1LAO6qEPHVVIk
 eNJSBjtLJe2GJFSb39tJZ07QL+uMjlpQz7U0AyHiSj4yh2M6RYexwsxgBNePPvdmMDiZfF0Wm
 1+6CKpWr5khZuLTsqji5lFwYduDRBV/BbfF0AXOkzazArA91zZBTfkhHoQXTAsLIu3Hd4dyBe
 dk2ynSY0WBU3slEg9Ewr7OI469Ej8Dw2OJGXe4i6AyEix59bECS43o7VB04FcvPK6Dn8wN3qv
 XatBm7Mv4shhKpxu5TuY9TRzzFfQ+Z+nmIDYBJlsfv2ieolT3Mzwdr9bX+tFPLAsEfKYk/+Go
 Y06y7bfMi+4+oDUuAjwMjafr5GRL+2jHDFFUQ0VvsHPvNV6NSbJcbufrqxnjxzp6IywPSjgPc
 h2Hq6qxIlilprckrScGWJwSDhXKDl0tK45QkxnCPcG3zLxZXuITM8zJRqwC0yUANmvFo7mVzI
 XSLXM4weh3YKwGuDLE9si58C9gUJl2QOKkataAYhBNiUOQ6OhES1qpaDQ5oj5YY/UXX+X3spC
 3Mn3l112iqNGJE8vQgvOJauf86z7CVIFFP34U7IV6akCcK6DXrs5iDqY2AB58LimiLi+NpqjZ
 JYXqNnPFHR6eJVYMi5Cw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Tue, Sep 15, 2020 17:27:30 +0200:
> On Tue, Sep 15, 2020 at 04:06:13PM +0200, Alex Riesen wrote:
> 
> > > Yeah, that would solve the duplication problem. We could probably add a
> > > "recursive" bit to the parse-options flag variable. Even if
> > > parse-options itself doesn't use it, it could be a convenience for
> > > callers like this one. It is a little inconvenient to set flags there,
> > > just because it usually means ditching our wrapper macros in favor of a
> > > raw struct declaration.
> > 
> > Or extend the list of wrappers with _REC(URSIVE) macros
> 
> If you go that route, we have some "_F" macros that take flags. Probably
> would make sense to add it more consistently, which lets you convert:
> 
>   OPT_BOOL('f', "foo", &foo, "the foo option");
> 
> into:
> 
>   OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);
> 
> but could also be used for other flags.

This part (marking of the options) was easy. What's left is finding out if an
option was actually specified in the command-line. The ...options[] arrays are
not update by parse_options() with what was given, are they?

Maybe extend struct option with a field to store given command-line argument
(as it was specified) and parse_options() will update the field if
PARSE_OPT_RECURSIVE is present in .flags?
Is it allowed for parse_options() to modify the options array?
Or is it possible to use something in parse-options.h API to note the
arguments somewhere while they are parse? I mean, there are
parse_options_start/step/end, can cmd_fetch argument parsing use those
so that the options marked recursive can be saved for sub-fetches?

