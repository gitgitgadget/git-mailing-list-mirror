Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BB61F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeC2OB6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:01:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:57883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbeC2OB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:01:57 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1W5x-1ehpHH1Vt3-00tXXU; Thu, 29
 Mar 2018 16:01:46 +0200
Date:   Thu, 29 Mar 2018 16:01:45 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
In-Reply-To: <xmqqh8p087ck.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803291600240.5026@qfpub.tvgsbejvaqbjf.bet>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net> <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com> <xmqq8tafe92r.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803271630210.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqqh8p087ck.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hpvt52FgDxi49C4VDUyBH6Aiqnynp7mvNZtppZXwwscCFcjB4An
 Lv39UNp2vS2dWYaZ81q/knlfRRr0duU77orNPhD5VOdurXVn2ipiFLPm3xohvs8RFz2lC7L
 qLwlPvW255OPSMJ0qFRqva0NwqnWQqKzSG3It2CX5xd6MB6iB6+IEJeSMsCb1WBFXiMtNBd
 eKSr9W3HD9gPW2mQuUKRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pPgGT1ikuGQ=:au2LkP1apBp5kM5KZ5IUcZ
 AWkBnF8k1TB5bkrEoD3Ag2O5AzSqWLCDnbaSq6g15ihjXUMNykfPzFJYwRYIFmNaicMTdtLjs
 qJ36Ti4u5yUa5aJYmLsfYGcq4etiIP5k9/FzqyyBQ5tUfSj5YIv2UM5hLMidpHKvjVcWO6aFX
 2siCGgnCEGozl9JKPwXT/PofsfQuguIrB4874YuKXlo2i/YiUv/SeEZCTsAN4dB6HpGFrPC6F
 oYx7z5L2wwFUTUZeZmfnqMYj4Z6nJAJ2caqg0hRigBklq36WyZD1/ohO0cgl+hCgMa+bUqk3m
 kUIVNJkuK9HSj7uL+O3YUHM9hHZmgtwJh5dDHSRgB4KTlNWEkrov6FXXHX8Y/RVxtW1oRTHhl
 Ga5nHs/gw+6+X1XbXJSPqxD/aYwkL+DglXMB5GoOa7Q8Ufq12aKIpREEk1zA/GY8VNE0r+gd1
 QqUWhmVi8rD7sq3PPlg1B+dUT49N3rM6tYXC7LaGLPpcqUVJokyHnVFlruTHcU5ilB8QUkpaD
 ZVsQGJC+rjeJ+e1+u3AYaYRXP1ihdmIqg+H69QXtuJ+dzIupyfshmi9GWc5fP/J/qL95ZpFne
 VY3am8VDMa1/4b49eaAGShLmq5wSC4iU/6Ec/B9ziv479CQvuXLkHvJdVK/Mi0WMhHOnjScpJ
 BbPqiVefPgK07mQBbgvRysMdjMn/yQs0welsJNaATbZ1KOBMTSbJpbh6jOl71YhvkwtsF7guW
 nSSHvzHA258OqK/kWe5VAZPq/lxijog0JaECtJ9NvFTBLq6ntUlsHsXujg4hQw2AOUqZa4Kb4
 eDCxH7FXYvz72eMwSxdk01R0Iw4aueadwgmZ6yMIa13kVazJJwhAAmQD3XtF51IPScMl0Ev
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 28 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Ideally, the existing one be annotated with prereq SHA1, and also
> >> duplicated with a tweak to cause the same kind of (half-)collision
> >> under the NewHash and be annotated with prereq NewHash.
> >
> > That's a good idea. I wonder whether we want to be a bit more specific,
> > though, so that we have something grep'able for the future? Something like
> > SHA1_SHORT_COLLISION or some such?
> 
> Sorry, you lost me.  
> 
> What I meant was that a test, for example, that expects the object
> name for an empty blob begins with e69de29 is valid ONLY when Git is
> using SHA-1 to name objects, so such a test should be run only when
> Git is using SHA-1 and no other hash.  All tests in t1512 that
> expects the sequence of events in it would yield blobs and trees
> whose names have many leading "0"s are the same way.
> 
> I think it would do to have a single prerequisite to cover all such
> tests: "Run this piece of test only when Git is using SHA-1 hash".
> I do not think you need a set of prerequisites to say "Run this with
> SHA-1 because we are testing X" where X may be "disambiguation",
> "unique-abbrev", "loose-refs", or whatever.

I meant for the test case to be annotated such that one could find easily
which test cases rely on specially-crafted objects to cause identical hash
prefixes.

But I guess it is not worth the effort (because you'll only find out which
tests miss that annotation when you try to port the test suite to a new
hash).

Ciao,
Dscho
