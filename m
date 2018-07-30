Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350DA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 09:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeG3KlD (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 06:41:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:45289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeG3KlD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 06:41:03 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lgql4-1gLtK44BqI-00oEfd; Mon, 30
 Jul 2018 11:06:47 +0200
Date:   Mon, 30 Jul 2018 11:06:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dan Shumow <danshu@microsoft.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: Hash algorithm analysis
In-Reply-To: <20180724221008.GI18502@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1807301058560.10478@tvgsbejvaqbjf.bet>
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com> <20180720215220.GB18502@genre.crustytoothpaste.net> <20180724190136.GA5@0f3cdde9c159>
 <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com> <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com> <20180724221008.GI18502@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kqNrAJEE0NOq0Y3y3JOlySjcy8Bd/3bxLRCMxAzJO1kxXVXkWe0
 cimiK730g1H2ghelG0D9DCt3Wym96vTA+1kxvnU5RfHkKHMBzt2WEkRe2l1So5DuijlMsR+
 XqVI0yVFbuf5qTz+Qd3i6e9CJg2om67tORrUBob7xuB++dyhGbnpob2oSlEDHDfCECH+hCK
 QFsYDzg0C4ubYc02XShlQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kGd9LjYKYVk=:/Ldy29scVk+mGRnyRO/KUT
 w8c9LfIrXf+D9YB4EnbORvWsLENnCeehDd9EvPmvVfMtT5Ln5ceXVx6DHy6zT1LK+bGuwZVep
 /zG23CjlcFtzfLVuEkSsADelYQfAiAKY97hsAp5ISqlvyjet7OxDCCO6dvCDzHT7FnzTSmMgt
 pTkiPIApC751359WhLfts0JYKHr8YK4sX5bpbkOldqujD3n7f2sNOo79UgXHPMNmnSkS46dn/
 tfiOzrSTcmFFZAflTDIs4coDoQmOnEjnrHK627sBsNfks0+gf2DL0GtPF/Uo8YDGh3fggD+5x
 UVuaIJokNx/Q1SttTjKPINxgDAZFLOAJ/yJH6MrzOzRbyjdB1RHQu7wxJMW73WfwzCmkDtHv7
 ztlfTdKTvELVO2f/6agB65Uav919WGNFe/jQS8h4hRcdaeobBnZku1E9ce4aUyi6zkDrjXRZ7
 gQ6NhbfzBu8bJ5bM6ioLHAe+MkGd21Qk5Dl523GaTs2YG4s25ghliRvntTm3N+HmUPqUd+/lY
 /d1fWq/u+vyxD0QIJNqqEG1UkOjQSdEEGtes61Z4ZClJRpJn3bilNO+bwHewwjQxvvy39SRCW
 Ay2Le8MiHixaDTWKAAtjoh4qBumOZQ+C5KqCS9dk3QyoXYB9JWMc+174gVoTVL0FKmCi2ly1U
 /VEPS1Mt4AF21Gk41Db4gdH++hCMyKAuQJGUkMSYDbQjIxnQsuGP9ZPy+6hSawx2L31IR2B4M
 EE1BsnXPVx57Mue3KyqdJMTvLQox34E6aUJE4g0iGr9WfKMv/wJgBCp3f9uFQZACzmAbvX7Sf
 3yO6nQK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Tue, 24 Jul 2018, brian m. carlson wrote:

> On Tue, Jul 24, 2018 at 02:13:07PM -0700, Junio C Hamano wrote:
> > Yup.  I actually was leaning toward saying "all of them are OK in
> > practice, so the person who is actually spear-heading the work gets to
> > choose", but if we picked SHA-256 now, that would not be a choice that
> > Brian has to later justify for choosing against everybody else's
> > wishes, which makes it the best choice ;-)
> 
> This looks like a rough consensus.

As I grew really uncomfortable with having a decision that seems to be
based on hunches by non-experts (we rejected the preference of the only
cryptographer who weighed in, after all, precisely like we did over a
decade ago), I asked whether I could loop in one of our in-house experts
with this public discussion.

Y'all should be quite familiar with his work: Dan Shumow.

Dan, thank you for agreeing to chime in publicly.

Ciao,
Dscho
