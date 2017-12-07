Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0239620954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdLGVsM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:48:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:55613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdLGVsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:48:10 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LejNC-1er7r63d0w-00qVGS; Thu, 07
 Dec 2017 22:47:59 +0100
Date:   Thu, 7 Dec 2017 22:47:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
In-Reply-To: <CAGZ79kbDevUjjAzvfa-Un6=fnFZu+kLx7bF3vuheXZdxJWvaRw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712072244040.4318@virtualbox>
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de> <20171130030727.GA24732@sigill.intra.peff.net> <xmqqindojrw1.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbDevUjjAzvfa-Un6=fnFZu+kLx7bF3vuheXZdxJWvaRw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TtLEBufxlYaCqRkXh+0GG5V6myDqWl2126RbfDEpOgD7MtNSaj6
 FIFbhv7qVPOngg0Nj0DxgOLXouQVnOpbgjsu3h4Gt/ILhzf9JQBseYDbmZirYHRk8yeWSRy
 jLyBTk+1HlbhjlOi+l9IrC2gdQPEQInkBj++0I8Rn+tLj2+tO2pBm/o6ZlN52Ul+Ogk5b19
 joIZbDUuxH3maewo4uBuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vvTEJcm8RiM=:wXlrSxYqbAMUa77t/QnTyr
 h0ERKJfEpPM7wMzvvlof9NgrucT55ZmqloY8FPnZKR+YpsaZ5PtuQ2Oi7cBpkbQi+EcNd6OAT
 2VO9HCSu3bsTyR2Vo4DQTnRk0UHpKckhz0BSI7ATH1DM1lU+BJkQwOT0p5DeQJ0WWMHQMnCbx
 fbEfynQBhOZNkiztlaiPMvKSbzOQt480Sa2fqZaM9o6CFGB0XYiMy+UbZFT9kk4/hucjEOMyJ
 QopUYcEdopaeH+rUG7IOxqVCfeJBb9JpfLRUMFQrRGvxa/mvODNtxI3/4AKRxH4BJz00GMag6
 2dVRs1Zp/MMcHCVPXVFuNzRgmUSA6pM8N7NvLLjVCaURgr7TYtVUx3cpHQyNDQChtvDXQxeP4
 rQ1EvXhSlHHSj5Y2peZoQt03v+bV/xznGxTYAoTT+WCWUCGsEvIsQ8ePm6VfnkRx8Yd0ktGj0
 S92u+V9pGelSecOAZnfmGB+bDZA8TvPuZd31DbMk2vDBE4N4f66v/aVQ55g83GSOSg9APfjZx
 CMJuABxqmOiwPZcqUqKN5lmDz9dwZBwqPJWpPAE2sjcy09CIJLSuxOL9RXXf7GHsNZo666uKd
 6KrfUhsLa7z6dLdCUgeDBLUJfEehYB5FyOW3bxcjahwqY7puOedcR3TTxY/sB2idtLl1Wcwae
 O81PX6AlX9Gqnx7M7a+3fl0Q9imWlq6fIzp3HqdUmLj362T2gw3OiZVcZfJgxvC9HHpHUWaQ7
 W4UHhmy8GHj7Et/uOIjE/R/Lo6vAmw26+sPWvBvhFP09oa16H7+IvL5kReIzUVmX+hI1FNekR
 nlcomh/Mj07agQv4u5okufPyNEbsribyg++89jWye5pMy74m2E0Ue5bTq3hJU4x23LoVwbR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 4 Dec 2017, Stefan Beller wrote:

> On Sat, Dec 2, 2017 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> >> My second suggestion (which I'm on the fence about) is: would it better
> >> to just say "see t/helper/test-hashmap.c for a representative example?"
> 
> I think that may be better in the long run, indeed.

But we moved that example already out of the technical API documentation
into the hashmap.h file! Too much moving for my taste.

> > I also had the same thought.  It is rather unwieldy to ask people to
> > lift code from comment text, and it is also hard to maintain such a
> > commented out code to make sure it is up to date.
> >
> >> I'm all for code examples in documentation, but this one is quite
> >> complex. The code in test-hashmap.c is not much more complex, and is at
> >> least guaranteed to compile and run.
> >
> > Yup.  Exactly.
> >
> >> It doesn't show off how to combine a flex-array with a hashmap as
> >> well, but I'm not sure how important that is. So I could go either
> >> way.
> 
> We could add that example to the test helper as then we have a good (tested)
> example for that case, too.

What we could *also* do, and what would probably make *even more* sense,
is to simplify the example drastically, to a point where testing it in
test-hashmap is pointless, and where a reader can gather *very* quickly
what it takes to use the hashmap routines.

In any case, I would really like to see my patch applied first, as it is a
separate concern from what you gentle people talk about: I simply want
that incorrect documentation fixed. The earlier, the better.

Ciao,
Dscho
