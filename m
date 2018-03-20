Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A121FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 14:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeCTOxE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 10:53:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:37571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTOxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 10:53:03 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lfppu-1eEmgW1Skk-00pKSb; Tue, 20
 Mar 2018 15:52:55 +0100
Date:   Tue, 20 Mar 2018 15:52:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug With git rebase -p
In-Reply-To: <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local> <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yAP+B+urxuQHihobr7MdVuzAo3RXzPr/gLa+HCrufWJfOef9Oxo
 c33Ugk3x+EKN8qyltDuvOpVyXEFAXS5kWXQMSCbOAZgc2FMXCzW2/QujYazLG7vbjRgJe/x
 mrfAKdgOv8cEO+l9Am9SSMIi2PJ43ulSVQZcFA+gYm9XqHjVxB97K5MoG/awU+FC8iwktqD
 OuHKNQAhx7DAlju7ByZWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IEih0huE1Nk=:UA5D89qA1KGFz7T9sVGS2u
 IR65kmt6RQU3Ksqn9seBinwwkWvOUjdxLF+JCtqTxgX6pCTX+K/nTTyX/tS8PLvtNVeyhxVJ0
 CpGZbwS3V+24EvDxHw4/P2zUHUZBdNVoNTCIT7N0q21OsC10AlpNI/HW/j/ypf/2EksGShymf
 CLEAqRo0eqP/exRF1W4v7VFQXGU442aBzop9N9m8ibp6qcp678K0o6pAR0iWqLSp6CMcaq8kv
 N3P/aqXcHQR7Z/zmxpYRmZwVMqHIhEgrkojCMS5Qh0+5aSf9XI7mgPOf+95uDt/lT5YMx9Tli
 dzuAI1W7U3QRZFhUr2d5fMjahA+g9OoEKNzqHlyXXn67eMo9GdiillG/22aCMS9ph6iSTyaOB
 oEtGMML2F3HHdyalXVUR4cT326ShijcGmV3FICfcKluoVqurg1prasbuTCG41MgMmSonYE9To
 mrlvKtrfNlaTsEfUWRyQkHj3g+0x+BXVJxvTls33urO3u2Exwd/hR6lVhE92BrcZoVnlrMyai
 Njsou9dR7P4eaP8e0w8cUFzvLqMEAjPCZmpcO7q/yl5FyCumc5t2Ivu8lGm55nY8fyTuXe9wx
 1e1J80mzCZ3dQAgdG/atd25tCyxLp2FMJEM5jtVX266+98mXrt70YKvu44a9SlrFOjNc6xDrd
 kv+0w3GR2YPmC3qax7bMBnTeqBXHRwdS0bXKf00DPv/XPTaGnG+R6ZAndk8/X8AxqD3i3PhgR
 450ts/pc1uKdshO5N+LC6EmxOoEpIpiWR76zhyEpE/FGL0S99kPJ3nwddFt7ZfhuFTrznxD4O
 XcGmRnnL5aRgRk2VENrLfz6VxzeQ2cdvBvRwaXcRaHJV8cIjo0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 19 Mar 2018, Junio C Hamano wrote:

> Joseph Strauss <josephst@bhphoto.com> writes:
> 
> > I found the following erroneous behavior with "git rebase -p".
> >
> > My current version is git version 2.16.2.windows.1
> >
> > I made an example at GitHub, https://github.com/jkstrauss/git-bug/
> >
> > There seem to be two problems when rebasing merge commits with git rebase -p :
> >   1. All lines of merge commits' messages get collapse into a single line.
> >   2. When an asterisk is present in the middle of the line it gets replaced with the file names of the current directory.
> 
> I suspect that this has already been independently discovered
> (twice) and corrected with
> 
> https://public-inbox.org/git/20180208204241.19324-1-gregory.herrero@oracle.com/
> 
> and is included in v2.17-rc0 (and later ;-).

As it is included in v2.17.0-rc0, Joseph, could you verify that the
version at

https://github.com/git-for-windows/git/releases/tag/v2.17.0-rc0.windows.1

fixes this issue for you?

Thanks,
Johannes
