Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0CD91F407
	for <e@80x24.org>; Fri, 15 Dec 2017 16:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbdLOQFX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 11:05:23 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56299 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932359AbdLOQFW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2017 11:05:22 -0500
X-IronPort-AV: E=Sophos;i="5.45,405,1508796000"; 
   d="scan'208";a="305677523"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 15 Dec 2017 17:04:57 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] doc: add triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
        <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
        <xmqqbmj1t4tp.fsf@gitster.mtv.corp.google.com>
        <eca47dd3598045a1a3fac94f9df8e972@BPMBX2013-01.univ-lyon1.fr>
Date:   Fri, 15 Dec 2017 17:04:57 +0100
In-Reply-To: <eca47dd3598045a1a3fac94f9df8e972@BPMBX2013-01.univ-lyon1.fr>
        (ALBERTIN TIMOTHEE's message of "Fri, 15 Dec 2017 15:46:47 +0000")
Message-ID: <q7h9vah8kmdy.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr> writes:

>>>> +This workflow is commonly used on different platforms like BitBucket,
>>>> +GitHub or GitLab which provide a dedicated mechanism for requesting merges.
>>>
>>> As a user, I find it terribly frustrating when reading documentation
>>> telling me that "there's a dedicated mechanism" for something without
>>> telling me actually how to do it.
>
>>Also I think the description is backwards from end-user's point of
>>view.  It's not that it is common to use the workflow on these
>>hosting sites.  It's more like people use the workflow and adopt use
>>of these hosting sites as one building block of the workflow.
>
> I'm wondering if this sentence is really useful. It's not essential
> and it will take lot of time and space to talk about it properly.
> So, if you agree, we'll erase it.

I think it is useful. My guess is that most people don't know the
wording "triangular workflow", but most people know about GitHub for
example. See e.g.
https://trends.google.com/trends/explore?q=%22triangular%20workflow%22,github,gitlab,bitbucket

So the hope here is that the reader reading this feels "Ah, OK, this is
about how to do pull-requests on GitHub". OTOH, I wouldn't like a Git
official documentation to be biaised towards a single hosting site.

> In the case of a triangular workflow, if the project already exists,
> PUBLISH will already exist too.

No.

If the project already exists, then UPSTREAM exists, and the contributor
will create his or her own PUBLISH. There's generally two ways to do it:

* On platforms supporting this, use the platform's mechanism to create a
  fork (e.g. fork button on GitHub/GitLab's web UI).

* One can create an empty PUBLISH, clone UPSTREAM, and push to PUBLISH.

-- 
Matthieu Moy
https://matthieu-moy.fr/
