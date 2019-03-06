Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D778520248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfCFKFd (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:05:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:49983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbfCFKFd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:05:33 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1h0NUo1vD2-001CtE; Wed, 06
 Mar 2019 11:05:26 +0100
Date:   Wed, 6 Mar 2019 11:05:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] remote-curl: mark all error messages for
 translation
In-Reply-To: <xmqqmum8sx0h.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903061102260.41@tvgsbejvaqbjf.bet>
References: <pull.157.git.gitgitgadget@gmail.com>        <xmqqtvggsx6c.fsf@gitster-ct.c.googlers.com> <xmqqmum8sx0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TXw+t8+spnjFjsJiqSvKwrTwfAhum/wV1gcgudqIqYvxQES5A26
 11OHAnl37sSiW3RXqd/rtWhYvTCSejgW3+hTNgLwCOqLPzWihzUFLDLgQtglRWWHpRqWJ+O
 GHX/MeC4YyevQnhJFxgW6tV4HJVQtK7mxeg4wFX3cdmlctTj6cJwyHEoxmECMIiW/VEhSUJ
 A/6jM5zOeZkQucr+yl/eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8t7deWdab8w=:FqOoTPdMic8EwwGhswN4dX
 k/SwvV3eeYdSOiSPTh9LUuHPeCvhwKh6wnkcUkxn0IuBKJhYVYmb9n+Yg6hfkm0ikScyuSYJH
 wpxDyfB8HxR9xB7l2LBpAPwO9QOxcqAm0scbp6AYOi3U5Qf/twP8fulVavruAciukx9AMmd1P
 UaeMrsdOllSXBRHSzAvmPj6u4uXAaku/padtUeJSm2KJFFYroj719n9tGNoIQO07hrBKmYDbg
 XzbDrmnHi6x9fjkI3lfTOSptKqpR3OpelqAbtMdsQ27FSvSAS44oWacA55w3SYq2u+9gD7oKm
 jN9yYPe17YHQjBZuQZX9oW5ACbx3igWNnJS9JujO+VJmD7O/THo4JKT3G4ithy9cFoutFvV8m
 xh7ZUAcHJqU9MPU205ouiaYlCtDOi+OHIpNSsiXpV0oqBBimit5iBFe6uuYIF77Xn8yCK4Xlc
 8qspFm0fJAwO+jMsPhW21M6glPynPcmoZvdobqfTq4BzC6rqlaNdv39rdGaTFi2bK5PuaOCxT
 ypaEMdJLe8j9A+GAYq69UwnoH+4tGbFlkQss2w1o6muFnWk/NHSwVmBPmqjg/OUJ3MSoydBV7
 uKklhgXQ7PGWsX2SPCs+OyHR+KolTO7HYycNHSE7fRNM5MEqJo3BCvyzdtHOO0uNM75lWq4kR
 5nwRw/W0smsYYH+y7BnrsXTuyXv0uHkQ+67SI2MWhpHM47+hER9B1RRN+rU/azKDtH4GEaENo
 tT7dVxyrqQEbI2lJuo1yK8WPu5dMsQaIc3X/0VoFMD/QcelWCip1GXw1c2eXkbQk8C+pJfAzY
 IOTAyaXWWM+EBQVU0OQdkEhs9hftmVm23TRS9Iw+pZzp+MPtNPrdrhpS1mz+3B8VbH+WJcBk6
 gclqVde5GNaPyrqPzkU9GtuWNg7ZP5eIVz/jZyLhACrLcGsJmi/v23dfkE/PKzpSvd8h9N+yb
 6vLcNHKRX2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 6 Mar 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> As suggested by Jeff King in a nearby thread.
> >>
> >> Johannes Schindelin (1):
> >>   remote-curl: mark all error messages for translation
> >
> > Does this come on top or below the anonymize patch, or it does not
> > matter which goes first?
> 
> OK, will pile on top of the anonymization thing.

Sorry, yes, it is on top of the anonymization thing. I was assuming by
mistake that GitGitGadget would display in the footer on which branch the
PR is based, but it only has the commit hash of the "based-on" commit.

BTW I was expecting the merge conflicts you ran into, that's why I kept
this patch separate from the anonymization thing.

Ciao,
Dscho

> 
> Thanks.
> 
> >
> >>
> >>  remote-curl.c | 50 +++++++++++++++++++++++++-------------------------
> >>  1 file changed, 25 insertions(+), 25 deletions(-)
> >>
> >>
> >> base-commit: c1284b21f2436de24c9559fcc5f4badb04f47773
> >> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-157%2Fdscho%2Fl10n-remote-curl-diag-v1
> >> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-157/dscho/l10n-remote-curl-diag-v1
> >> Pull-Request: https://github.com/gitgitgadget/git/pull/157
> 
