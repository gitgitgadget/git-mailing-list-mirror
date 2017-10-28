Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34AC2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdJ1RuW (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:50:22 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:48943 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdJ1RuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:50:21 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 8VFUeRKdn3CyH8VFUerSUy; Sat, 28 Oct 2017 18:50:20 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=pGLkceISAAAA:8 a=wgVIo-pD_ZZE7ODCtK0A:9 a=wPNLvfGTeEIA:10
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <CDBB804CFC3842CF862FE12D99D60D79@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Philip Oakley" <philipoakley@iee.org>,
        "Sergey Organov" <sorganov@gmail.com>, <git@vger.kernel.org>
References: <87wp3g61ez.fsf@javad.com> <3655514352684AD398D17E83FF47F986@PhilipOakley>
Subject: Re: How to re-merge paths differently?
Date:   Sat, 28 Oct 2017 18:50:19 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171028-0, 28/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfA5ci/2kAXcPIdJUJvtsrcdHIxteX9oR4bmcXKcOMx/lB6WkJUCP2Qiz2UFgs0s5wka6n3jVCvNeF4AYge4X3Rb+MnRNW5MjlbI+5sUs2kSm6nHqCgsX
 TgQPeqvgU3efsHmxP7ieNnmOWyQKsvxpi/w0p5g1/GuqEPMkxiB0O1PjsS6uAxdNIIZCeEKCvBJ4rs2WMX9gaWKvaRHjXE0KTbIKTRNI9JByhzsbscHxU3ZO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Sergey Organov" <sorganov@gmail.com>
>> Is there anything like this:
>>
>> $ git merge b
>> [... lot of conflicts ...]
>> $ git re-merge -X ours -- x/   # Leaves 0 conflicts in x/
>> $ git re-merge -X theirs -- y/ # Leaves 0 conflicts in y/
>> [... resolve the rest of conflicts manually ...]
>> $ git commit
>>
>> [*] I do mean '-X' above, not '-s'.
>>
> 
> By this I presume you mean that you have paths x and y that ate the ones 

s/ate/are/   

> with conflicts within them following the `git merge b`.
> 

[snip]
