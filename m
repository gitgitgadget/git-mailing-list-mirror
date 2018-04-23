Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30831F404
	for <e@80x24.org>; Mon, 23 Apr 2018 11:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754614AbeDWLHv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 07:07:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:39545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754449AbeDWLHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 07:07:50 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqE5k-1eWoex3HUW-00dlzz; Mon, 23
 Apr 2018 13:07:47 +0200
Date:   Mon, 23 Apr 2018 13:07:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     git@vger.kernel.org
Subject: Re: Fw: New Defects reported by Coverity Scan for git [argv_array:
 offer to split a string by whitespace]
In-Reply-To: <04F34371EF174E1F8E6E762D1BCA6C4F@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804231307090.15174@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <04F34371EF174E1F8E6E762D1BCA6C4F@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yRDJr3yZN3zMhSNeK4DIFFUopWKcQNaGaHTWCbGzbu0PiO491++
 AfE+tUHA6o36hCNt9qd+ynVccoG+tx22Lch5I+2xvOy2a3qIEavw01ZjGZTewNO69dbxrmY
 kKf7TTCMniE76/KbcttILcwQFIh4n82FyuMBAJy5VLjCI4DvQXseIJmSa3my5Vl3WVOcqU3
 cOMpXdQjynriGIfKuNRwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hy9pEJcY+7Y=:mk6E1I/I0EmoyO7OowihJq
 gFwRxc3j3HHs5/lQMLoHJhN/S3QSKqZX962NiumzkmmWrufDs0f9E8oxUGVeGtAs4wAEMYWvV
 Bthd8/ixPgK41yqauQG+VsTNhu8VDp5PyEfkC07+v+g3uY8Vo8QrtStP20Tpc4HPLrWQKiYns
 MfbG9K3Cvo+aJAFcmlYhkdhsvA2TOO6lIttKsSwBzQUNJzo0EUcTpdqGRuHsbidgejigw0cTq
 3I/oVn7P8eRGeUlMoOxLDOjtUPHcTlwvrvdheaHa9sy6BnCIuruq0IXFjvTgc88SaD01FOPH8
 9MqgzSQ+p2p0sMxIMGitxpWg1ulZOFZBZOD5bW1vn/FIt5++uR3UIOtRQMQU2sRk90JfbkQUN
 002r8rgpYF5eFEUEQ2kvZjKARsr01WXVZG8tl7FDGTKcgCa6xX9zaqEBlF5vZLoTTNsCwFNZF
 kixZ1FXJLBvEg9pMvMAn87mfBZc+mEBPqk74843oKFB7tGULTQJfMs4Nk4MT0Op6UXSYYFGws
 Q6f9mXqcTKqJqfaNFhWJlee1S9DTp0cBP6onPZHTMLw/tiZFAWIC6Nhm9JXe7CCP1EewJIuKO
 UHOp/a68I+GVx4bmgibrkLmAJG713PQXW3Xk8Cyv0+3sGxDuGD9hkTTy6JJXFAP66ds0v6AWN
 JoVRfSacPVkCL5bzuyo72Haor+NkE1TO9f09rCpnCZEI44lzFScxy8mAwq4yu1XFu3FEJsRyS
 mXtQnkCVA1m3H4hohUlCUg/3/n7zOIcbTrBkf5emy+/paxmkb3v+V+1pR80lai3HCOpLIq44B
 u5dRDBOyszLiQ3FysUMWfo5e3DhrumfMiUJCh7feDsPtAgEOCs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> is this part of your series "argv_array: offer to split a string by
> whitespace"?
> 
> https://public-inbox.org/git/CAPig+cTDbTtUeFYmkNtM773EBgE14Tpic4g4XEFuSVwSypdMjw@mail.gmail.com/
> 
> ----- Original Message ----- From: <scan-admin@coverity.com>
> Sent: Saturday, April 21, 2018 10:53 AM
> Subject: New Defects reported by Coverity Scan for git
> 
> > New defect(s) Reported-by: Coverity Scan
> > Showing 1 of 1 defect(s)
> >
> >
> > ** CID 1434982:  Memory - corruptions  (OVERRUN)
> >
> >
> > ________________________________________________________________________________________________________
> > *** CID 1434982:  Memory - corruptions  (OVERRUN)
> > /builtin/replace.c: 475 in convert_graft_file()
> > 469
> > 470     while (strbuf_getline(&buf, fp) != EOF) {
> > 471     if (*buf.buf == '#')
> > 472     continue;
> > 473
> > 474     argv_array_split(&args, buf.buf);
> > > > >     CID 1434982:  Memory - corruptions  (OVERRUN)
> > > > >     Overrunning buffer pointed to by "args.argv" of 8 bytes by passing
> > > > > it to a function which accesses it at byte offset 8.
> > 475     if (args.argc && create_graft(args.argc, args.argv, force))
> > 476     strbuf_addf(&err, "\n\t%s", buf.buf);
> > 477     argv_array_clear(&args);
> > 478     }
> > 479
> > 480     strbuf_release(&buf);

Yes, it is. Coverity has problems to figure out what is really happening
here, and it has the exact same problems with strbufs.

We initialize both of these structs using static initializers, with
specific, empty arrays. When we need to reallocate, we figure out that the
empty array was still there and replace it with a NULL so we can realloc.
So there is no buffer overrun, but Coverity cannot figure that out, and as
much as I tried, I could not come up with a "template" to shut up
Coverity.

Ciao,
Dscho
