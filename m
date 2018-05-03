Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D290200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeECVF4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:05:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:51053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeECVFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:05:55 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lk81O-1ecWlL1ZGc-00c8Mz; Thu, 03
 May 2018 23:05:49 +0200
Date:   Thu, 3 May 2018 23:05:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 11/18] branch-diff: add tests
In-Reply-To: <CAGZ79kY_kXpiXScjE+cNWRN1r71B3KkGNGZQjCHpKNe+tdMipw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032303540.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <fe12b99a0b4f78ab75fcfbcf51c5edffb190c4e8.1525361419.git.johannes.schindelin@gmx.de> <CAGZ79kY_kXpiXScjE+cNWRN1r71B3KkGNGZQjCHpKNe+tdMipw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:czUyooTA4CO+Bk0zQyuGstDEXL1AhXTwf2lB1/eGuFGSj2FUFVp
 /THNs44c4D4iBbX8OAvnUWoA4ZH/8p7kkP7VySeto7YL/PkDttrll23HRdr9XeRzhBXT8Mm
 yCRHvrJc6q7zOVu6icbc+106UjvFWmy+t7ze/zk2P5dXCYyGp2yUvdTrmVwdOdADDeDGGdV
 bmAo0VQJxugHtY7Z0AExg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uCaceyDsjJA=:MVjhsvpZwoZdtsontQq9bT
 XxUguPT1wX06DMfH6q7iXHLoMxrnItTcK9koBwITLL5LzTEzxiCsMRczsrdwvsR/c414NgE8g
 cliiSg91+r4GnkfbvZxD1c0lFscPv3m73vrj890LPI8Lv3NY56ENmCRqnK9RIEBKTbFANFzMI
 2sPu4aitcHVmnzAelLggEHzb9cn16v1c9337ZWio3XysYv8qhNZ4ZjyOpWg3x1u50wEB4RNqe
 bAmE6cltcpzxn6DV3H2eL9rLO4zKYV2InaWAJigdblQrUzVljbBSJEaqlgTKBoTQLF9kj6eWk
 eCpbHB2ulFRbJcqtaYIUjDJgd6K09zwRcWvEnWXePHVHavY06ZKSfxBjd/Q5wdw/5eIFYMZ6X
 Dv7VvLcspQMy7cjkJy4dXK8xdDdd3tEstfMiOU/Mayc+Qx9EfvRtR5NQI2rmq6dmmeUbs1x+d
 SVmmP8T8yHe2zTKt9ZWjbmC+xDEZ/OkRFv5/+b33en8Sn333URcLqSm9c/JFfuzBIdVPjr8/V
 J7ozZDllLTSTKDpjHi64GdY1JPwLfqY6KRiqzMwkG0TD2qRG3GBiVjr/m7rDQ/WIHc+qARn47
 WR/xnXrUp8p/P06DVCtS1RFgD47ASJZ9UQGsqk9wWj1fFhGFk9ry0XBz4vINMeR8ZKvQ5gYxK
 mnvqvjHcSy5AnZH9sWwgiUHqwNb3HgKGBm+jdttwYTQHkfA2eMRmb3BY58KcQs8PrZklj80kS
 02eqnERR0kb83GLUCEMvxXFnG7lGeiM8v2c4KNoeLqvyegYTPApm6Cut+cyNK4xUIN2+5j5AT
 4Ra9sst
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 3 May 2018, Stefan Beller wrote:

> On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > From: Thomas Rast <tr@thomasrast.ch>
> >
> > These are essentially lifted from https://github.com/trast/tbdiff, with
> > light touch-ups to account for the new command name.
> >
> > Apart from renaming `tbdiff` to `branch-diff`, only one test case needed
> > to be adjusted: 11 - 'changed message'.
> >
> > The underlying reason it had to be adjusted is that diff generation is
> > sometimes ambiguous. In this case, a comment line and an empty line are
> > added, but it is ambiguous whether they were added after the existing
> > empty line, or whether an empty line and the comment line are added
> > *before* the existing emtpy line. And apparently xdiff picks a different
> > option here than Python's difflib.
> 
> I think that is the fallout of the diff heuristics. If you are keen on
> a 1:1 port, you can disable the diff sliding heuristics and it should
> produce the same diff with trailing new lines.

I am not keen on a 1:1 port. I am fine with having xdiff generate
different diffs than Python's difflib. That's par for the course when
relying on a not-quite-well-defined metric.

Ciao,
Dscho
