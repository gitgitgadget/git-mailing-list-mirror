Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1D3200B9
	for <e@80x24.org>; Mon,  7 May 2018 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeEGCFi (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 22:05:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:38221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751781AbeEGCFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 22:05:37 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVYB-1ezLYn0xh5-00P5jO; Mon, 07
 May 2018 04:05:22 +0200
Date:   Sun, 6 May 2018 22:05:16 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <20180506225627.GB953644@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1805062204580.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <20180506225627.GB953644@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iFz1M7787TNmmXUw4dIP1CoPbXl/PLHQSuVx3xwsNNobwUftprV
 pE1kNeOqMf5R9umGh/ITWg7C33jgMQEtp7yI0/HGIkmw3LfUBkJdscHeJxd8AUkbSDw4rYz
 HELzD1UvjSftxODLDf+twqnGQ2prvkAV5fvc9xB8VaRYK9GCHIBRRwmOnoprc+07X3hU6hZ
 gr8GUbkFV3wWUqb8xwO+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TDTc/CKJZfc=:a7i4hCf+fTOl5201JH1H2l
 LHvtA1Io6OeQ4AC5TBgp5NKhwxQRAStGJMXrfR794lL8EYLpLtk4Q84/QVWXGaNLMywe7Guex
 3kK2o2y0CjjGv9s56bM84u/3pUvFxOXPQjhHlICMu5MOldb22qfqz0HcVbR948SxMyOBMo10/
 r4AkmMNu0fRnWRFbKwKl3KF/XqFSZoL454jTJD2dILcH5ff9osZhDZn2ihAGdTvTa4KpPjhM3
 TxIwvFxaPFe/eZWho8bPbspChJqKZDN63om0p/YSxo6d2QoQTIGSycjR8UmV49lR2DXotYjdf
 N6EJ9alcvUlVOwJIre1eCmGCv9nZOLBba22xxfxw/LTm7BZxr2smZqSgvfB8oc+As0mTWXo44
 tTUhGVRYa/GlYzFOGB6bc2gePr6AzwHVRUZXqrhHlpfdc6w0lpCEuNDooZi/16nvS2NeYhJ1G
 TFI5q5aOEo7EBGxamCnVIpm3xzNgHWfJfJ5sx+F104yYr14c+hBvl8+RO4syM+wwF9HLbaILj
 DSHgbM6W7Szpz8EcPdRuNZifxKtMdA6CuAkyjsqV1f6rqyFF99us6wdjh26VvGpb4DlTFyLvV
 nabPu/irysTPYxeVQNO35uOZCfc0zID2Ag+/+gwsRgxW4tIpV/JENl9hJ6TXZQzWZdJBKNjZy
 nw+yUjJiGgvCzjHi+fVJ5AOHnEtZm6szCMu9q+xxAqW2BoWbyBG26O+YqQVZbN+m5whSaenMJ
 e/XqdVgdjwN++8PXhBMdLOGW5lUHnupGH5iNZJAWTMZwI4oA9BjDG8E3cmLgpElpTQyaFUQB0
 vPXjFHi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 6 May 2018, brian m. carlson wrote:

> On Fri, May 04, 2018 at 05:34:27PM +0200, Johannes Schindelin wrote:
> > The incredibly useful `git-tbdiff` tool to compare patch series (say,
> > to see what changed between two iterations sent to the Git mailing
> > list) is slightly less useful for this developer due to the fact that
> > it requires the `hungarian` and `numpy` Python packages which are for
> > some reason really hard to build in MSYS2. So hard that I even had to
> > give up, because it was simply easier to reimplement the whole shebang
> > as a builtin command.
> 
> I just want to say thanks for writing this.  I use tbdiff extensively at
> work and having this built-in and much faster will really help.
> 
> I did a once-over of v1 and I'll probably take a look at v2 or v3
> (whatever's the latest) later in the week.

Thank you so much!
Dscho
