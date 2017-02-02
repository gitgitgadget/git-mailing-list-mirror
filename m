Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AF11FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 12:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdBBMdu (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 07:33:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:50735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdBBMdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 07:33:49 -0500
Received: from virtualbox ([217.64.244.213]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaGfK-1cBivb22iE-00m4bF; Thu, 02
 Feb 2017 13:33:41 +0100
Date:   Thu, 2 Feb 2017 13:33:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
In-Reply-To: <alpine.DEB.2.20.1702021223320.3496@virtualbox>
Message-ID: <alpine.DEB.2.20.1702021330040.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com> <alpine.DEB.2.20.1702021015160.3496@virtualbox> <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com> <alpine.DEB.2.20.1702021043110.3496@virtualbox> <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
 <alpine.DEB.2.20.1702021136210.3496@virtualbox> <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com> <alpine.DEB.2.20.1702021223320.3496@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g2fH3GZDkQX00ev3PpClL4obmr32WoAH7VtHRafs5ta6DdkUfvo
 +WXX62ev4psfNrEag+wiD4kIChAlY7eB418WY59tTK0RSAaoIiNkDLH7tIjG0WAounegTME
 3z/AHLaReB3j9c8eJJUB4Cu8Baw0wA7qp85xtfwC4EhcjDEj5MSaHpM2ZTZgqN5PzfX0H8S
 AAXYcQ2Nbpks+Eznz8fDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jgVdMlXdz9w=:CWirDPb6Jgc3mjopglnVtO
 gz0Hq3bbOBavzmG3sbXgIC3xbj2cjnO94LdyLQLrmrxcgVcl/twdHW4fiqhGnW1esCvjcriNP
 ExTdPy+Ro++oWbkX860B7nWSK5nY6LAuohWRh8FQYO96+C3PpCeXhfWsnYJbKlKz1apoQ19pD
 huOjbVUJNDfS5qqWJ7P6ZKNs5pJpSMvFc+iti1RWFT1HWtLuouV1zL9Wfnp8eluf3c5ISrVm1
 X49biGrO4ME6Nv6PRQNlxcsmOtQ9gbsT//vr1kEgRzZzH/Xhg9B24x5uCqjQMX3k9PZAbaM+N
 xfTMKSFiJPx/RnZq3him6HxmBMCB9AIzCa4jzzgMidhLi2heMc2CujUV5LnH813MA7qJleV2H
 b4cr1mpeQzFXTPUqn7O5s+plHe3hXnD1I/eacK02d5kSJU/9KuPFOWY5D1Uvq5xzYcTpmMR02
 XiQva4SM2nfsuW5nT2bmxPWU5KEkTFLbfc2Udwi36WdbtzEOtTvH4I/0YViqPrei2t3u2m6j+
 4jwPeHMUo0WQPeZUOdh/t8fJSp5BI4WZMkOxEOLlOAaT+KcHhx1v09YCDDJshLYgyY6i1VJVR
 psz0BKm5bLVvhzuNWmn4p1z+8fmS7EY2VG9igRWyUztPD2MrLBtXwUo9CsXB/HRrS5TjxEz+Z
 C3HSZ6e81vO2R4hePHfvRKGet48kzP5TuuAZpJQMpmgHz8w1xs0X3/kYJ2F+IAfu+2waWFMSP
 f4lG1hsn7lOp5Tyy3cbehxE/oSsZK1WpCBMXEqqDdHsAhxYH7QfWjar1/Uoc6T4t3lMJjT423
 EmpIBWDkjqSAbSgYZzydNND3Bx1V7KRUDB3e16XdFSL2Td3HR0Tmmsjs18sNWh7jmw0vXxnDv
 R+F6VE3pz0hAbA9bKovxFeJOmsEU28EWuD2c/x7UZRnmpzEKkXdmNk3D46BssfxN4yvBzvgIa
 +EDF+ndbWteQxlFPEQe0QZ6lG3HAAhlvOjYCYBozZgdD6YVDpTZGg9hQf0oXtHsB4Yn9FwfD2
 0Q2DBb2t49f02QdQBT/YbJmlOgXZIo+jz2IpF25ASQvqGSvkW/J7iX55V96BS3VICA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 2 Feb 2017, Johannes Schindelin wrote:

> Hi Duy,
> 
> On Thu, 2 Feb 2017, Duy Nguyen wrote:
> 
> > On Thu, Feb 2, 2017 at 5:37 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Thu, 2 Feb 2017, Duy Nguyen wrote:
> > >
> > >> You meant this one [1]? There is nothing substantial since then.
> > >>
> > >> [1] https://public-inbox.org/git/%3C20160601104519.16563-1-pclouds@gmail.com%3E/
> > 
> > I  could rebase and clean it up a bit if you need it, but I don't
> > think it'll end up in 'pu' or anywhere near since Junio wanted a
> > cleaner approach [1]. That means (as far as I can see) a lot more work
> > around refs store and backend area before it's ready to handle "get
> > refs from this worktree store" (or "get refs from every reachable
> > stores").
> > 
> > [1] https://public-inbox.org/git/xmqqshwwzyee.fsf@gitster.mtv.corp.google.com/

Given that
https://public-inbox.org/git/xmqqy46ntrhk.fsf@gitster.mtv.corp.google.com/
seems to have expected something to happen within a reasonable time frame,
and that 8 months is substantially longer than a reasonable time frame, I
am not sure that that position can still be defended.

Also, the more important reply was Peff's reply that suggested that the
proposed fix was incomplete, as it misses --unpack-unreachable:
https://public-inbox.org/git/20160601160143.GA9219@sigill.intra.peff.net/

Ciao,
Johannes
