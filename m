Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C445E1F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 10:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932402AbdHYK7Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 06:59:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:58475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932365AbdHYK7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 06:59:06 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomuB-1dJaPW0SLL-00glau; Fri, 25
 Aug 2017 12:58:53 +0200
Date:   Fri, 25 Aug 2017 12:58:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Mike Hommey <mh@glandium.org>
cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        git-for-windows@googlegroups.com
Subject: Re: [git-for-windows] Re: Revision resolution for remote-helpers?
In-Reply-To: <20170824082350.6ed6jqkn6aeylvnv@glandium.org>
Message-ID: <alpine.DEB.2.21.1.1708251258080.7424@virtualbox>
References: <20170818064208.plkppke7efpucuwm@glandium.org> <20170818220637.GN13924@aiede.mtv.corp.google.com> <20170818221754.3rbh35aewj5xnu4z@glandium.org> <20170818223323.GO13924@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1708222212320.19382@virtualbox>
 <20170824082350.6ed6jqkn6aeylvnv@glandium.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/6YsHk+oB3daNk/RKfHBKn6RTNBbTST4AhLa3zEsRd9LzFl1J4Y
 i3BCYSMhURWH7tTE3vpQgAhnwhrIJEkKGE6JWyBWhw0w+2zj4l/5DZhZ4BBu1ooTO67BTZP
 SXbcL1tpiMnYDaBGWzmuKpOHzFz/qUUu9vpozam+qoqxnTt5jKc/z2Q2GB0vzgBIgv2mEW3
 DPIHSdMPqu6Gbs7Tn/rqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sxC2XrqkHAc=:0tTzTndHSFl2zIq4/7bEWA
 Cf6vQn9/em9sKcPFYVaCxxPXGS/qh0PPETnn2cjyrYme5LdWRGYo5tjpWr/+gHJa8nl8KrG01
 hmwitZ0O6g4KU9JfbzlJWe5IdGWNqMwER1vTMX0jGXYRTy9RGfcT3I1/eORYAM6MUjFFc6/X0
 Jn8n58O62KQbbgwPRMSUpgomyDW82H8AMgmR3ebR5ZvHhiXfRGoSUqkf7yYnDhvNnWDn9d2tv
 bpypCYCggWBM0xDNeHepbJZp3x/NvyoaP0BMLb/9jrOW2KxP00ilKrWMrp+uDDrD3JHpKnuK8
 2f4/rtuv5Tdx1DLVfnUcHciIaEmGsgaQfQpPsR9R7Z7cPo1P3w8t1Uvmx5NcjHVZafdsFVY3x
 V+TXhCAn+47XBOz7mCGUgcX2R37IU41W6KTOvNhiKenjWsjML72g5PSYd5QH28jm6h2xbZVQW
 Z4AFy9LDoyeGTxuqAI6aPyZ91cOGQU4zqlgIjT7dJ+byULaZ6l19GmHTHo7ik5YYWD/ZzMcBT
 mdoYvuf3/+1sNOWkc+O/dSOxl9O3u14NICLVLSgsAKnR6EaYfiKPZ+rjUmhJfVcAgTMBmrMzK
 Q3fCrzC4WDenyasfsEKNt/fCINjnuOUZQqeT8IJKrzFhupkjYaeUICr1gB1MGWZ5oyJJW8UWh
 jIiZVOpZh/mnrldHAVWYAGanieycx/XfNbxiS45TnmXpWNabSsI4Tz/jlNp5sbk77pef1eGqc
 EjR5ozgcjP564D5D6ToMDVvjccUcQsyH7cgbMG2ORa/hKjCh0rfYcbijS5xvnLwh1kbhxlmFn
 LAE8UBkleV2ZYE+HAwkjf1qkPhAdaCilcCQKvrkvWJWb+QmesI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Thu, 24 Aug 2017, Mike Hommey wrote:

> On Tue, Aug 22, 2017 at 10:15:20PM +0200, Johannes Schindelin wrote:
> > 
> > On Fri, 18 Aug 2017, Jonathan Nieder wrote:
> > 
> > > Mike Hommey wrote[1]:
> > > > On Fri, Aug 18, 2017 at 03:06:37PM -0700, Jonathan Nieder wrote:
> > > >> Mike Hommey wrote:
> > > 
> > > >>> The reason for the <helper>:: prefix is that it matches the <helper>::
> > > >>> prefix used for remote helpers.
> > > >>>
> > > >>> Now, there are a few caveats:
> > > [...]
> > > >>> - msys likes to completely fuck up command lines when they contain ::.
> > > >>>   For remote helpers, the alternative that works is
> > > >>>   <helper>://<host>/etc.
> > > >>
> > > >> Hm --- is there a bug already open about this (e.g. in the Git for
> > > >> Windows project or in msys) where I can read more?
> > > >
> > > > It's entirely an msys problem. Msys has weird rules to translate between
> > > > unix paths and windows paths on the command line, and botches everything
> > > > as a consequence. That's by "design".
> > > >
> > > > http://www.mingw.org/wiki/Posix_path_conversion
> > > >
> > > > (Particularly, see the last two entries)
> > > >
> > > > That only happens when calling native Windows programs from a msys
> > > > shell.
> > > 
> > > Cc-ing the Git for Windows mailing list as an FYI.
> > > 
> > > I have faint memories that some developers on that project have had to
> > > delve deep into Msys path modification rules.  It's possible they can
> > > give us advice (e.g. about <helper>::<url> having been a bad choice of
> > > syntax in the first place :)).
> > 
> > I think it is safe to assume that :: is not part of any Unix-y path. That
> > is why the MSYS2 runtime does not try to play games with it by converting
> > it to a Windows path.
> > 
> > (And indeed, I just tested this, an argument of the form
> > "a::file://b/x/y/z" is not converted to a "Windows path")
> 
> Note that there are people out there using msys, *and* git for windows,
> although I don't know if such people exist outside Mozilla.

Note that I am maintainer of Git for Windows, not of any setup that uses
MSys. Please do not even try to put more stuff on my plate.

Thanks,
Johannes
