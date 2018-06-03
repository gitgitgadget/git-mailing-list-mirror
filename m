Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DC91F403
	for <e@80x24.org>; Sun,  3 Jun 2018 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFCPds (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 11:33:48 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:30489 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFCPdr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 11:33:47 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id PV0rfunokpXFjPV0rfzHSs; Sun, 03 Jun 2018 16:33:46 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=CEtC_dnCAAAA:8
 a=xzaylzIjmX_Cz23ZwWEA:9 a=wPNLvfGTeEIA:10 a=Fr9QGtSrJqje8MTI1nyQ:22
Message-ID: <0AE4648A05C445FBA049864F455B35A7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        "Thomas Gummerer" <t.gummerer@gmail.com>
Cc:     "Git Mailing list" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain> <20180603133039.GF26159@hank.intra.tgummerer.com> <alpine.LFD.2.21.1806030935010.21364@localhost.localdomain>
Subject: Re: [PATCH v2] t/perf/run: Use proper "--get-regexp", not "--get-regex"
Date:   Sun, 3 Jun 2018 16:33:40 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180603-2, 03/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDcMI2T9bXkhcSdgQTVrHe1Yv/J3xPdEgKx8+99fPhvnjvvbeiUvv8Kak/XcfVKSe2884JhyyBKWzEeWGEhvyp9OJkB7bToS5BqkN17p/xHF3/54nV6D
 rr2ExFYEmvtEpCazJgvPAPhzY9A0TAvf4/HZ7nA5bv8wYKquZJ2O6DnrcFXVtYJpJkLjiPK373jHA7M1+cbjwNlRrgKEOUB224dpohG+CSfI8hsC0paKzLxX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert P. J. Day" <rpjday@crashcourse.ca>
> On Sun, 3 Jun 2018, Thomas Gummerer wrote:
>
>> > Subject: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
>>
>> micronit: we prefer starting with a lowercase letter after the "area:"
>> prefix in commit messages.   Junio can probably fix that while
>> queuing, so no need to resend.
>
>  argh, i actually know that, i just screwed up.
>
>> On 06/03, Robert P. J. Day wrote:
>> >
>> > Even though "--get-regex" appears to work with "git config", the
>> > clear standard is to spell out the action in full.
>>
>> --get-regex works as the parse-option API allows abbreviations of the
>> full option to be specified as long as the abbreviation is
>> unambiguos.  I don't know if this is documented anywhere other than
>> 'Documentation/technical/api-parse-options.txt' though.

it's in `git help cli`:

many commands allow a long option --option to be abbreviated only to their 
unique prefix (e.g. if there is no other option whose name begins with opt, 
you may be able to spell --opt to invoke the --option flag), but you should 
fully spell them out when writing your scripts;

It's a worthwile read, even if the man page isn't flagged up that often.

>>
>> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>> >
>> > ---
>>
>> It took me a bit to figure out why there is a v2, and what changed
>> between the versions.  This space after the '---' would be a good
>> place to describe that to help reviewers.
>>
>> For others that are curious, it seems like the word "clear" was added
>> in the commit message.
>>
>> The change itself looks good to me.
>
>  the actual rationale for v2 was in the subject, i originally put
> just "get-regex" rather then "--get-regex"; i resubmitted for
> consistency.
>
--
Philip 

