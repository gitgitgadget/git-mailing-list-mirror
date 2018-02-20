Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3851F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeBTWc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:32:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:43421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBTWc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:32:27 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfSrf-1f8z231DTf-00P87b; Tue, 20
 Feb 2018 23:32:24 +0100
Date:   Tue, 20 Feb 2018 23:32:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
In-Reply-To: <20180220210554.GA24474@helen.PLASMA.Xg8.DE>
Message-ID: <nycvar.QRO.7.76.6.1802202329540.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180219220819.GA10466@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180220210554.GA24474@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gqtkkU9fcWfEYzTkriQ3fTEcY3N2wDV0nSLFmjjh15LGNAAHqyq
 o/numBB0tszBmnSQtoAC5z2+RuVmWXXvMCh+utQzB2oqgT2pWVcjrfUtV5Qbwu10PM/GFmJ
 AtjwBk7vBZc1pAlezErie59TM2UFLCmVoxkj0kxXAuqtqG8n5xD4SsAPLHkHWTWkrJjOq3P
 agfi+RkgBewNn5IOFhD4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TQGFMQa+8H8=:g7MeZnbZHhjDwiMqf9+LZQ
 7MAk+pwj+CP89M4jO+zjJ0nY9+nNYtcAIXHkqnMmf6dAPBJ4ViAf0faG1ooxuZeRRGEtLGkyu
 1VgsnSSabhZReEVffUxbMbxB3Z+nwBprnVjMl3dEk8S97JA6yyBGEPwjApaKyuzg48pZnhTKI
 XxOVq8p8mhHn1Qx1lnMHNnN9I40sF+a75iZiaRORnI9P0kd2hG7chPEuLnpIIoU75te3Yf3lG
 lrpZY1Z0Eo7IWYtF5MouRPkVpGejPlUyJwVY/BLKG+DcpbePHDVgAuPOsnSJQVVhSZEVBj3ZL
 xlfiiVyb/TA9BP6inFyidQf6nTpXJ6syIFO3Mv1Ud7AsO7BcBtnnfR1DO+RwFAwCEGQzWa5vF
 ddBcdEpU5pPxjrpYgH/6ZiifW7yJAKYv1AtCnWpvz6Hw/tTYME+L1ewO4A1RlaEZ8OuHqywHX
 +aifYX16vKtPQqYsCgejUkmQBTO6hCstNhc3yk0yxJRJUdmnu0ZSo86Rf/5IOGxaPNxbgVvKy
 +pW83WDWzfaLAa+uskH47JtG8i9WGsdQDvpPQ0NHIuqJ9QG3Jrg14DzRc0FFtep/BMHm2/5h6
 utA2qc/F5XVCM24MM5Z1LamxxOoqorFX6c/545bkV4AOYwUG6fHaJ6TPK48nJRxU0nO08e0+c
 rblK5V+mcHrRAr6WySxMoQM04Nl/BeLZuih7cVLzwxv/TwhFamJiX6ALkV2kePgMHlO8QDbg3
 CmZuONi4NN3mBnlvvHE5Sr2OVvhoPoQp6ZLVEq8ES2btaxo8q6Pqk0jm0fBT6Qu8yRKKBsSF8
 p0nR1MNQmhrkZAcbGKWrZ55C63eEASZPzXn6QtsBfwLbizZLl0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Tue, 20 Feb 2018, Peter Backes wrote:

> On Tue, Feb 20, 2018 at 11:46:38AM +0100, Johannes Schindelin wrote:
> 
> > I would probably invent a file format (`<mtime><TAB><path><LF>`)
> 
> I'm stuck there because of <path> being munged.

From which command do you want to get it? If you are looking at `git
diff`, you may want to use the `-z --name-only` options to avoid munging
the paths.

Or are you looking at a different source for the paths?

Ciao,
Johannes
