Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA051F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeGHVR5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:17:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:64064 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeGHVR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 17:17:56 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id cH45f3x0AbZX5cH45fmeIE; Sun, 08 Jul 2018 22:17:55 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8
 a=Parqv8uTYqe6tUMFJoAA:9 a=QEXdDO2ut3YA:10 a=jYKBPJSq9nmHKCndOPe9:22
Message-ID: <AED9D71037D249F8A56FDF0B1AA48603@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Beat Bolli" <dev+git@drbeat.li>
Cc:     "Git List" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>
References: <20180708144342.11922-1-dev+git@drbeat.li> <20180708144342.11922-5-dev+git@drbeat.li> <CAPig+cSGj6Pt4OmRAQauZCiVG3PnjWeXm20RtYGbsjdZ5Tk4gg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
Date:   Sun, 8 Jul 2018 22:17:55 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180708-6, 08/07/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfCvwuNiD3XiRC5aru9DvcrMebu3rGfWIhhRQUCkAmSTOS35cGS/RZn349I666OcSX7lc5bihC1OJB+p3j7YAGHeTNdKGtD630TPHnmBXLlAOWjKj29CH
 t9Ij9ju3iDVbCgOpSbMXZ4nvY6sDFRRegaZTCfLeLyN1qk78Ro9/Fa28IKZdLTKYlpL1E8svIIe/BVOjsfIZIkTU7W/eo8G/uG3wJjrZGzw9W5B+opq5/JDI
 2PK6vCOKD2F77byx5Xw8Lg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric Sunshine" <sunshine@sunshineco.com>
To: "Beat Bolli" <dev+git@drbeat.li>
> On Sun, Jul 8, 2018 at 10:44 AM Beat Bolli <dev+git@drbeat.li> wrote:
>> The marco GIT_PATH_FUNC expands to a complete statement including the

s/marco/macro/

>> semicolon. Remove two extra trailing semicolons.
>>
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>  sequencer.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> While you're at it, perhaps it would be a good idea to fix the example
> in path.h which teaches the "wrong" way:
> 
> /*
> * You can define a static memoized git path like:
> *
> *    static GIT_PATH_FUNC(git_path_foo, "FOO");
> *
> * or use one of the global ones below.
> */
>
