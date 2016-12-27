Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EB6020441
	for <e@80x24.org>; Tue, 27 Dec 2016 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755107AbcL0REj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 12:04:39 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57277 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751136AbcL0REg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Dec 2016 12:04:36 -0500
X-AuditID: 12074412-5f5ff700000009b5-06-58629f20c7a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E0.40.02485.02F92685; Tue, 27 Dec 2016 12:04:33 -0500 (EST)
Received: from [192.168.69.190] (p5B10401B.dip0.t-ipconnect.de [91.16.64.27])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBRH4UQe014216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 27 Dec 2016 12:04:32 -0500
Subject: Re: What's cooking in git.git (Dec 2016, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq37hjmow0.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <afd95065-d076-b962-8337-b87008b9f894@alum.mit.edu>
Date:   Tue, 27 Dec 2016 18:04:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq37hjmow0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqKs4PynCYNtmcYuuK91MFg29V5gd
        mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugStjxe9jrAWneCvOnWtgaWBs4O5i5OSQEDCRuPXu
        LnsXIxeHkMBlRolpHzaxQDhnmSSmTpjK1MXIwSEsYC9xe58HSIOIgLXE75/fmUBsIQErifn9
        f1lAbDYBXYlFPc1g5bxA5XfPqYKYLAKqEguvKoJUiAqESFyec5QNxOYVEJQ4OfMJWCcn0MSP
        l26zgtjMAnoSO67/grLlJba/ncM8gZFvFpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4
        OTEvL7VI10wvN7NELzWldBMjJOCEdjCuPyl3iFGAg1GJhzdgVWKEEGtiWXFl7iFGSQ4mJVHe
        lklJEUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeM/NAcrxpiRWVqUW5cOkpDlYlMR5fy5W9xMS
        SE8sSc1OTS1ILYLJynBwKEnwCs4DahQsSk1PrUjLzClBSDNxcIIM5wEafnQuyPDigsTc4sx0
        iPwpRmOOW8eXPGXi+HMGSAqx5OXnpUqJ81aBlAqAlGaU5sFNgyWNV4ziQM8J8/4CqeIBJhy4
        ea+AVjEBrdKvjwdZVZKIkJJqYNzkZRS45vAjVVuRre6br8xV+RS7k+NMSka+G/+D+D6Gp2w3
        m9K1A79ZR2zQFbI/8WfOxoWlq34o33nA31DReP1FU1xgUujn7oi4C7MO5JjL3bSvSi1XrkqZ
        wbuW+2142lemnvo91j8jD1WIG744yrhWwFwnpKNqP3fy46UP3O8fbOCpiNpYrcRSnJFoqMVc
        VJwIADGexmj1AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2016 01:21 AM, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The second (rather large) batch of topics have been merged to
> 'master'.  Please test and catch possible regressions early.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> [Graduated to "master"]
> 
> [...]
> * jc/lock-report-on-error (2016-12-07) 3 commits
>   (merged to 'next' on 2016-12-13 at cb6c07ee92)
>  + lockfile: LOCK_REPORT_ON_ERROR
>  + hold_locked_index(): align error handling with hold_lockfile_for_update()
>  + wt-status: implement opportunisitc index update correctly
> 
>  Git 2.11 had a minor regression in "merge --ff-only" that competed
>  with another process that simultanously attempted to update the
>  index. We used to explain what went wrong with an error message,
>  but the new code silently failed.  The error message has been
>  resurrected.

Sorry I didn't notice this earlier, but the `LOCK_REPORT_ON_ERROR`
constant introduced by

    3f061bf "lockfile: LOCK_REPORT_ON_ERROR", 2016-12-07

sets that constant to the value 2, which is the same value set for the
existing constant `LOCK_NO_DEREF`. Both constants define bits that can
be set in the `flags` argument of `hold_lock_file_for_update()`, so one
of these values needs to be changed.

Michael

