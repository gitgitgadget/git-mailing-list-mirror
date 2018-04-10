Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFAB1F424
	for <e@80x24.org>; Tue, 10 Apr 2018 08:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDJIlf (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 04:41:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:58683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeDJIle (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 04:41:34 -0400
Received: from minint-aivcfq2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Mbx62-1enbli0wxK-00JNMd; Tue, 10 Apr 2018 10:41:32 +0200
Date:   Tue, 10 Apr 2018 10:41:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     vaibhav kurhe <vaibhav.kurhe@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Want to start contributing to git through this task: "Use
 dir-iterator to avoid explicit recursiv
In-Reply-To: <CAPig+cRNbDBpDn_ku0cXJhzvnrSOkBTztp8tWomePxfXaviotw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804101040090.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAHKv1qs-cnmcd2pR9iv=Xx1aKnb=SEsCQ7OAjy-4yHhCE_e_dw@mail.gmail.com> <CAPig+cRNbDBpDn_ku0cXJhzvnrSOkBTztp8tWomePxfXaviotw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ND3bjfJ4x91JsQmGSrdhulbE8R2QYB7PMAeBPz6likCmcus13Bt
 7ivqDRB+cIhw9ZaXGLLL7dNbR164YBm+KKta+PIj4PrIr5q+xg0e1Ok4/pwrJGXIfZpVXTP
 nYp1rm8XOYNU6LchqM9ZGrefwI/2Yv7IllPEv5faGnokcAhw3G0kvFrjWV131zBgyxQsnPA
 E2AeB6NuxnoJdNdqc3W2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O5pQ+M1v1bg=:+KDE8yGS9sBOg5+mZ7yXhM
 AnQChJ1mqxge58CrTpng/bI7b6kbfSntmPhO6IWBxCOvSlwkNJCedVhhoaMgekkLni/XdKlM/
 C48UWMuV62uhvmz1Dis2wJ4ulW4eAo1KQKbf6nEUMQtKnwQCdIkbSYgBQJXlMedde+Ei1GIAJ
 zDhUPjqmbJYHUGl2WyqRJctDKMRZzzCI/+gpGq+sLdCdpQezGZPoL6r8+FOhr3v9G7zX2eH2D
 BXhmgdEDXIn2joXYRuUD2sLV0mB5mE8Rvt/jX95017HyrFrB9dm+8ouhW5I4QcDpo2Ri+4c4E
 NWmWQGt+gz5qnhNyix5R/lpHBnwHlvLE9Bohub9C04xDDDvl2HMj0etianSsENZvWl53uUjH9
 Rp1uhDSJ1hS8O4I1ppAdx9fYWweDIahxxcPFbnh0kJ5c/E8EUGgvVbsMwChwSlqMW2vXpEQnC
 7ag9ln/tRFoKXvXOPWW6EIDuQKiFi4LCSpWiO65komck9DnSgiizeaPeJAn+/D5/7LByXa3ef
 hcfdAvWcHQzjYye4Miu1HAQsoPN40HMl9BtccjobAfp7iSJgARBMos95/GX5ZjrDlYW/uGR5a
 5yt+PQ6Nt9hdxQ4jI05SDAxK7qjwcoLaOSvjDaiINMSsc0fpwjKe4ZcdyiAV5UfjM0TKzttQO
 y83YD5qI4+yQB5NgdOZRzP8Tz79W6oYH7PzqiA4um+hL1rlqWCHn8br0dxWZ+hMIsCObVqzFw
 xmB6H2d0yCiqfXGjVh3m251iw+fXGqg/8t8NUnQu5fgBDUd4+HmMg9YKuL73jpEr0PirvplFh
 1RMXV8S1WSdS734gUS5HyohFNHePk5OPVlTWVDFnXSAFuBe6jE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 9 Apr 2018, Eric Sunshine wrote:

> On Mon, Apr 9, 2018 at 9:51 AM, vaibhav kurhe <vaibhav.kurhe@gmail.com> wrote:
> > https://git.github.io/SoC-2018-Microprojects/.
> > Out of the tasks listed down in above URL, I found this one interesting:-
> > "Use dir-iterator to avoid explicit recursive directory traversal"
> > I cloned the git repo and browsed through it. I found that in git
> > clone (buildtin/clone.c), raw directory API readdir() is used
> > recursively.
> > So there is a place to change it to use the already available
> > "dir_iterator" structure.
> > I just want to know, if anybody is working on this task already.
> > If not, then I can proceed to work.
> 
> There has been no recent discussion on the mailing list regarding
> this, so it is unlikely that anyone else is working on it.

Indeed.

Please feel free to reach out when you get stuck. If you want to show the
code in progress, may I suggest to publish your topic branch to a public
repository, such as on GitHub?

Ciao,
Johannes
