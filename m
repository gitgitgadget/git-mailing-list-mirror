Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316A8208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 08:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdHQIHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 04:07:05 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56361 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751305AbdHQIG5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Aug 2017 04:06:57 -0400
X-AuditID: 1207440f-343ff70000000b50-f4-59954ea05ec4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EA.15.02896.0AE45995; Thu, 17 Aug 2017 04:06:56 -0400 (EDT)
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7H86tF9010430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 04:06:56 -0400
Received: by mail-it0-f47.google.com with SMTP id 77so27945427itj.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 01:06:55 -0700 (PDT)
X-Gm-Message-State: AHYfb5jB/kRr1jzCVHFhOajC/kNirOMUnE3DsGxYzMLXHGiRrXnY9ZC4
        k5BBfUGUpjoPlf59dK6urmYTxeH1zA==
X-Received: by 10.36.40.147 with SMTP id h141mr968127ith.85.1502957215205;
 Thu, 17 Aug 2017 01:06:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 17 Aug 2017 01:06:54 -0700 (PDT)
In-Reply-To: <xmqq60dnjka0.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
 <xmqq60dnjka0.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 17 Aug 2017 10:06:54 +0200
X-Gmail-Original-Message-ID: <CAMy9T_GuU68mQTAvmPkaa6jPiNnoDAKCqA8y76rf3UrmMeyfTA@mail.gmail.com>
Message-ID: <CAMy9T_GuU68mQTAvmPkaa6jPiNnoDAKCqA8y76rf3UrmMeyfTA@mail.gmail.com>
Subject: Re: reftable [v7]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1F3gNzXS4OwlM4uuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGU0r80peMpRcfm7UQPjZPYuRk4OCQETiYc3W1m6GLk4hAR2MEl8
        avrEDuE8YpI4sPk+lNPLKLHtwQZmiJZ8iX0PTrNA2EUSX9f3gdm8AoISJ2c+AbOFBOQkXm24
        wQhhe0t0Pf8J1sspYC3RtuIGE8TQRkaJ3fO6wBJsAroSi3qamUBsFgFViZtfNwBt5gBakChx
        fr8PxPwAifnLP4OdLSxgJDHnTzcriC0ioCYxse0Q2AvMAjsZJe5P2AOWYBbQlGjd/pt9AqPw
        LCT3zUKSWsDItIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJIj5dzB2rZc5
        xCjAwajEwxuRNyVSiDWxrLgy9xCjJAeTkijv71lAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
        F72nRgrxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4VXyBGgWLUtNT
        K9Iyc0oQ0kwcnCDDeYCGl4PU8BYXJOYWZ6ZD5E8xGnNcubLuCxPHlAPbvzAJseTl56VKifNG
        gJQKgJRmlObBTYMloleM4kDPCfPOAaniASYxuHmvgFYxAa260j4JZFVJIkJKqoHR6OP68r/X
        kjQ1r02u04w/dOk+3/3D34v+CR7zLbwn7bJ+ep+3cqfLvWkrn2zUCuqbVmy+9YHBNGHu1pet
        EhxWeTUhPPKTuDdplzxdXe3H/C1HrsD+T3qxZcCFltMd/f075XwlXs4skGYREZsVOcHs8mrt
        N2sXq6kb36lsEdFrKYvpVpef/EiJpTgj0VCLuag4EQCaF8XoHwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I found it a slightly odd that we do not insist that update_indices
> that appear in a single reftable file are consecutive, yet we
> require that min_update_index of a reftable file must be one greater
> than the max_update_index of a previous one.  That is not a new
> issue in v7, though.

I think of `update_index` like a pseudo-time, and the
`min_update_index` and `max_update_index` to be stating that "this
reftable covers the time interval specified". So it's reasonable to
say that the reftable files, together, should cover all time.

But it might be that there are values of `update_index` for which no
events survived within a reftable file that covers that time interval.
This can happen if reference update records have been compacted away
because later reference updates overwrote their effects, and either

* reflogs were turned off for those updates, or
* the corresponding reflogs have been compacted into a separate file, or
* the corresponding reflog entries for those updates have been expired.

Michael
