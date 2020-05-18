Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DBAC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E8920674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgERWGj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 18:06:39 -0400
Received: from smtp-nf-201.his.com ([216.194.196.93]:59516 "EHLO
        smtp-nf-201.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 18:06:39 -0400
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id A104F60439
        for <git@vger.kernel.org>; Mon, 18 May 2020 18:06:38 -0400 (EDT)
X-ASG-Debug-ID: 1589839598-061c4114b98a910001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id s8NuFXf3jKcENhFH; Mon, 18 May 2020 18:06:38 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 340E160240;
        Mon, 18 May 2020 18:06:38 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id F2D0C177F18;
        Mon, 18 May 2020 18:06:37 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jopKrdcy5yr8; Mon, 18 May 2020 18:06:37 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id DBC60177F1A;
        Mon, 18 May 2020 18:06:37 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id POKqrSIYcEh2; Mon, 18 May 2020 18:06:37 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id B333D177F18;
        Mon, 18 May 2020 18:06:37 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 1/6] Tell the glossary about core.hooksPath
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 1/6] Tell the glossary about core.hooksPath
In-Reply-To: <xmqq4kse76od.fsf@gitster.c.googlers.com>
Date:   Mon, 18 May 2020 18:06:36 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4AD13040-F4F0-402B-A525-A8F2476061AD@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <1589681624-36969-2-git-send-email-keni@hers.com>
 <xmqq4kse76od.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589839598
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 2182
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



> On May 17, 2020, at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@hers.com> writes:
> 
>> From: Kenneth Lorber <keni@his.com>
>> 
>> The user manual glossary entry for hooks now knows about core.hooksPath.
>> 
>> Signed-off-by: Kenneth Lorber <keni@his.com>
>> ---
>> Documentation/glossary-content.txt | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> That's a gap worth filling.

Thanks.

> 
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index 090c888335..37147db1bc 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -206,10 +206,12 @@ for a more flexible and robust system to do the same thing.
>> 	to optional scripts that allow a developer to add functionality or
>> 	checking. Typically, the hooks allow for a command to be pre-verified
>> 	and potentially aborted, and allow for a post-notification after the
>> -	operation is done. The hook scripts are found in the
>> -	`$GIT_DIR/hooks/` directory, and are enabled by simply
>> -	removing the `.sample` suffix from the filename. In earlier versions
>> -	of Git you had to make them executable.
>> +	operation is done. The hook scripts are found in `$GIT_DIR/hooks/`
>> +	or in any directory specified by the `core.hooksPath` configuration
> 
> I expect "the", instead of "any", would make more sense to readers.

I agree, but I copied it from user-manual.txt, search for core.excludesFile.
Should it be changed there as well?

> 
> It is true that you can choose any directory of your liking and
> specify it via the variable, but once chosen that would be the only
> directory used for the purpose.
> 
>> +	variable.  The sample scripts are enabled by simply
>> +	removing the `.sample` suffix from the filename.  In earlier versions
>> +	of Git you had to make the sample scripts executable manually.
>> +	Hook scripts must be executable.  See linkgit:githooks[5] for details.
>> 
>> [[def_index]]index::
>> 	A collection of files with stat information, whose contents are stored
> 
> Thanks.

You're welcome.

