Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA7C20193
	for <e@80x24.org>; Thu,  4 Aug 2016 14:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933771AbcHDOVq (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 10:21:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:50618 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933815AbcHDOVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 10:21:43 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M86PB-1bHvOj192v-00vcxk; Thu, 04 Aug 2016 16:21:12
 +0200
Date:	Thu, 4 Aug 2016 16:21:11 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
In-Reply-To: <xmqqziot5jc3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608041620290.5786@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <20160729161920.3792-5-kcwillford@gmail.com> <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608011055180.149069@virtualbox> <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021244450.79248@virtualbox> <xmqqk2fzf69w.fsf@gitster.mtv.corp.google.com> <xmqqziot5jc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WE63aswJonWNg2byVuAlKXCmfWRe43BomWKzGCftpSZNyYRIRI2
 1O7VLZ2sB/Bbc/JfQ9v9HsxM86PTQc8aLW0O7l6fJzzq1AgZxJ0dsFLmcu/YLfXIj5bp6Ou
 P2YgAkmT6uZlBBmZL1/DiD3Wg7YPLfIx2d1lXCgicc9/Nvx08IvSq2bXfHJ3FRHdoO/W0Kw
 kFVpX85zUD+ip0y8UTTeQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0cT6aUyq9qA=:sZk7J2hsdrWYxx2vXJFODH
 I/8dwxXvB3gFE9Xm4nJULweNRHT7lNGMtOBS1lclTcPuumGG51B0hIYhbx0ietWQeRG9+C2+L
 Xhf38BmUpa2CIWGDbeddmlisAfZs58Gt6h2BlddA+R/2MyeTgEbBn6mdv/yVulGTVnRYLpX0k
 BYOeIMmy4AaUMN5FthjLbzNXG37Bal3NrRJGVSX35KGrCiz0ePQHoPX2+f3oHN36KyB9bSrun
 z6Xe7xLNcT2LkzblrVRoN59+prPgvPNuP8ZcBXnwaxNzx9FTkrvqzPoof9Ey9Jy6lCln/5DQ3
 975+rOfAbpKhK+YRyI2651awcaAhqWlwoyBPCALWNEPgd7YgOzwuAAVC0AIHFq5clCgFIgFrP
 OtG7W8rktMSztIN7HxL23f1cY3Q9GYLy/b/u5Va2JxgBgAzIBzu94e7p7kh2UMbM+/nSh09gL
 pahDjoHyP4eujppN5rib0QxLOFsNv468TjzQZcD7tQ4M0JzwWs4KHWRqSBg86xuBoait0H3ro
 OyyL6mR+LUUU5QuKGNiJGyIXoP8bD8v3vgTznY3QzKMo2E/jIHjW0T1UwYrN+8nKlDpAghW8C
 vd00PncA0foUpXnGHCvdF2HIdVuz/JDN5qOJ0C+ZyeQ6CberQT0S4oI1JEUCPJonDceud5k5j
 X3VbJvjbTtdMEG1H/Uh9AN1t6HMmsgdMAQH7lxgfw7B+PA1GWCr1daK2byJ02oNv1rgeenMeu
 LelLSP+nCunOX2ZKureKfTRfD0curwRBL1Z/sWTSka+7ThVL/zR1zRXi7SAIdKdkGoCXmcPzp
 pJiZgJb
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 3 Aug 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not think negative (or non-zero) return is an "abuse" at all.
> > It is misleading in the context of the function whose name has "cmp"
> > in it, but that is not the fault of this function, rather, the
> > breakage is more in the API that calls a function that wants to know
> > only equality a "cmp".  A in-code comment before the function name
> > may be appropriate:
> >
> >         /*
> >          * hashmap API calls hashmap_cmp_fn, but it only wants
> >          * "does the key match the entry?" with 0 (matches) and
> >          * non-zero (does not match).
> >          */
> >         static int patch_id_match(const struct patch_id *ent,
> >                                   const struct patch_id *key,
> >                                   const void *keydata)
> >         {
> >                 ...
> 
> How about this one instead (to be squashed into 4/4)?
> 
> The updated wording directly addresses the puzzlement I initially
> felt "This returns error() which is always negative, so comparing
> (A, B) would say A < B, while comparing (B, A) would say B < A.
> Would it cause a problem in the caller?" while reading the function
> by being explicit that the sign does not matter.

Please squash it in. Kevin is on vacation and I am sure he is fine with
this change.

Thanks,
Dscho
