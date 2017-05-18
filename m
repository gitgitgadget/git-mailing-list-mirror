Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F13E201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbdERTXg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:23:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:54827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933741AbdERTXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:23:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQRWm-1dYR0U3MD6-00Tmq1; Thu, 18
 May 2017 21:23:18 +0200
Date:   Thu, 18 May 2017 21:23:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a gitattributes
 problem
In-Reply-To: <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705182122430.3610@virtualbox>
References: <cover.1494861793.git.johannes.schindelin@gmx.de> <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net> <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net> <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
 <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u03gTcAXJc8GIFT/6tR5N1CjCPQRq1O/R0V+IbTGKCQm2Rh582+
 Z2EcBejtW62rlETgmlwU/3NTAw5CSSae45/l/4lRpEUL2IFY3E0HgqYg/g1DrWkJaIAgugx
 pSPI350piCmmaJuQjNOj+7C9H7MxLHMdlgTwQSQHXyfYH9X9YakgFOt30Chpr/l5KPXmjAC
 u6N4497eTQULYoR35xo+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MR6hgHmM8s4=:PXMPczrDXRDs7FUH6DH9SV
 zp84u3LVCQL2qHJlGyOc1qnO2DZQ0UU07QLCypHF3VB1/5HPvfPH8LVD0aUQN8mv0EjSO+Szy
 +WY4tNnf4ufx1XVn5d/w6rZdc9M7/zu4tu59pTcFyrD8Ahsu+zgqHfH4YjB5nJs1/sZwfknxY
 mHo3MVp5RpTcZRB3QgT4hnuatdhtZhg+iRgaOIwjSVUrrrQMLF/yRm8zUJwhJAQCqmnB3Vjm5
 7VpxumPlVHGDHsFJyCo4wG9IQpvNymGbqjvwlRRRnj807qGUq7yYoKkKuRQLUN7hRLqyGGCb3
 52ZXgatallOjVAflqIAjkoSbC8FxJ47RG/867ZurnT69yaJVPLYq/R2pDqKeXqeXrRK58GTBi
 szDcX8ocQ0DPnNesSuJcVQ/S3pMBcElsq3+/Lkaw/iImCj+ji8RAEhwXorYATIaAjfWxSVta7
 l6qoMCD2rr8O80lDXlk6LQcWngVpQI19Zty0Exi1Fc0IHNHDd7EyjgFUMjfuW8qRb5fyye074
 dk5CySiBsDcUEM7rzJCQ7Hr2yf3Z7mcTDlte5D0t2j1cbPF6UvrnGPo75oGgpN9s+jXYd6YvX
 CgryJ/wwqqfrRhTs9tfPtuAyGG+EEpPVPv8KtcdN1ZpPoBVGvn2PjGCRkkdWVyCHJevIC6toV
 CdRcJ//VHuY2Eh4IOkLKh4bPiYYYpsWV94h8EdTOWYKamROCcilZ6T8zmrfvR0G4tstES3pHp
 2Fiu2TmlzENMdVzCFBbxx6gHwEPfohSlWuMNJ/3I5kaD1WtRvsowA8faHjsE2NiSLA5oai4cR
 IilY0PD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 May 2017, Jeff King wrote:

> On Wed, May 17, 2017 at 10:38:36AM +0900, Junio C Hamano wrote:
> 
> > > -			add_pending_object(revs, a_obj, this);
> > > -			add_pending_object(revs, b_obj, next);
> > > +			add_pending_object_with_path(revs, a_obj, this,
> > > +						     oc.mode,
> > > +						     oc.path[0] ? oc.path : NULL);
> > > +			add_pending_object_with_path(revs, b_obj, next,
> > > +						     oc2.mode,
> > > +						     oc2.path[0] ? oc2.path : NULL);
> > 
> > The fix is surprisingly simple, and I think it definitely goes in
> > the right direction.
> > 
> > Somehow, it bothers me to be forced to view (a_obj, this, from_sha1,
> > oc) vs (b_obj, next, sha1, oc2) as a sensibly corresponding pair of
> > tuples, but that is not something your introduction of "oc2"
> > started, so I won't complain ;-).
> 
> Yes, in my polishing I switched this out at least "oc_a" and "oc_b" so
> we could be sure they match correctly. I think this whole "dotdot"
> conditional could be pulled out to its own function, and probably
> consistently use "a" and "b" for the endpoints. I'll see what
> refactoring I can do to make it more readable.

So you drive this forward? That would really help me a lot. Please make my
1/2 part of your patches to that end.

Thanks,
Dscho
