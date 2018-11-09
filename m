Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990731F453
	for <e@80x24.org>; Fri,  9 Nov 2018 12:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeKIWIU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 17:08:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:58691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeKIWIU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 17:08:20 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2Glc-1fTGJi27BE-00s5ts; Fri, 09
 Nov 2018 13:27:54 +0100
Date:   Fri, 9 Nov 2018 13:27:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 14/20] stash: convert create to builtin
In-Reply-To: <5ba50c37-2840-e1f9-4d35-877979018f1c@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811091326500.39@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <a4faed3c8aa5ea8f0d4c578b693f3b5de3e3a709.1535665109.git.ungureanupaulsebastian@gmail.com> <nycvar.QRO.7.76.6.1809031718230.71@tvgsbejvaqbjf.bet>
 <5ba50c37-2840-e1f9-4d35-877979018f1c@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DxHk6ul3HF0EE7UE2G+qLmcYRgUojldxHRfUqEwuWXOltwibgq1
 ByfR7WXIWVJL5yDtt/pUlRrn7AnWsZN/ZTup+7zG9t/cgB9VPNr6PElUgNWKC+WoIUSlJxW
 hWVRqKFbqpfzcJJsv1Gkgzw6DkyTp/lDPm0xIcJWflM/QKRoNPyQYxTDZjRx9GIAnkVQaLu
 MRvloYTp9IlaC8h+v1Peg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B++FmDXvKxQ=:7794Tl6Vjv77NJOh8qy5uj
 1T05TouYP42EV8JCb0JK+OkSsUt7mt0w4B3r0zVI8f97EU9LjDUlgbgXVmLqPgTFC58st+us+
 KEdt4PlBQK7ZBdd+C/WPtCff9f2e4IBoMVwcCZf01qaUrCWzOTWiFcwmi5qMD3mVcZSGt9dUq
 VDdIUM/yAUCdkf/MIKZqCIIYDnnAmktpoWmSKiVv67IF3nSgrhWP9cqMIbVOUpOo1B5+QXcvZ
 2UPrA5Tsx7QCPZ/NooXk7Sqt5hFN8QsHh93YgW2aBhlHyacjsz/EkmVJQIVl7PSYcfGGnhekJ
 +D+TV8ObmHWOfyDiibTnCNDyC97fdVSvmr78daLFc+5CRjT6ZryJgT2uTSXHyjSRRTyi9pLjh
 KSjgl+bhc0+SqwfZ6ROC8iOaLXee8yq/Lls3vmRL81iWayucFgO1NhPBor9uLVot36PcsrWC0
 OGNUxUZyxKJ4J6x/+c5V397mlc20ch8E/9E5jp7S7AAPF9Echdsu51LBcVngs30iJkuQ9/21T
 An+T1fW5RprVM+whptvUEB2XK0SmHlzkCKpv66xjYZX6S0BCAz5AMm8xO+lWvLnFGBmqAFgBB
 896d+rpIyPbTRTQtSnjGjnYt+oGp8GMoRqTgq4QMcBU/5ZI90u+CrUtSpF0DdTKCpY0iDLu2h
 lxXpTMIYYAR7c1t7SOC+opbRxq4vo+I3TvJJgP+YPtg46jPNDWsrQ0zhpjsLEIy+GK1+4Z27V
 QMzybUtWlieDjjbcbTcciDysXReVgEscISwbGXU+Ybeh0IXH1x3TgrhJkUE4E8k5FxUrv+hCh
 B2kwe/5/cgCpM1V9e1w7uPMxeNNBeiwJv8ZMgWTO6oer0xx2coJKMaM2WS5wDlev2nUHTEUkp
 IaVT1103ZbCklvH5CjPIyxfNxohjXDPk7P9MgxuqI7HtnE7NE+fVe1m0GAmf3C3HJmt832N2X
 lOzDyGlgJmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 26 Sep 2018, Paul-Sebastian Ungureanu wrote:

> Sorry for the late reply. I had a lot on my plate for the last couple of
> weeks.

I understand. University can be busy times.

> > > +
> > > +	git_config(git_diff_basic_config, NULL);
> > 
> > Is this not called in as part of `git_config(git_default_config, NULL);`
> > in cmd_stash() already?
> > 
> > *clicketyclick*
> > 
> > I guess not. But then, maybe it would make sense to run with
> > `git_diff_basic_config` from the get go, to avoid having to run
> > `git_config()` twice.
> 
> I am not sure I got it right, but if I did:
> 
> Running `git_config` with `git_diff_basic_config` from the
> beginning wouldn't be pointless when we would use any other
> command than `create`, `push` and `save`? Although it might
> confuse the reader a little bit, the stash should run without
> problems.

In my mind, this would simplify the code. Which is always easier on the
reader... ;-)

Ciao,
Dscho
