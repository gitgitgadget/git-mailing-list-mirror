Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91271F428
	for <e@80x24.org>; Sun, 29 Apr 2018 13:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeD2NF3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 09:05:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:43521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbeD2NF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 09:05:28 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meutp-1f1SIL1o6b-00OUqW; Sun, 29
 Apr 2018 15:05:20 +0200
Date:   Sun, 29 Apr 2018 15:04:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 0/5] Convert some stash functionality to a builtin
In-Reply-To: <80781666-fe94-f718-ff57-4faeddb9a183@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804291503470.79@tvgsbejvaqbjf.bet>
References: <20180405022810.15796-1-joel@teichroeb.net> <nycvar.QRO.7.76.6.1804061813240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <80781666-fe94-f718-ff57-4faeddb9a183@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xKkLRB3y9bDBMXgACkHGyBt08aax+/bmb0NrrY+BsFKhugTf5fZ
 /FZa86aqUpNKU/V81hj2OWZ79SY/CLMS8GRDRGBOlCYPUzaZeIBGXobFyNfRzEqO88Wpjqf
 AXzvVFbUcGUEc9bwEohaEALZDKDD/xbbdG834hNBYq162d8yFV7S8MJyu9UjTBIhyg2UEI6
 nd37fxihH4FUQOpILOjPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WRWOYzpCp0c=:ySH1JNb0KXoAfweee9MOz0
 PtKRDu97M2e1NU0nwxbP8s5bKZZJpFgZO+0BMz4SbpujDPswkAXS+sPaWE56K8BxAc+s3hW3b
 Tc6MhJ/cpeX3SP/FK5EkYWxj7IdQNL9yDvsF9CNqxIrdCR+iRrBHlfCax5C3qLi0bHifYDj2O
 GUz4B1z5wZZpX2tBijgcAeZ7DUlObjT498/SkbdZQpWS/+QvZzHf3IsVVFkqYPcEvWzXBuF6M
 dJBcu7598uTPWA5AXQ6wl9MXSuYjg9R01Dw1TtmtscVhfOfCJxswkV6+b7nzsMYd2LDiJ2iaY
 SQy3+6hoKGGQedSL6yAF1/iMXzcDqMG3r8R9MZpsiHTDhi9k7By4d80r+1iVXJ26knGP4ZYc7
 l4olol1H4aaNHs6n5zrjw+aN7mYs0Yv5/A4YPANNcwIYajw2nxTBsgRGJ/o6zDjOQjOHMBEGQ
 9H/5lb8ifjYL4AOGiGrgEoiY21vJ7EIjSlcbMfeaBSi23iTaorgnETjqt8+WHpRXCt3crGLpV
 BGxOkqw15CkWR0HAiv3sszRk5BZho1i0By0TYcKyuYjfDGig5umOC7X7+vQPRsKlsohmiqD3O
 gMFJTXoZag9TBfW8Uvuz2ySUH9FK3QqDERIgl5XS7zuWgGakvzPHUaRwVihzHKjgmFCtewfIb
 q0LDhMf09UQO8xcea8rkbom77Jo14idPhZwSNg+6GLe+WVMY1eVTllEEgPXZROUd8kmk8CT7/
 HLYlm/QE6yNedcqKaeJThiP1tvsz8l6bp8tgni/44awDa18hJxrwiTIgArkylqWhb8OXmckg+
 qiwbINi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 29 Apr 2018, Paul-Sebastian Ungureanu wrote:

> > > Since there seems to be interest from GSOC students who want to
> > > work on converting builtins, I figured I should finish what I
> > > have that works now so they could build on top of it.
> 
> First of all, I must thank you for submitting this series of patches. It is a
> great starting point to convert 'git stash'.
> 
> I would like to continue your work on "git stash" if that is fine with you.

So you mean you would like to take custody of Joel's patches and address
the reviews so far, then re-submit?

Ciao,
Dscho

P.S.: Yes, I think I know that you want to do that (as we discussed on
IRC), but I just wanted to clarify on the mailing list, to avoid
misunderstandings ;-).
