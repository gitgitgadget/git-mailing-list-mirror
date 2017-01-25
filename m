Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A7C1F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdAYKhO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 05:37:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:63291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdAYKhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 05:37:13 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7im-1cboau27fQ-005YZO; Wed, 25
 Jan 2017 11:36:52 +0100
Date:   Wed, 25 Jan 2017 11:36:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c:
 mark a file-local symbol with static
In-Reply-To: <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701251135090.3469@virtualbox>
References: <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com> <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net> <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com> <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
 <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net> <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com> <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net> <20170122052608.tpr5pihfgafhoynj@gmail.com> <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com> <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u483s3q4XIrXfxy7zIPAyoUytdSjznzstpTZS73Xn8Xe47zrbps
 bcorUCIqYyKsBo/X8Q5UsXIhMjmUoSmnWkXa30yszrkhiX95yU190oNgHStY46Nl5b/yJgR
 fshDKvpA3KUR8MiPizXVVY5EknEeI0MjSa9Zj9lwsm5boKpBQl5ewnV1BCRjKAXs6ugROlQ
 qLj6WYwNbjlhiyJ/CWwPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v3Sv5QaXgKk=:M2e39RxvzpRtJB74n0k3i3
 UaM6cxn+0KDAkv8PSJ7ifTUTR+k8B7c2ekp/xWAZ3dnkxj6MyGLE11mPn3D7bACX6O4oG9EaL
 9wLc6tuM752be+BII1v2JXHQ5kfTRC0SyZcQlOS5WmsRKljx297NyGWLBfoiYLfv76lkDHVa+
 9aKNIQ7vOt0WOrfrMgVNewOCItvA4HPRG1eb3XjwiSIKKYxde9/IkCHK/Y+nJVSnFRZKQAKSR
 1R7CAafuMuY+QP305Dr2Fsp1KoNE1KX8iZ4xZgYGwQs2NVpKvCcboftnLBPuTuLwTZ6BUIzld
 KlzEAD0XfGzPClk4l0WMFUrQDdTbVCT4GIU6zQ/o5totMIccSmp7kwU0cWWbV214QstNvOPQn
 B+e/LR6sUgM0DyGD0td56TAUYcMSiemvMVfTytjyZOy9SZjNre0pd5gS38nC9zcUwZqUp0pkh
 QutfcOW68lFamXyHy7afUwuwkT2H3zqyqu/9Cq8QNDbISmjCSgt/9AMJ9zljzNtkSLuqNFXAB
 IxxLNAZaNz5RgVVmEAt7unvRDWQEqulDRUQD7jUnmCd7uKYlfC3Qd9UqwlS2B5iIKRxn/DY8s
 XhSXIcefJokC4H9PzQbx54vGcZruf2AqF339v/6F6ULwveu1hWMg+NUwV8+X0LA/Uqq9uEK0f
 OYxpxnrBIIQm+QHJSUxVW/ON3wR9Zj4cUEsQl8WuDEpVA3Z5I4ulBW8UaAEUQl+Py6q2kj9ac
 f7kRRKDdjTRTNW17FayWQLp3/XSgpffARr9qgGrjbjLpIJFZMA4qqL3wsRztb8U1X4I7R1b6Z
 IGFTls1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 24 Jan 2017, Jeff King wrote:

> On Tue, Jan 24, 2017 at 01:52:13PM -0800, Junio C Hamano wrote:
> 
> > > I dunno. As ugly as the "%s" thing is in the source, at least it
> > > doesn't change the output. Not that an extra space is the end of the
> > > world, but it seems like it's letting the problem escape from the
> > > source code.
> > >
> > > Do people still care about resolving this? -Wno-format-zero-length
> > > is in the DEVELOPER options. It wasn't clear to me if that was
> > > sufficient, or if we're going to get a bunch of reports from people
> > > that need to be directed to the right compiler options.
> > 
> > I view both as ugly, but probably "%s", "" is lessor of the two evils.
> > 
> > Perhaps
> > 
> > 	#define JUST_SHOW_EMPTY_LINE "%s", ""
> > 
> > 		...
> > 		warning(JUST_SHOW_EMPTY_LINE);
> >                 ...
> > 
> > or something silly like that?
> 
> Gross, but at least it's self documenting. :)
> 
> I guess a less horrible version of that is:
> 
>   static inline warning_blank_line(void)
>   {
> 	warning("%s", "");
>   }
> 
> We'd potentially need a matching one for error(), but at last it avoids
> macro trickery.

I fail to see how this function, or this definition, makes the code better
than simply calling `warning("%s", "");` and be done with it.

Ciao,
Johannes
