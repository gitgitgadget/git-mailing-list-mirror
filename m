Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96762C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7552E206D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgERWKC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 18:10:02 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:59566 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 18:10:02 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id B35B262AE5
        for <git@vger.kernel.org>; Mon, 18 May 2020 18:10:01 -0400 (EDT)
X-ASG-Debug-ID: 1589839801-061c4114ba8b360001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id AXgmZaYIUNeZkVeD; Mon, 18 May 2020 18:10:01 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 431E56017A;
        Mon, 18 May 2020 18:10:01 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 0C949177F18;
        Mon, 18 May 2020 18:10:01 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QYILXD7_binu; Mon, 18 May 2020 18:10:00 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id E7957177F1B;
        Mon, 18 May 2020 18:10:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V2-lTzI_tqkx; Mon, 18 May 2020 18:10:00 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id C0571177F18;
        Mon, 18 May 2020 18:10:00 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 2/6] Add bit on extending git to Hacking Git
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 2/6] Add bit on extending git to Hacking Git
In-Reply-To: <xmqqzha65s1l.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 18:10:00 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <07D99191-664E-475C-A9B1-7FE4DB5C2165@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-3-git-send-email-keni@hers.com>
 <xmqqzha65s1l.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589839801
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1840
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81942
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@hers.com> writes:
> 
>> From: Kenneth Lorber <keni@his.com>
>> 
>> The Hacking Git section of the user manual is the logical place to look
>> for information on extending Gut, so add a short section of links to
>> places where that information actually lives.
>> 
>> Signed-off-by: Kenneth Lorber <keni@his.com>
>> ---
>> Documentation/user-manual.txt | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> 
>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
>> index 833652983f..2144246444 100644
>> --- a/Documentation/user-manual.txt
>> +++ b/Documentation/user-manual.txt
>> @@ -4049,6 +4049,14 @@ and that is what higher level `git merge -s resolve` is implemented with.
>> This chapter covers internal details of the Git implementation which
>> probably only Git developers need to understand.
>> 
>> +If you are extending Git using hooks, writing new tools, or otherwise
>> +looking for technical information but not hacking Git itself, the following
>> +documents may be what you are really looking for:
>> +
>> +* hooks: linkgit:githooks[5]
>> +* attributes: linkgit:gitattributes[5]
>> +* new tools: linkgit:git-sh-setup[1]
> 
> I am not sure if this fits here.  It is a distraction to the target
> audience of this section, no?

I agree and still think this is where it goes (unless we start a new chapter on hacking FOR git, which is more than I can handle at the moment).

My reasoning is that from the available chapters, this is my best bet (as a new user) for finding this information; pointing them elsewhere isn't that big a distraction (it's at the top and short) and would be a great help for people looking for that kind of info.

My two cents anyway.

