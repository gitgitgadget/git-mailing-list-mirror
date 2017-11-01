Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12BE202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932356AbdKAMc6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 08:32:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:55308 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754496AbdKAMc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 08:32:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCLQ1-1e0lVr0FBx-0099Up; Wed, 01
 Nov 2017 13:32:50 +0100
Date:   Wed, 1 Nov 2017 13:32:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
In-Reply-To: <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:G1jObxJXretg/cGNVL5Ur07StFneVMkurT0Rz+UuKLyBcdb6pvd
 a/T5mpukFqCM0fKVAvDnUb4uf8NrxdtcZGcKZWA8cc2PDcWQRR3B9v3vRE9IyIWe0B+mTER
 28WKz8K7bb4g5Yh75TFRFvmUuRpkesJYKm4QFZeosL18uhaXqvOn2ERWNFH2pRJOXv1hO4Y
 TrTWypB6s88qTmyfYcrNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZjIGVcw5pBw=:6bbfTH/FjV21lGz9o4lWRZ
 eyj5xE5F4rVz2cdJ40+e18r3bFw82iZwTZduLWnzfz05dkx1tO5Cp+Ae/TGbhYczvAMOgcVzX
 pAYo49ZPyZT4Hu8TOVAES87yQiVDFb0VU+6QcOPuwynJ6f36s8+tbhvZl9JDaAPwGoIphM6uF
 PT7imb3jgEodqKRgAg9IIlWaKc6YD4OD8eYQRPuxuwyoc+6IHkFMi1odwaIB49adoULcH8tCs
 M33d88VyrN4OUeb4sQ0uI83rCUvl8EEmKAud5gzAU3E5i2qXqWECtoZ8SyaTtA5IIdLHUK4Ch
 gp9rMsEctLVr/MPqwa/pWPvunnzH3tU/ZVI2+UHU4OXixjB+1+EcMi/On2lqbumIdeAMfqBFy
 0Ezm/hfjbprwhgUIFTfj+1E1Dm1iYjGevfbDWum2+J3amMNCzkmBf+WiNxaZRQoMdJf3SGrPA
 /OlhmrL2Cg9qXBrs+kioazyoOwRLAbHvFqR1YAWdvZPjI0EjNqbY0cQ5dwzcqwZJyenDSvNBm
 Ydi5FsQLSB1+izIGiv+r9q4F8AUnC8uI32AGxPj0uJ2FX726wQNkNGtWnwVkZfCsdKEqPYtfG
 phYbfdFLu8oGaAQQrxm+E4UVmzUr2JHPvQXJRGCDLyeQhaLaopJ9bDVsstS7/h4TAMQ9dGwk+
 bSH6xyRjGDKTtk4MH9Cdoxi2b5iyiLw6oxdroI5ZNcUS6stbbaLo5FoxFkwqXF5HbNtAsqWhX
 mq0OpWh8NL5LekVDn9VxTKVJK/541LGCcwoNH4NkTIF8myaTN6WwATrCkgESqaeIZlajBDL5y
 oLbMhpTESzj/FiHO2yEb6cHCKJENIzeVvGCEe+zW19wBIUrpb+g6/Ti0INjaaJoW5D5tCdr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Nov 2017, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > +If the given object refers to a blob, it will be described
> > +as `<commit-ish>:<path>`, such that the blob can be found
> > +at `<path>` in the `<commit-ish>`. Note, that the commit is likely
> 
> Does the code describe a9dbc3f12c as v2.15.0:GIT-VERSION-GEN, or
> would it always be <commit>:<path>?

As the blob is described using this function:

static void process_object(struct object *obj, const char *path, void *data)
{
       struct process_commit_data *pcd = data;

       if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
               reset_revision_walk();
               describe_commit(&pcd->current_commit, pcd->dst);
               strbuf_addf(pcd->dst, ":%s", path);
       }
}

i.e. as `describe_commit()` is used on the commit part, the answer to your
question is: the former. I guess that is why Stefan wrote `commit-ish`
instead of `commit` ;-)

> > +not the commit that introduced the blob, but the one that was found
> > +first; to find the commit that introduced the blob, you need to find
> 
> Because we do not want to descend into the same tree object we saw
> earlier, this "we show the name we happened to find first without
> attempting to refine it for a better name" is a rather fundamental
> limitation of this approach.  Hopefully we can later improve it with
> more thought, but for now it is better than nothing (and much better
> than "git log --raw | grep").

Indeed.

Ciao,
Dscho
