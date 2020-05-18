Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C84C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB47207ED
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgERPyx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 May 2020 11:54:53 -0400
Received: from smtp-1.his.com ([216.194.195.13]:52522 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERPyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:54:52 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 11:54:52 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 90F126085E
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:46:01 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vSYbgM3sKFqs for <git@vger.kernel.org>;
        Mon, 18 May 2020 11:45:58 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 0B0CC605F0
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:45:58 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 00B01607E4
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:45:57 -0400 (EDT)
X-ASG-Debug-ID: 1589816756-061c4114b961e60001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id qF8vYX7TwZMqeanG for <git@vger.kernel.org>; Mon, 18 May 2020 11:45:56 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 7794760950
        for <git@vger.kernel.org>; Mon, 18 May 2020 11:45:56 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 44692177EE1;
        Mon, 18 May 2020 11:45:56 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sl-B2UFsQiaj; Mon, 18 May 2020 11:45:56 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 2CAEF177EE3;
        Mon, 18 May 2020 11:45:56 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lgFsnTg3yqrq; Mon, 18 May 2020 11:45:56 -0400 (EDT)
Received: from [192.168.1.168] (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id F29EE177EE2;
        Mon, 18 May 2020 11:45:55 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC PATCH 0/6] various documentation bits
From:   Kenneth Lorber <keni@his.com>
X-ASG-Orig-Subj: Re: [RFC PATCH 0/6] various documentation bits
In-Reply-To: <20200517074258.GA1381@Abhishek-Arch>
Date:   Mon, 18 May 2020 11:45:55 -0400
Cc:     Kenneth Lorber <keni@hers.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <617F5EC4-2C1F-48D7-88CC-48B18D26142A@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200517074258.GA1381@Abhishek-Arch>
To:     1589681624-36969-1-git-send-email-keni@hers.com
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589816756
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 3491
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=BSF_SC0_MISMATCH_TO
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81937
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 17, 2020, at 3:42 AM, Abhishek Kumar <abhishekkumar8222@gmail.com> wrote:
> 
> Hello Kenneth,

Hello.  Thanks for taking the time to assist me.  I am gradually working through all the replies.

> 
> On Sat, May 16, 2020 at 10:13:38PM -0400, Kenneth Lorber wrote:
>> From: Kenneth Lorber <keni@his.com>
>> 
>> This started as an effort to understand this section of config.txt:
>>  When inventing new variables for use in your own tool, make sure their
>>  names do not conflict with those that are used by Git itself and
>>  other popular tools, and describe them in your documentation.
>> and grew from there.
>> 
>> I don't expect this to be adopted as is, but I've found it much easier
>> to discuss something concrete rather than an abstract "this is
>> incomplete" or "this is hard to find."
>> 
>> Cut from master.
>> 
>> keni (6):
>>  Tell the glossary about core.hooksPath
>>  Add bit on extending git to Hacking Git
>>  Add namespace collision avoidance guidelines file
>>  Include NAMESPACE COLLISIONS doc into gitrepository-layout.txt
>>  Tell config.txt about NAMESPACE COLLISIONS
>>  Add NAMESPACE COLLISIONS reference to Hacking Git
>> 
>> Documentation/config.txt                      |  4 +-
>> Documentation/gitrepository-layout.txt        |  2 +
>> Documentation/glossary-content.txt            | 10 ++-
>> .../technical/namespace-collisions.txt        | 86 +++++++++++++++++++
>> Documentation/user-manual.txt                 |  9 ++
>> 5 files changed, 106 insertions(+), 5 deletions(-)
>> create mode 100644 Documentation/technical/namespace-collisions.txt
>> 
>> -- 
>> 2.17.1
>> 
> 
> Some general notes about your patch series:
> 
> 1. Conventionally, we prefix the first line with "area: " where the area
> is a filename or identifier for general area of the code being modified.
> It's customary to start the remainder of the first line after "area: "
> with a lower-case letter.
> 
> For example, your commit titles could have been:
> - doc: tell the glossary about core.hooksPath
> - doc: add bit on extending git to hacking Git
> 
> and so on.
> 
> Check out SubmittingPatches for more information.

Got it.  I was working from MyFirstContribution.txt which says only:
"Start the commit with a 50-column or less subject line, including the name of the
component you're working on".  If this is a common mistake, perhaps I should take a
shot at expanding this a bit?

> 
> 2. We generally don't have a line like in our patches:
> 
>> From Kenneth Lorber <keni@his.com>

That's odd.  It's not in the raw 0000-cover-letter.patch file.  In response to a comment
in another email I've been tweaking both config sendemail.* and my system mailer config
and I can't reproduce it (although I see it in a test message from a couple days ago).
Hopefully that means it's fixed.

> 
> Between the author information and the signed-off-by, it's redundant.
> 
> 3. You could probably join the patches 3 to 6 together. Or maybe
> introduce namespace-collisions.txt in third patch and add references in
> all other files in a new, fourth patch.

I split it out because 6 deepends on 3, but also conflicts with 2 if 3 is rejected.
I have no objections to this change once the dust settles but I'd prefer not to
reorganize things until then.  If you feel strongly the other way I'll change it now.

> 
> Thanks for the contribution!

You're welcome.

> 
> Regards
> Abhishek

