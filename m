Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200A5208E9
	for <e@80x24.org>; Sun, 22 Jul 2018 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeGVJwz (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 05:52:55 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:29573 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeGVJwz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 05:52:55 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id hAAgfTPRtbZX5hAAgfsaoY; Sun, 22 Jul 2018 09:56:55 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=BliDxfI3AAAA:8
 a=NEAV23lmAAAA:8 a=YdJJqbXCuVuEU9amGPoA:9 a=QEXdDO2ut3YA:10
 a=cSNAQ-gaCThlmQbDyrZZ:22
Message-ID: <FDF3F19D05C54539A6182DB33A0AAB4A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Frank Wolf" <webmaster@frank-wolf.org>, <git@vger.kernel.org>
References: <1536686621.139255.1531895907281@ox.hosteurope.de>
Subject: Re: Receiving console output from GIT 10mins after abort/termination?
Date:   Sun, 22 Jul 2018 09:56:57 +0100
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
X-Antivirus: AVG (VPS 180722-0, 22/07/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfMJ497DdNVKsb5Rn1uvoOxrm7h6IZc4RXFnpGu1rs2Dpzl+NvSfH5sKftgy3kHgn+H7k36t9uPosa34Dy9OwD5lsnsJR4+/T5KLVFZFUx2AWNMZ0evXf
 bfTjWKzKxBX0puFlZ4gFKAh5bX0hTGjiUP81eFVXaDCumrgSc+uOt3UfB6zSDhmfezw1nIOYb9T0rWLbvcGADV7YAmM1JpyuYb8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Frank Wolf" <webmaster@frank-wolf.org>
Sent: Wednesday, July 18, 2018 7:38 AM
> Hi @ll,
>
> I hope I'm posting to the right group (not sure if it's Windows related) 
> but I've got
> a weird problem using GIT:
>
> By accident I've tried to push a repository (containing an already
> commited but not yet pushed submodule reference).
> This fails immediately with an error of course BUT
>
> after 10 mins I get an output on the console though the command exited!?
> (... $Received disconnect from <GIT serverIP>: User session has timed out 
> idling after 6000000 ms....)
>
> Does anyone have an explanation why I still get an output after the 
> command was aborted?
>
> /Frank
>
I think this is a Windows environment issue. I have added a repy to the 
GitHub git-forwindows tracker. 
https://github.com/git-for-windows/git/issues/1762#issuecomment-406851107
I think you may have found a special case so will need extra details from 
you about the setup and hopefully an MVCE.

Philip 

