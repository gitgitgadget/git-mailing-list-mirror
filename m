Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA330C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC472088E
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgE0Q74 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 12:59:56 -0400
Received: from smtp-1.his.com ([216.194.195.13]:50326 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgE0Q7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:59:54 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 12:59:54 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id D5A34606E4
        for <git@vger.kernel.org>; Wed, 27 May 2020 12:52:27 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1lxpxV0u9qv7 for <git@vger.kernel.org>;
        Wed, 27 May 2020 12:52:27 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 78E6D6068B
        for <git@vger.kernel.org>; Wed, 27 May 2020 12:52:27 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 80B1862A93
        for <git@vger.kernel.org>; Wed, 27 May 2020 12:52:26 -0400 (EDT)
X-ASG-Debug-ID: 1590598346-061c412052425ad0001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id QX0qYiffMa2l5jun; Wed, 27 May 2020 12:52:26 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 1A4506024B;
        Wed, 27 May 2020 12:52:26 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id DA4B3177DF0;
        Wed, 27 May 2020 12:52:25 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rotY5KfWj_mQ; Wed, 27 May 2020 12:52:25 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id C3369177EF2;
        Wed, 27 May 2020 12:52:25 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kzE9xrvBi9M7; Wed, 27 May 2020 12:52:25 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 99446177DF0;
        Wed, 27 May 2020 12:52:25 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath
In-Reply-To: <xmqqmu5umsjg.fsf@gitster.c.googlers.com>
Date:   Wed, 27 May 2020 12:52:25 -0400
Cc:     git@vger.kernel.org, Kenneth Lorber <keni@his.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <79C90EFA-CF65-4AF7-82B2-0B1B6FABA0F8@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com> <20200525232727.21096-2-keni@his.com>
 <xmqqmu5umsjg.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590598346
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1944
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82143
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 26, 2020, at 2:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Kenneth Lorber <keni@his.com> writes:
> 
>> Subject: Re: [RFC PATCH v2 1/6] doc: Tell the glossary about core.hooksPath
> 
> Perhaps
> 
>    Subject: [PATCH] glossary: describe core.hooksPath
> 
> Please separate this one patch out and send it again without the
> rest of the series, as this is quite different from the rest of the
> 6-patch series and an obvious clarification, unlike the others.

Will do.

> 
>> -	operation is done. The hook scripts are found in the
>> -	`$GIT_DIR/hooks/` directory, and are enabled by simply
>> -	removing the `.sample` suffix from the filename. In earlier versions
>> -	of Git you had to make them executable.
>> +	operation is done. The hook scripts are found in `$GIT_DIR/hooks/`
> 
> You accidentally lost 'the', and because you did an unnecessary
> line-wrapping, such a change became harder to spot.  

My apologies.

> 
> I am not sure if .sample scripts should be a topioc of this glossary
> entry at all to begin with.  And I think it outlived the usefulness
> to describe what was in versions of Git that is more than 10 years
> old.  I wonder if it is a better idea to take your new description,
> but remove everything after "The sample scripts are enabled..."
> except for the "see ... for details" link?

I had considered it but didn't want to presume.  If I don't hear any objections
I will take it out.

> 
>> +	or in any directory specified by the `core.hooksPath` configuration
>> +	variable.  The sample scripts are enabled by simply
>> +	removing the `.sample` suffix from the filename.  In earlier versions
>> +	of Git you had to make the sample scripts executable manually.
>> +	Hook scripts must be executable.  See linkgit:githooks[5] for details.
> 
>> [[def_index]]index::
>> 	A collection of files with stat information, whose contents are stored

