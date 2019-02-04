Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E81D1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfBDMX4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 07:23:56 -0500
Received: from mout.gmx.net ([212.227.17.21]:50089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbfBDMXz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 07:23:55 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaE4a-1gWtTV1oQy-00Jqx3; Mon, 04
 Feb 2019 13:23:38 +0100
Date:   Mon, 4 Feb 2019 13:23:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Hubbs <williamh@gentoo.org>
cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v4 1/1] config: allow giving separate author and committer
 idents
In-Reply-To: <20190130003550.15502-2-williamh@gentoo.org>
Message-ID: <nycvar.QRO.7.76.6.1902041319250.41@tvgsbejvaqbjf.bet>
References: <20190130003550.15502-1-williamh@gentoo.org> <20190130003550.15502-2-williamh@gentoo.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xa7lFo6V5z1nEGQsOXYgeDYq+dAPVpL4s3rV/VdenAYJr1Vzbcz
 CjawcS/UOklGH06uRL11p10gPKs5zVeQfRR8KCQY/Y4WeJpfF/g+NED4nAWY1DruZ1JhdvD
 WanHnvMcCsiae4NMc/3zxXGUfYZcXLeTWkhXkTqXXml2TIVB0Y3bA2K1yCG13Dcor6Vp/PJ
 jMOrRFHrGhnlbodk3bgZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHGnMiqom8c=:Kn8wrZA6/FSS7hpWcKsccv
 0d7paD4y0MxxsI+LKxDDS8+jrARlGGR7YYo11zdxeQzPAe7oXF5UmvOzysxBvSJYoM+XLZnEv
 OrvOgV9UvNuy2Djr3m68YwvnP1aVDso/FkFDox6iHyFGC3x7vEIBkg5o1di6/kRfEzXrdUNmd
 0GXk2Zow0zEAuJXNufa4vvqfvDLOXosfNFD8yOsg5gFJMtMGXhSRC7Lsy4ypU8k3ogAISkJ36
 N395w0Y1Qeka6MeWcyEnT1nMUEuYhZLHz01kUqJ5cVdjzBmeHAg+8BwU7httK/AKIKKDYL1Sy
 5AJuNA7CPC2xIiqGwdQtslBNQuXsSAdkgTNKTqyrn8/SpZxGdfQ7nJ8a6eDu7VyTVR7Cpmfjg
 tmcn81QUe5TGncaAouYM43sZw1OIL3Q/EAQQM+tMIiIAsuXRaJGR6XcEtzu89bddvWs9WkklU
 5u1Jee/XC7tVBh+/1bXte1ZsAnoHEkyeziluI/DDHDe28vLg8aT2oYDoWYe8BWq949/yRmKPy
 Y9P5MGSJLDEsvOUIROM9gzWLHbsVMde/cUvwLB0HzmGBfmAOgexcz2orbmdgJ1xbaJnewbzLI
 l0BHFiBQZYFjRj7NBCpwxpsmA/6NR73rYv9r0Y/wjeK4k/4rqPyHnHRBqsOm3hJ3IfnIA3V20
 vfh59O+GercpvJmlXMcUDucsGbIDCT7qXoQly+WQqRrbth1Fmuqs36qthHrMWrDw+V9wKKCKp
 b3c9y0YG2t0mq4ub/w2J58G6kmYEAxAg8Bi0eEmPd4XqeZoOngQ21dFrIufwmNH23SzjESCWT
 S7DFxZ9URDgtAZJggaUagMcPj2TzAN47Fl2rgSQxlbRUUbAFxzW0RNDXhC5OwL0MRWEdoMbKh
 RJDE1pmMMVIbs51alkiW9MdbVsIEQjKncicPEDBfyiZq1y1Nu577hR5d/o142WHRHWBEUq2Zh
 nT7/LndeBkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

On Tue, 29 Jan 2019, William Hubbs wrote:

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index b5b2ba1199..8b31b5fa31 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,12 +1,19 @@
> -user.email::
> -	Your email address to be recorded in any newly created commits.
> -	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
> -	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
> -
>  user.name::
> -	Your full name to be recorded in any newly created commits.
> -	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
> -	environment variables.  See linkgit:git-commit-tree[1].
> +user.email::
> +author.name::
> +author.email::
> +committer.name::
> +committer.email::
> +	The `user.name` and `user.email` variables determine what ends
> +	up in the `author` and `committer` field of commit
> +	objects.
> +	If you need the `author` or `committer` to be different, the
> +	`author.name`, `author.email`, `committer.name` or
> +	`committer.email` variables can be set.
> +	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
> +	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` and
> +	`GIT_COMMITTER_EMAIL` environment variables.
> +	See linkgit:git-commit-tree[1] for more information.

This no longer talks about the `EMAIL` variable. Maybe we can add that
back?

The rest looks very clean to me.

Thanks,
Johannes
