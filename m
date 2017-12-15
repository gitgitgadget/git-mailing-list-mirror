Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39C41F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbdLOPyU (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:54:20 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30679 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932247AbdLOPyU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2017 10:54:20 -0500
X-IronPort-AV: E=Sophos;i="5.45,405,1508796000"; 
   d="scan'208";a="305675407"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 15 Dec 2017 16:54:18 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr>,
        "BENSOUSSAN--BOHM DANIEL p1507430" 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] doc: add triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
        <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
        <130319f3e40c4bfb81d2fc37bb4a4f9f@BPMBX2013-01.univ-lyon1.fr>
Date:   Fri, 15 Dec 2017 16:54:18 +0100
In-Reply-To: <130319f3e40c4bfb81d2fc37bb4a4f9f@BPMBX2013-01.univ-lyon1.fr>
        (ALBERTIN TIMOTHEE's message of "Fri, 15 Dec 2017 15:18:41 +0000")
Message-ID: <q7h96098m1g5.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr> writes:

>>> +Example with master as <branch>:
>>> +===================================
>>> +* `git config branch.master.remote upstream`
>>> +* `git config branch.master.pushRemote origin`
>>> +===================================
>
>>origin is the remote you've cloned from. From the text above, I guess
>>you meant it to point to PUBLISH. But all the examples "git clone" you
>>gave are from UPSTREAM.
>
>>You're mixing the case where one "git clone"s from UPSTREAM and "git
>>remode add"s PUBLISH, and the converse. Both are possible, but the
>>"origin" remote will be different depending on which one you chose.
>
> I think I don't really get it. IMHO UPSTREAM is name from the repository
> you pull from and PUBLISH from the repositiry you push to.

In your document, you're suggesting to clone from ORIGIN, and then to
set pushRemote to origin. This means "git push" will push to ORIGIN,
which doesn't work. Actually, if one follows your instructions, upstream
and origin will point to the same remote.

Did you test your own document on a real-life example? If not, you
should do so before anything else. You should notice this kind of issues
before asking for external review.

-- 
Matthieu Moy
https://matthieu-moy.fr/
