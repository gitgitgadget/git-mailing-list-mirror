Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE42D1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbcHILsh (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 07:48:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:60229 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbcHILsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 07:48:36 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LmK3e-1ayIjL2UCo-00ZyOO; Tue, 09 Aug 2016 13:48:17
 +0200
Date:	Tue, 9 Aug 2016 13:48:14 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <xmqqvazbfa5v.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608091342190.5786@virtualbox>
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <alpine.DEB.2.20.1608050925240.5786@virtualbox> <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
 <alpine.DEB.2.20.1608061045240.5786@virtualbox> <xmqq8tw9iw7i.fsf@gitster.mtv.corp.google.com> <20160806214325.GA9484@starla> <alpine.DEB.2.20.1608071039410.5786@virtualbox> <xmqqvazbfa5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U7fYkSe1zkNZIHvMPkLpY8vnuln2ERktVbXglA7XCW+Rbh4pngn
 tSceTTfh00AzItH7AtCNkxaMpIfZMn5lUSjqeeGteaOrurnHkO3e3H+WGRFjh3zo+NV4wek
 hP2w5aJkKoNenDuaWsy8LhCN/O+07nCazlELtOlsqNQvlxwtL4mjSxIBc9j1gLc9Mr2hkLZ
 9DzAtkTTK4I2Ie+o0EZBg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Q00KZeajrY4=:z8IUEbRpW/lxeuYPfc+mov
 29ZC8Koh9Db55HVMxR+T/ta/V+f+NBoePXidkeCQjx/IqB8bCxYBVrqg3+4MTFt6RIKk5BYUg
 0VAMW4aTQhWNJNJFzso90JWiUHU6fZ6fG8GSzDidYMzS9cE2HciXVx5mFHbop9gksSWRen0XZ
 e+gaMz/9Vy8xDU8eBbv/Kk9V00XTCgYeabma9L9Cvj9uloKPJID5rHDgqph2zhzBqGl5Hf4ha
 G3ca5D/UShES43whY7WgbRTmV6L8b520XGHkQyxFxid0FEeivdr1W2ZwmB+oFWzh3bKEMFArI
 +OyjIr0CR71S5JK1FNJIj4+2HvY0Waq5nC9XBmDgvh+insU+6hIXXg+jLY5MBVNtICc947ld+
 0D616kpOnOCSor5xDRbil0ov3Gdi26NR74BCwPcpSCk5ot+bD0cQaq1KPXPchneIAzlnnbl+l
 VhxgGMnhVOldVKd9HL6goLvPckCsftwYuI8aSbJTNw9Z1nECip1dEBrWvNxu3dgyCvK/MzUh2
 ArwQ4L4NTjZlAX6obkLd20mDw9TIRpp68jl5hIIIHMn3gUR6KZ+ERBx0bdM+mGM1XDPL0IK9y
 PBWfBLo37rR7xvDRboXN7yQyd/oGElMCe62JGoRU/EM3wRedlKJyf3C3wAR9YQyDz5+PI844L
 zxe2dbspX62Sbqe3aS2nBi59vwq8UHR3SM39oH6yeOR8rXObrLBZD+VRADVJqZeo7NmCAonu3
 MueEg7y6hUAk8mx9Yu8PNi3sWzVtEA51HNkd7G7iCrYJ1WvzE6B4S64dEkyYMKP3mO41pe04l
 S+K5OGv
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 8 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I think you both got it wrong. The original citizens were the mail
> > clients that allowed you to communicate with other human beings.
> > ... It is our usage to transport machine-readable content (and not
> > as an attachment!) that is the intruder.
> 
> It is not "its is our usage".
> 
> You are too young to remember or too old to remember the history, or
> you are knowingly distorting it.  The original users of "patch" and
> "diff" expected that e-mail to be a medium to safely exchange
> changes to programs among themselves.

If you are saying that transporting patches via email was the original
purpose of email, then it is not exactly I who is misremembering history.

But that is not what you meant, I believe. You probably wanted to point
out that the Git developers are not the first ones to abuse the medium
known as email that way. And you are correct, of course. And I never
claimed anything else. I just said that the problem is our usage of emails
as a means to transport byte-exact content intended primarily to be
consumed by a program instead of a human. It does not matter whether
others did that before us. It is the problem we face right now, that is
the important part of my message.

And even if it seems as if you are eagerly defending this system, I do not
believe even a microsecond that you think it is a good system. I believe
that you, too, would welcome a better review/contribution system that is
easier to use, more welcoming to new users, less error-prone and less
time-wasting than the current, email-based one, just like you jumped on
Git as a better SCM when it came around, from whatever inadequate system
you came from.

Ciao,
Dscho
