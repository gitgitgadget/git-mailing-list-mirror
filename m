Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B67C20756
	for <e@80x24.org>; Thu, 12 Jan 2017 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbdALKWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 05:22:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:54139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdALKWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 05:22:04 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ld3t6-1csBp70Wjw-00iBtu; Thu, 12
 Jan 2017 11:21:49 +0100
Date:   Thu, 12 Jan 2017 11:21:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Pat Pannuto <pat.pannuto@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
In-Reply-To: <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701121118170.3469@virtualbox>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com> <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org> <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZqOvGTn7xKxONv1bshmkCpN81J8EAVB3Lxhl+EOi02BCy7hGgzn
 HEzWohnPjVxkKKjicf6KGQOPKkuXsbESt3klOzokg8gR0pbGwyj0gEbGFF3LPBeu7rG2Z22
 Xsc6w2joIpT9SqU3xH6XJHKzyefBBX4/NwT7AZsZUl6QNaSCAg2dNRmFsCsKlVSS7DwHAZr
 UfW0b+xsvmtuIKTFt68Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:836Jep2UcA0=:6wnxCEM5lJxsKNyXyFEc/Y
 6sx3syoEPUFHWYTHABMq0zNqRnP3l3n98dFF+f/jrlak5U4UIfzzCgKKdOVBrG5CDpIAOk85g
 ZGvVnGz2czfF5nWIeAZEKANJBJPKBwbw4HmHF/8uGgH9nQSPW1o1T06FPHkabZvSNBXtKpCTA
 4B2XYD+I4ufQPpvRtbMd8ZIUm4M5tq7e3y5BPta+Msa5p2AYGZcd32mL63Rr/ud9V5t4NzL0a
 X0kyadwOnLyKBsuEW9W7g6ES/R41VZPe1zsEusAia8jBGUm2ZSDDmiWawkoo6OFCZNqDz3AhO
 /9uFjzutgVGkC5xKkZ8/9+rxLJObCNhm1TlV4cfuEilNBaXreIElo8cCs7RaiboFSxrmMfHIn
 V80PZm3xl6Q6q4e0vpq2ZaYtWuX3VRK+KDILrTeWiy38XzRQHgsubaHcMNfnUcdYvHcNaktn1
 jbuOSOiRCHWjbVLaxUsFrLJIRmz8lVk0Dyo9kU5asHjiAmun4C2bdktKvILzw9qVnN+vxlluW
 bG+mVQF6E7JeJwApNNK6AbVo/w+GQkTrHSwkzutJ4j5BB07gEG/ltVDiH49vdib3JcsMDcSSa
 r2amXJA7NK/9DLA8p6fiQWKWSpnFaatCsLiwtjTDLBdXeTB4JQ3Q8Chnb/tHhlse2bj/e4n4e
 zbEtS8Njzktxf8Fq5AeCkd95Nm7qfVtbHcb9KAvKF2rVnHCtLhj5qYC14l16/qi1kr2MQobdb
 B+E8dMKsUmT6iLfE6Orfuaq5sFjjFVAJ/2MJGYIMkf8ik6LiPMu5X1EccIzQ9UxVH8eqDcGYH
 Uq+KUWiT64BkmAXt/ow5LOXgzL63ihICQME6TW+MTEGzkqdQGDag2/hGEOSN+6d8KVt/jl8Uv
 B3xCUNTYE3eLqxG4CkTh1udrngGDjaP4p+LBYGV4KWLDUbiL5pgpWrm2OzDnBpt6IU6juTp8p
 talXMfQUEpNFP0JV2fsHSQfsHQW+nnrgSy0yfrwMVhITOsUGJb70GHuuEuFj6Y0/fn1wWjyA4
 fDao5po7jOoqh9I7ryvtUxPrBzu6i1AW+/FyBzSkQEHZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pat,

On Thu, 12 Jan 2017, Pat Pannuto wrote:

> I'm not at all attached to changing all of them, just figured it made
> sense while I was here.
> 
> Would a patch that changes only:
> 
>  git-add--interactive.perl                     | 2 +-
>  git-archimport.perl                           | 2 +-
>  git-cvsexportcommit.perl                      | 2 +-
>  git-cvsimport.perl                            | 2 +-
>  git-cvsserver.perl                            | 2 +-
>  git-difftool.perl                             | 2 +-
>  git-relink.perl                               | 2 +-
>  git-send-email.perl                           | 2 +-
>  git-svn.perl                                  | 2 +-
> 
> be more acceptable?

Unfortunately not. Take git-svn.perl for example, in particular in
conjunction with Git for Windows. git-svn requires the Subversion bindings
for Perl, and they are a *major* pain to build correctly (this is
frequently underestimated by users who complain about git-svn problems).

Allowing users to override the Perl path (even if it were possible, which
it is not, as Hannes Sixt pointed out in the mail you replied to) would
open Git for Windows for a metric ton of users complaining that their
git-svn does not work (when it is their fault, really, by overriding Perl
with their own preferred version that comes without Subversion bindings,
but how would they know).

So if this patch would make it into upstream Git, I would *have* to revert
it in Git for Windows, adding to my already considerable maintenance burden.

Ciao,
Johannes
