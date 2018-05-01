Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6087421841
	for <e@80x24.org>; Tue,  1 May 2018 11:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754886AbeEAL5Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:57:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:48087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754790AbeEAL5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:57:24 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MTjMy-1en36d0MGe-00QTCt; Tue, 01
 May 2018 13:57:19 +0200
Date:   Tue, 1 May 2018 13:57:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/no-pager-shorthand [was: What's cooking in git.git (Apr 2018,
 #04; Mon, 30)]
In-Reply-To: <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1805011351330.79@tvgsbejvaqbjf.bet>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com> <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eYrsKHFKBlphvd9DxbEJ+xsMIOkuYDJKzvuMvyu2EJBjfstHo+x
 VG3cFkWEy3R/KnmhKm6w2UO9jVZZdMAMvf1ovzKxtiNrr05zBO3cZsnkQ48TyXsZGhVTZdw
 K6P+sIuHk8V6iEhjHBPMJzoNQrbE78e5eYHug5lGxzmXCz1H+ElhtfRGDtxeXb+URd4/mD7
 oshekqvMqplpbo89i06UQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DcbipqRisdg=:kYbQrDq44uEg4l6n/T/7rD
 mxeL/UV47CeSc2E9xuOlIIY5INxaTPIQWkrpy6jOkDMnaL9iG89+1DEE+u3g5/TJroYbtbDtb
 zb1Jh8IF8uxF35M52FiZpWm1MNnn1JE/G74bbzZ88mWWyeUG6xIJCCuchw72nRv35ONG3U6pb
 GhItUuOMuwmlFc3Hnub8PMImW76DY2i5+lGiRTH8A3oZIyBNSS1/EG8oSnonbgPEgOWeFAW/1
 HR41TzHamRbX97evsLzV+351kyTfyqPULx2FT6cXKzNImmgncwEj+8zheza/SS2GMW/4PA0kq
 690BbsCuFMi74ypqowPNXv1hdHnFLF5InjTWN6Qb61Wnf4/vjSVoyFQAQA/wPA7wXkwg3W9i6
 puomZG8gKYBhf1GVEi4MfSdKrASXpTZzfJ1AJUiGZtQEw/Vb/gdX3bbjl8neybpttLiV/56R7
 GUkXw7IeZCs35tkWbAaDqVBrzifGF6RCGmsgTzjjs8J51xGhltvgdPvfi0vrrGYvPEzpPgyJI
 rFff4TwzTRtGJ8L++uTmqCLWCGuxdUI0J4w1u87jUPdIuYXApnLObET1un+TV4wtElJlCb4Mo
 xOmT6LrBNAtChkXn6lVX7kxMWx81opu0XYez4+LuW/0HfL6mvb979G3lN8ip0BLyCXT0b0Pg8
 E+1r6jbQZ0L3UfiIrg9HCFFF7INhjbLqm326VdJOtTAaCoyIbu1bO8leQas8fIHj326oTM6l2
 R32EkdjZDrsfQMvhM0v9x4mVpDa/rj4mPwfUh8jBRrpfy+2RU53z5t8YWCbPn8K2YTGBdzz8g
 1uOB4Sa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 30 Apr 2018, Johannes Sixt wrote:

> Am 30.04.2018 um 05:25 schrieb Junio C Hamano:
> > * js/no-pager-shorthand (2018-04-25) 1 commit
> >   - git: add -N as a short option for --no-pager
> > 
> >   "git --no-pager cmd" did not have short-and-sweet single letter
> >   option. Now it does.
> > 
> >   Will merge to 'next'.
> 
> I consider your argument that -N is only an abbreviation for an unspecific
> "no" a valid one. So, I would like to be sure that we are not painting us into
> the wrong corner by squatting -N for --no-pager.
> 
> I find -P is not that bad after all.

To me, `-P` would suggest the positive action --pager rather than the
negative --no-pager.

I wonder whether `-!p` would be better/feasible?

Your use case is quite the corner case, I hope you realize that, as it
seems that everybody else is fine with having -FRX as default options for
`less`... And with copy/pasting from the `less` output. So introducing a
sweet short option for --no-pager, for the benefit of maybe even only one
user, seems quite... unusual.

Granted, you cannot simply introduce an alias for `git --no-pager`. But
maybe that is what we should do? Maybe we should start supporting aliases
without specifying commands, opening the door for things like `git -c
ui.color=false`, too.

Then you could add `alias.n=--no-pager` and call `git n show HEAD`, and
the -N and -P short options could still wait for a widely-popular option
to require a short name.

Ciao,
Dscho
