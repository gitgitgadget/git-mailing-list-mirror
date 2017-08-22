Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E348C1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdHVUPf (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:15:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:53959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbdHVUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:15:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1dnqcW1iMv-00EfVF; Tue, 22
 Aug 2017 22:15:21 +0200
Date:   Tue, 22 Aug 2017 22:15:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        git-for-windows@googlegroups.com
Subject: Re: [git-for-windows] Re: Revision resolution for remote-helpers?
In-Reply-To: <20170818223323.GO13924@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1708222212320.19382@virtualbox>
References: <20170818064208.plkppke7efpucuwm@glandium.org> <20170818220637.GN13924@aiede.mtv.corp.google.com> <20170818221754.3rbh35aewj5xnu4z@glandium.org> <20170818223323.GO13924@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CM/I1gegz8ucSbEm1hu32rzE7oqQB1XKSHUVvfQmJcrwYyneBNp
 EdUhqKCUa3afpquXVsKys9kZ8nSAryWydlicMuFb36CEdahzQXVHCFfuqgHFuED27KTfLZO
 nZEYm4GuZ0BWvVvWOdbwPs5tE3U2PGISUrpP534xvmGJKRq1hEbAK+hQ/l7TS5TvFOhE0yW
 49Aek/8jtWKj4oM5viuOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KcSngxLGOG0=:t2dH7+AzjnTo7tlcKYEowL
 fzV4d6MvGGk7tCpY5PTDA/GOBsAc7id20AxUK5n7cy1u2JwNq5UNFynEIsMhn8x7zua9d0QpT
 zp327tR7EEKcQXvrYuEygDB8jtsYioy3RP1qUNdKIqptYgqBJ1yi08FSyKg2fM732a2WcI2hQ
 bybdTVZ9Nrlth77hLU8O0xfiX1ZjruSfq8otND3yMH5DiLFPLujVfDeJemTYaPviWD6OzdaN9
 sQ2nedLe1LQoFRVNcsmyW44SGoRQx5lBQKb6CDAn6Bx/JY/zafAYUSSr4K1LmtiKoweMRhWqN
 Jr14tLTcoaewMQFfSWZUDTrSjCtczRLNf+1Ae40xeoZ0hbzA+jS4b6FmDrQLD7bka8ILwUKDf
 RzXHa6+py+V2YR2w4MlZstPaJrNhBbdCmNZoICyrEOFKlKFPblHa3f2A1ri6o8HjeIDwwDTbF
 fCvNCKrp/D86SeKK/T4KQE/vnQpz4dJhmK/cyvQ+yxkVJOygsSMx7mXFero0H9a6q1nwYL8n6
 dn0Qq3ziX+NVcGxMafHzvh0SvRiEVPbVg1/obhkp7mvNk2/44wRDs5/VMgDisNYUT6ENzhHv2
 lU697qf0zpbc4bfyyhT2O8TKG+rMwtPi+8OcEJEbFypNuu3C32DeG/tK7e/4kwjQWn8MPOhEQ
 9Zrcx8MDbdzweqttbIb5f/JlD0rdmRST/fWqYy7ob6x5waenmKSRORFWky7GA9n8UIaoLiW7q
 Aphm+YEaNHEQU8aRynpKwvh4eWljmedE4P2tuMjJaMuQWsShA0zl3J0FKlq5H+ypbzf9MM1gm
 lWy0/+TIcR2nkFK4cblaG6sr4WLtjYAkybEzGl9M8Zxs43DRDI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 18 Aug 2017, Jonathan Nieder wrote:

> Mike Hommey wrote[1]:
> > On Fri, Aug 18, 2017 at 03:06:37PM -0700, Jonathan Nieder wrote:
> >> Mike Hommey wrote:
> 
> >>> The reason for the <helper>:: prefix is that it matches the <helper>::
> >>> prefix used for remote helpers.
> >>>
> >>> Now, there are a few caveats:
> [...]
> >>> - msys likes to completely fuck up command lines when they contain ::.
> >>>   For remote helpers, the alternative that works is
> >>>   <helper>://<host>/etc.
> >>
> >> Hm --- is there a bug already open about this (e.g. in the Git for
> >> Windows project or in msys) where I can read more?
> >
> > It's entirely an msys problem. Msys has weird rules to translate between
> > unix paths and windows paths on the command line, and botches everything
> > as a consequence. That's by "design".
> >
> > http://www.mingw.org/wiki/Posix_path_conversion
> >
> > (Particularly, see the last two entries)
> >
> > That only happens when calling native Windows programs from a msys
> > shell.
> 
> Cc-ing the Git for Windows mailing list as an FYI.
> 
> I have faint memories that some developers on that project have had to
> delve deep into Msys path modification rules.  It's possible they can
> give us advice (e.g. about <helper>::<url> having been a bad choice of
> syntax in the first place :)).

I think it is safe to assume that :: is not part of any Unix-y path. That
is why the MSYS2 runtime does not try to play games with it by converting
it to a Windows path.

(And indeed, I just tested this, an argument of the form
"a::file://b/x/y/z" is not converted to a "Windows path")

Ciao,
Dscho
