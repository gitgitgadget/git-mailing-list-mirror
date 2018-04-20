Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633561F404
	for <e@80x24.org>; Fri, 20 Apr 2018 20:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeDTUia (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 16:38:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:40781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbeDTUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 16:38:29 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLB89-1f9tmR1zCj-000KPx; Fri, 20
 Apr 2018 22:38:22 +0200
Date:   Fri, 20 Apr 2018 22:38:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit
 messages
In-Reply-To: <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1804202232360.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de> <CAGZ79kZONQ_xuDYJ5Z8cUnF0odwz3+Sh+ST6g+5Tefav-QXEBw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804202149260.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RGcc2q8vJYAiQjfupKHOOTrYU+ybX5VlMl7n0y/GvhegJAW23Jc
 Wa7CgHVmiaCRbb/uOhPz6tNIdst2T81+TEjf7LZOKkQbdoL//cAzhfk27T0eRxKRkuSKwax
 Ichg6u43OyLWRbu3QEfr03f4jJ4R7sdIN30VmCZmeEbTFH/56H1UZXjkiVu57nVABPuA2Mb
 BIEaEh7PMBzZOFt3kCLTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zu4Op/4gN8U=:5JUffDeq4NTRI1meuCfwPI
 Pkc6M8pi2BLLFY8fmPwo2gnoPPejcepphpUH+dyP32DDby9hVRrcLImv4um6z1qjzXj330KxR
 QpP62aj3DHw4jArn5jzzhptu6+u2HjyjQW4GY6alJalUUMCBC4wy37cDRXBnuZMOLRRsgx0RY
 /VyzjA1mZdnJ0YCgwcZ60YVjjM+hqRc7knq1cA5B6upy+FkluQtT8MhPYxbsg6lhxNDTf2RdG
 qiiHxvyPTJLpvdzLNkZbBHoC7NYgSb8jE5wCJAO+x9OQuVVsZ/GFcHnuGsG2+9LQNn8VlyqoD
 fF765ZVJBZLnbsuG8Hu9nUUFau19U+opQebNJdKr1Ba3P/Qsb0fVtQuj5LcEpsTcCH6qy7TqM
 KLW5r/nRJbLd+IK1D3QOXsylCBpnDDpX2Ko4dvY4BBaRjjbxAAUSm3bwCExynbtD2lto0/05c
 CjkTPNcIgNIRdpvq5dHUakhVh2nZOVtGCnu1TL5YsPOUFsh4EzDqvviuByzdDw1pBIDiGW7YT
 /prFkNHcvtEdtZFbUZpP4g2bglZYGnZNRaIv28aDHS6DpHT0iT6xGlTMDoIEqduKxG1qIcPE0
 ny+9jWcWth9EzCQA/DUvl3K5MFZzn++Vz5KZNwhA4frQbbctpMSz5JhnRk5S/QVB/SS13eapj
 Y5UUsS9SdgYiKYYccMexbDwAW2rySqYtTYg44Pn13QFTnPpW9Au96aOvIJrtRmPjt5LqiloI0
 RnUSHc2+4V72pi97ZjgVOu+0YsZ5jdyL4Ji6WZ4NoPIxbW9WE8cyCLQMfzjcivlV3W5iLk8Z1
 6L8WSqNOpIKzTZ5IVll3bmnsC+vXKmHd79v83QVvMKg9JstHlM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Johannes Schindelin wrote:

> A brief test shows, however, that it is not quite as easy as
> s/grep/test_i18ngrep/, something more seems to be broken.

It seems that this week is my Rabbit Hole Week.

Turns out that we have a really, really long-standing bug in our rebase -i
where we construct the commit messages for fixup/squash chains.

Background: when having multiple fixup!/squash! commits for the same
original commit, the intermediate commits have messages starting with the
message

	# This is a combination of <N> commits.

and then every fixup/squash command increments that <N> and adds a header

	# This is the commit message #<N>:

before writing the respective commit message.

The problem arises from the fact that we deduce <N> from parsing the first
number in ASCII encoding on the first line.

That breaks e.g. when compiling with GETTEXT_POISON, and it is probably
not true in general, either.

So I introduced a patch that handles the absence of an ASCII-encoded
number gracefully, and now the test passes with and without
GETTEXT_POISON.

Thanks for the review that let me find and fix this bug!
Dscho
