Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EDC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11AF2072C
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgERXz5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 19:55:57 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:60383 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:55:57 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id BB213607E4
        for <git@vger.kernel.org>; Mon, 18 May 2020 19:55:56 -0400 (EDT)
X-ASG-Debug-ID: 1589846096-061c4114ba93280001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id Xm5owMvyMe9MnDRE; Mon, 18 May 2020 19:54:56 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 572DF602DA;
        Mon, 18 May 2020 19:54:56 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 24875177F0C;
        Mon, 18 May 2020 19:54:56 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uz-HqXho05Hs; Mon, 18 May 2020 19:54:56 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 0D777177F1E;
        Mon, 18 May 2020 19:54:56 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w78qRxIUH0jg; Mon, 18 May 2020 19:54:55 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 5976B177F0C;
        Mon, 18 May 2020 19:54:55 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 4/6] Include NAMESPACE COLLISIONS doc into
 gitrepository-layout.txt
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 4/6] Include NAMESPACE COLLISIONS doc into
 gitrepository-layout.txt
In-Reply-To: <xmqqr1vi5brm.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 19:54:54 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6FA1EDEE-5DB4-446D-9579-593E9EADFC0F@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-5-git-send-email-keni@hers.com>
 <xmqqr1vi5brm.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589846096
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Scan-Msg-Size: 2196
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81944
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 8:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@hers.com> writes:
> 
>> From: Kenneth Lorber <keni@his.com>
>> 
>> Signed-off-by: Kenneth Lorber <keni@his.com>
>> ---
>> Documentation/gitrepository-layout.txt | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> As I said elsewhere, I am not sure if we want to even let
> third-party tools direct access at the filesystem level to
> $GIT_DIR/.  We do want to say things like where the ref namespace
> that are taken as "per worktree" are located, so that a third-party
> tool wants to carve out a hierarchy out of the per-worktree part of
> the ref namespace, that may indirectly influence where on the
> filesystem under $GIT_DIR/ their stuff is stored, but how we decide
> to store refs inside $GIT_DIR/ should still be blackbox to these
> third-party tools (e.g. we may not be using loose or packed refs,
> but using a chain of reftable files).  

Probably true in the abstract, but the current situation is an undefined mix.  Changing it is almost certainly more work than it's worth (my little game with COMMIT_EDITMSG notwithstanding), but documenting some safe places for end users seems reasonable to me.

> 
> So from that point of view, we shouldn't have to touch the
> repository layout document, I would think.

Where the information goes is certainly up for debate - that's why I put it in its own file.
Any suggestions for a better place?

(It looks like I may not have backed up far enough when I cut this diff.  I'll fix that for v2.)

> 
>> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
>> index a84a4df513..8050e8cc1f 100644
>> --- a/Documentation/gitrepository-layout.txt
>> +++ b/Documentation/gitrepository-layout.txt
>> @@ -290,9 +290,10 @@ worktrees/<id>/locked::
>> worktrees/<id>/config.worktree::
>> 	Working directory specific configuration file.
>> 
>> -include::technical/namespace-collisions.txt[]
>> include::technical/repository-version.txt[]
>> 
>> +include::technical/namespace-collisions.txt[]
>> +
>> SEE ALSO
>> --------
>> linkgit:git-init[1],

