Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F129920988
	for <e@80x24.org>; Mon, 17 Oct 2016 10:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934553AbcJQKq2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 06:46:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:51956 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932270AbcJQKq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 06:46:27 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEWkb-1cBjXh425R-00Fkjz; Mon, 17 Oct 2016 12:46:21
 +0200
Date:   Mon, 17 Oct 2016 12:46:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
In-Reply-To: <CACsJy8BBLcZvB1FswcEKS1KgvjMjo_uaVqOTgjmMJkjnmoye+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1610171241240.197091@virtualbox>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com> <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com> <alpine.DEB.2.20.1610171056170.197091@virtualbox> <CACsJy8BBLcZvB1FswcEKS1KgvjMjo_uaVqOTgjmMJkjnmoye+w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kfs2rmSx45l8p2Lm/nVPFgHMy/LugSC+FclXWe85ositRZFJZQb
 5jJtjefJM8N7LeDFJ47VFqZGiCXq6XTFTsa5qkwMD5DEbOi4yIDE/EkpbVtA+ZyuwW2kcQn
 0IXkviv9LIHDd798jFMhB3cptCVR98GSOgrKq9nJKVdtPuqtsYvchkG/ilBVlEaXHwxBnWa
 7iiytyI5+1ymSypjNdgZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a+DPtdh4AC0=:fo7rHD7+banyeCe2w9lR+4
 76QeZdq0xpSe8n4WLX/KbMy9CMW8tMEV8pQYQYpTQtEDj1Jpxce1t1YkZ92dDcfDHk3ziQF56
 eZ/w+6EgbNCJCTzTXyZOuPB17sZzi5IFTeIB1npbBt3r4FS4BWjzWhwEw3G7+GH1N8bvN+bgN
 lB6OU5iT7DfX4g5N9fbm4sFCX4NG99yTffpkbJ/6sfj/YRCa2wagZl9g3NBwXnZ67bHX5s6Wi
 n0FQtCn48FDPe6QYQd1qHwMT4p7LEVfg0EJL3seDhQ4tkWs81VqvkkVvcciVu5EbjyqfIJKh5
 JgDhaQCycojYgPHGv9dZlP03HTJIJBdfKjxEVSWYeSy6LXC2bE42bX+GMK6/hYPNMcSxla/dc
 1Tkx5S0IREl7xzNnuPUErSZULaoymwWxDXn4XmwFJ6xx49hLDl5PqNs8QzMN4ZbwpjwKbT3oV
 RRbwOEjcVmEP1KCweZzFkS3GBhnS7RNbg68Du92R2nDQj3qFGaioBiJluMopvAk0yMPp7+hCH
 6gsGLl0Bw9kOxJcG0NbHdT6IXAQY7fOpJZuHUd2t3/a2CtdhGHCfsWOhRQzn4uMWC3puY7fl3
 fXekBapUJ5m3O8g/tk4429clhwBvWOii9GCdORd/zw6loDpdJ+OcO8n6emggb2Q6HRGuRJeZJ
 um1LYXx3PiGWC0AeLk5Naig+7JDZPHSyhrv1qLrey9ri2lBBD1Kw9SwoMTI3X64CNwpAi0DXE
 dWy642XUzE8bAuxWlyLfo357phmE3X+8WhgmdVFZK2JBEoDAUhfOl5USHoO2EHFbBJxgscCkq
 Q+iHfNm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 17 Oct 2016, Duy Nguyen wrote:

> On Mon, Oct 17, 2016 at 3:57 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Stefan,
> >
> > On Sun, 16 Oct 2016, Stefan Beller wrote:
> >
> >> Conceptually I would prefer if we had a single switch that indicates a
> >> case insensitive FS.
> >
> > AFAIU Lars' use case is where the FS is *case sensitive*, but he still
> > needs the .gitattributes to be *case insensitive* because that file
> > originates from a developer with such a file system.
> >
> > Otherwise he would simply tack onto the core.ignoreCase flag.
> 
> That sounds to me like setting core.ignoreCase to true (on all devs'
> repo) would "solve" this.

It is good that you quoted this verb, because it does not solve things.
Instead, it would try to use the flag for two slightly incompatible
purposes at the same time.

The first (and so far, only) purpose is to tell Git that the current file
system is case insensitive.

The new purpose you described would be to tell Git that the *user* does
not care about the file names' case, even if the file system does.

I do not think that this leads to a better situation than before. Instead,
I am convinced that it will cause new and sometimes "entertaining"
problems because you can no longer discern between those two purposes
based on core.ignoreCase, you would have to teach Git to test every single
time whether the file system is case-sensitive or not.

Needless to say, I'd rather not see that happening. Many users, including
my colleagues and myself, rely on Git being a rock solid piece of
software, and that change would make it less so.

Ciao,
Dscho
