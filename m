Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067A31FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbdEPUM2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:12:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:52614 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbdEPUM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:12:26 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1dgjip2jC8-00eryh; Tue, 16
 May 2017 22:12:11 +0200
Date:   Tue, 16 May 2017 22:12:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
In-Reply-To: <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705162211320.3610@virtualbox>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com> <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net> <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net> <20170516171540.GG79147@google.com> <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net> <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oWnIM32tzuLEPqQ/z3d3kpTsnWyhmG4gz2Srnw9RkCVIW0LG9J7
 kwm7R4QfKv2kWtXuN48/hSWdrGSyt58CIMx2ukOkVVK70r5zy4eLbEzYIglDsdAKcM88Yjd
 KcBXGsaiGnyvfr1irMDPBHEbItaWH4dUWeZrxQxGs5sjRFwS5miZqjLFjgDxxdXQtJrJWme
 bnHs2poq2dDYLX4mfQsDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X4z5jkfHuCs=:l9yEz5cOxmeQhRIAOqe1t7
 5vhOnlp2qoyD3zorsoZGMlVcC5uXhpCD9SzrUwuUvPMtDB9U6iE30asOBB89C0Lohwa5CD8mz
 7pprJFQHI9bo020K4jUWAUd7IKJ6P0lmzknaE/x92M86cM8YeyrmJWF5BIauEiIXGFOIA8xSC
 5H95I6Whc1SoCibA90t69C8UP/LdpfUdbVZ/HJknwouPGeXOcwS8uq75BsIIn/danA1ak8ZZQ
 +jy5u+moW6m0Isldax7wOJajVRljKrGOYHcOM/1WtlfKV5pFkzjl+21CUCeoqr/SVxBOm6AfW
 X2ow3dh95iq829dD6MJDmD0Jb6gMshYi2bzNfELWmzBcNbKs9tvQvWUuP0C0JlLfHF/R9z/QY
 zroAtWOJTb9LvGRqh/MEsI4buv/6aXPiL4mEw44w8yd8qVVna0px9ssknywoC7BJt9pyKRlHs
 mMRwg6fj8P/hkkcwm6X4359eB0GNYVP9C1mM5JJHWH/gAhSsnILtDYorvuAzzWnfmIZT3tX8I
 ufs80FYWPhjmFXxIBDbM+4WgE2al0YY+J9GMmPBlcZ6xgt+FD27YlZjDZKWKEl+GPA2G9M5lP
 qM6WwVJ4vh8oKWOkVaJBmaEhi1XiWtCV30lck4fD7TPWelPrhmMj+89UM/OhjZ6FhjF9nQW/F
 nA5d12UuM7DkjyOfxdwycLLOw4s8itNdb3nVaQes3Dy6Wo5CRIOe0sjkxlcnksXu8J824vSWC
 UaPkU+Op8XEDku6sYdpmZY3t8kPfDlDKA/jpLvuz8iL06QV7JCDmweB69ms9FehE6RSNImXyK
 uhs7Jma
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

On Tue, 16 May 2017, Linus Torvalds wrote:

> On Tue, May 16, 2017 at 10:23 AM, Jeff King <peff@peff.net> wrote:
> >
> > I think the logic here would be more like:
> >
> >   1. During prepare_shell_cmd(), even if we optimize out the shell call,
> >      still prepare a fallback argv (since we can't allocate memory
> >      post-fork).
> >
> >   2. In the forked child, if we get ENOENT from exec and cmd->use_shell
> >      is set, then exec the fallback shell argv instead. Propagate its
> >      results, even if it's 127.
> >
> > That still means we'd prefer a $PATH copy of a command to its shell
> > builtin variant, but that can't be helped (and I kind of doubt anybody
> > would care too much).
> 
> I think it would be better to just
> 
>  (a) get rid of the magic strcspn() entirely
> 
>  (b) make the 'can we optimize this' test be simply just looking up
> 'argv[0]' in $PATH

What about

	ABC=1 my-executable my-arg

Ciao,
Dscho
