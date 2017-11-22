Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83D820954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbdKVXli (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:41:38 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:51028 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdKVXlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:41:37 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Hee7eRPllbjdZHee7eDorT; Wed, 22 Nov 2017 23:41:36 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=7r1tiqOwi-Fo4j6-vw0A:9 a=wPNLvfGTeEIA:10 a=ezPG0ZpnnpEA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
References: <20171119184113.16630-1-bedhanger@gmx.de><20171113223654.27732-1-bedhanger@gmx.de><83D263E58ABD46188756D41FE311E469@PhilipOakley><xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com><20171113223654.27732-3-bedhanger@gmx.de><xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com><20171119184113.16630-5-bedhanger@gmx.de><xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com><5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
Date:   Wed, 22 Nov 2017 23:41:35 -0000
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
X-Antivirus: AVG (VPS 171122-2, 22/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBB1g2oBC3CeNXel3WjzGflUDLZvgttNPzJ3Hc0RZPsvogMSmvEaBDgegepN7RQDF1Js7g93/223K4TfDHWYCdUq97pp/iGdnE44V8ut9kKG0Z19wUWl
 YVmZOPu7+GJvngQ0/4dDRBAaW2ac+mIyP3qocwR3eb6ORbD1CrCfUJHqySCOhlyp50+q1YroFJvpwtnBAPTTnkU0YHtBL28EMjjkdCOiig8a0hfD/2VBodnZ
 4LiIGFVtyFkUboGNgYVTPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> Ann T Ropea <bedhanger@gmx.de> writes:
>>>
>>>> *1* We are being overly generous in t4013-diff-various.sh because we do
>>>> not want to destroy/take apart the here-document.  Given that all this 
>>>> a
>>>> temporary measure, we should get away with it.
>>
>> So, the need to reformat the test for the future post-deprecation
>> period is being deferred to the time that the PRINT_SHA1_ELLIPSIS env
>> variable, and all ellipis, is removed - is that the case? Maybe it
>> just needs saying plainly.
>
> And if we say it that way, it is clear that with this series, we are
> shipping a new feature with a test that does not protect the output
> format we claim to be the improved and preferred one.  That sounds
> quite bad.
>
> Having said that, I have already queued this to 'pu' and I do not
> terribly mind to merge it down to 'next', leaving the test updates
> to cover the new output format as well as the backward compatible
> one at the same time for a later follow-up patch.

I'd agree. I just wanted to ensure that I had the right understanding.
>
> I'd however hate it if I have to carry the topic in the current
> shape in 'next' forever, waiting for such an update to come, that
> may never materialize, and be forced to do it myself without being
> explicitly asked by (and thanked for) anybody, especially because
> this is not exactly my itch X-<.

True.
>
>> Or is the env variable being retained as a fallback 'forever'? I'm
>> half guessing that it may tend toward the latter as it's an easier
>> backward compatibility decision.
>
> We do not know until this change is released to the wild, at which
> time we will hear noises about the lack of expected ellipses their
> (poorly written) scripts rely on and tell them to set the workaround
> environment variable.  We may not hear from such people at all, in
> which case we may be able to remove it within a year or so, but it
> is too early to tell.

I was wondering if there should be a small documentation change for the env 
variable and states that it is a temporary measure for short term 
compatibility. Though I'm not sure where the 'right' place would be for it.


