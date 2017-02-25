Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BDB201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 12:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdBYMxa (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 07:53:30 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:47959 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbdBYMxa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 07:53:30 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id hblRcdpvs0KuvhblRcxLrp; Sat, 25 Feb 2017 12:47:54 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=N659UExz7-8A:10 a=yPCof4ZbAAAA:8
 a=PWi42-BxNWIbCxg3-QgA:9 a=pILNOxqGKmIA:10 a=2lfDSYhZ3Z6b8uxcDO-Z:22
Message-ID: <36746FDD909546E29F39F1040810DA17@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>,
        "Vegard Nossum" <vegard.nossum@oracle.com>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Michal Zalewski" <lcamtuf@google.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com> <E14B054C79E1450F8B41E6477D1D7CD1@PhilipOakley> <0cdd4304-7b71-c38d-21ab-b4e997242bd4@oracle.com>
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty files
Date:   Sat, 25 Feb 2017 12:47:55 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="Windows-1252";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDDs+0Wd9QvxpbLf3sGzayIp6vrL5f7gFfSogEIh5JLLRUb8kBi109/efTsAArfIlmHWuQM5peNADFK++beJrecsv87r0eYw9al40fF4e+32vBFaCxuF
 J/yXECchDRq9criCE+utBckomQKYpeMTJAX7DBaFVPFDYju2d9z5/sae2PvFSfOeCrWHQRBD4itidn5+RRE0sggGPeqg8srp9Agy9fSMwq/KTLcWo0Oe21yA
 cyGZF9ff46OOsmsveQFaTxugIQrStbA6slW2B2QlMOGS7W8QQrKb8UE4e4aJv9Je
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vegard Nossum" <vegard.nossum@oracle.com>
> On 25/02/2017 12:59, Philip Oakley wrote:
>> From: "Vegard Nossum" <vegard.nossum@oracle.com>
>>> If we have a patch like the one in the new test-case, then we will
>>
>> "the one in the new test-case" needs a clearer reference to the
>> particular case so that future readers will know what it refers to.
>> Noticed while browsing the commit message..
>
> There is only one testcase added by this patch, so how is it possibly
> unclear? In what situation would you read a commit message and not even
> think to glance at the patch for more details?
>
On initial reading of a commit message, the expectation is that the commit 
will be about a change from some previous state, so I immediately asked 
myself, where is that new (recent) test case from.

You could say "This patch presents a new test case" which would straight 
away set the expectation that one should read on to see what its about. It 
was just that as a reader of the log message I didn't pick up the sense you 
wanted to convey. It's easy to see with hindsight or fore-knowledge.

I, personally, think that bringing the AFL discovery to the fore would help 
in explaining why/how the patch appeared in the first place.

Hope that helps explain why I responded.

regards

Philip 

