Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF3C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4010A207D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgERXo1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 19:44:27 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:60275 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:44:26 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 8FB0860481
        for <git@vger.kernel.org>; Mon, 18 May 2020 19:44:25 -0400 (EDT)
X-ASG-Debug-ID: 1589845465-061c4114ba92980001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id pBlGSHIa7HUiQjMO; Mon, 18 May 2020 19:44:25 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 1BF6F60134;
        Mon, 18 May 2020 19:44:25 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id D105D177EFB;
        Mon, 18 May 2020 19:44:24 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id E5SM2TPZ-Rsi; Mon, 18 May 2020 19:44:24 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id B8D8D177F1E;
        Mon, 18 May 2020 19:44:24 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BjfJoXxEL_TZ; Mon, 18 May 2020 19:44:24 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 8BE54177EFB;
        Mon, 18 May 2020 19:44:24 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 0/6] various documentation bits
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 0/6] various documentation bits
In-Reply-To: <xmqqv9ku5rsw.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 19:44:24 -0400
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E4B7ABAF-DA2C-4A96-BBCF-4F8F0DB45585@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200517074258.GA1381@Abhishek-Arch>
 <xmqqv9ku5rsw.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589845465
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 2232
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81943
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 2:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> 
>> Some general notes about your patch series:
>> 
>> 1. Conventionally, we prefix the first line with "area: " where the area
>> is a filename or identifier for general area of the code being modified.
>> It's customary to start the remainder of the first line after "area: "
>> with a lower-case letter.
>> 
>> For example, your commit titles could have been:
>> - doc: tell the glossary about core.hooksPath
>> - doc: add bit on extending git to hacking Git
>> 
>> and so on.
>> 
>> Check out SubmittingPatches for more information.
> 
> Good suggestion.
> 
>> 2. We generally don't have a line like in our patches:
>> 
>>> From Kenneth Lorber <keni@his.com>
>> 
>> Between the author information and the signed-off-by, it's redundant.
> 
> Carefully inspect the e-mail header and in-body header ;-)  
> 
> The author identity must match the identity written for the
> signed-off-by trailer, so the in-body header becomes needed
> when the From: e-mail header does not match the true author,
> like these patches.

Email/git send-email configuration issue.  They should match on v2, if I'm lucky.

> 
>> 3. You could probably join the patches 3 to 6 together. Or maybe
>> introduce namespace-collisions.txt in third patch and add
>> references in all other files in a new, fourth patch.
> 
> Perhaps, but I'd rather not to see a rule that hasn't been applied
> even once in the real situation written down like a law.  I'd prefer
> to see us gain experience by interacting tool authors on the list
> and learn what their concerns and pain-points are.

This tool author/git admin went for a patch to discuss.

I assume from the above there has been no interaction before, so at the very least we need a pointer to the list for this topic to cause that interaction to occur.

As I noted in another part of this thread, we can certainly make it less of a law and more of a recommendation or hint.

I listed some of the issues elsewhere; if that isn't quite what you are looking for I can expand on it.

> 
> Thansk.

Thank you,
Keni

