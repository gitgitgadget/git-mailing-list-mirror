Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5D720984
	for <e@80x24.org>; Mon, 12 Sep 2016 08:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbcILIPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 04:15:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:61449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932447AbcILIPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 04:15:02 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MarNa-1bTLfl1xxS-00KPVR; Mon, 12 Sep 2016 10:14:43
 +0200
Date:   Mon, 12 Sep 2016 10:14:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: respect commit.gpgsign again
In-Reply-To: <xmqqr38q6r5b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609121013510.129229@virtualbox>
References: <550e7de5e08e53b5893e1ce021bffee468adfc9d.1473424091.git.johannes.schindelin@gmx.de>        <xmqqr38tapv0.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1609100903010.129229@virtualbox> <xmqqr38q6r5b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b5QFOf5loDjyei6G9NBPNdzBL/cm2CMupUIgjjCFiV1m7/J10C5
 imiZEGvrCmwOHv07xbdkGqO/t6ajIvrSbJY7swC4d/AAJ/bDYZIv7v6LNvctHfK0fyP1k6v
 CPRwkxBB4t739k9LMoPKV1los8J2jDeuWIPHKSLBh7IKnwFifl+nHAqROMT72Ann6v+4IwU
 GGTu6u5Y3otvgJ5JB+3QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C8VyUTkncps=:TKPOja+ASQsJscSjzoq8Hs
 hbCMNvUGx4TIMCi0l9zWJ2oduvZyuSOv9kWK7NfH2iVbI7CUGKuTWEOHzJl3hSCSe9dK2xrXq
 P62ZmCmJuB61oskXENT+xlNU8z9Ni6Md/2WQoECvHxJpbDqb02eF/9js7ITp01+Yy2ysomzqu
 eHEIRwOsQJhyAcF1Vc2/XA/aiehaCiX9BMFpOc7OSXxfMNPtrCkClK9Hzm9gBZdxEVpKmCcp0
 mBDlCMhQcXrXr5f2WUWdI/8AwyVO0yIWxEW882TAl1v5CIBiZaTOFuB9OfDh5yG9nnT2M+kHv
 d/YpfLa3yyphriVCBbzLMChEyCN2AdWjK4ZElgtbs9IvowQnZUrCJkHIA4RCqI7dVnaFR2ArD
 BCKFV2K9pdv39unEIMYJya8/ONaxY/xwsNrjILSSXPBtgwyYuevp8WRCH318PRmOdz6PnJtNV
 C6IJTrCS+zQLThPtobf/Ih2Ff86X4qSzascG+P2UGggYRRl6umtPUTP1NZv3Fsma9utRldAB1
 ynC33/1RbLtLUFKLuR/csJJ66S/4EikAQPtcsuzU2oBICHU77PHXRac9giJ+sgrmZ3bwid360
 x5bUBztUbQgAHWixugshTGn28/kKoqTmzQZzm8t7vzGH75NpH9iCaOw/MOiCxp9q9EgPFZRcc
 IZLMWQX/X/Cj2JzCf1MPvO4tIVwgZISnhecPDTR0LXNNdhJi72Xd39SJ33VQEbGc9J31ejlNI
 ZbYWQIcgDCFcQXT8a3c+krMLgF/CG0iDq//+iJKnjrAZsfg9qpBC+O8Hw59lafKpRtUDHZY42
 SURZEBT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 11 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Thanks. There are a couple more git-gui patches waiting for quite a long
> > time. So you prefer them still as patches to git-gui.git?
> 
> I prefer not to have to worry about them myself ;-)  That means that
> even if Pat steps down, the next maintainer for git-gui project
> would not be me, so I wouldn't be making a unilateral decision to
> re-root git-gui.git project one-level down.

Makes sense.

> > Also, I just noticed poor wording. Would you mind fixing it up by
> >
> > 	s/committing/& with GPG signature/
> 
> Ouch, I didn't notice.  It's not in 'next' yet, so let me see if I
> can futz with the history.

Thank you!
Dscho
