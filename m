Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6861FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 08:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760944AbdDSIOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 04:14:36 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:54818 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760941AbdDSIOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 04:14:32 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 0kkwdf2elcpsk0kkxdNtfI; Wed, 19 Apr 2017 09:14:31 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=rT1cHfHUrkLBa2S0j7sA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=AjGcO6oz07-iQ99wixmX:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <FFDB9C5D48B642D7B8E4C30352815565@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com>        <9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley>        <1492347718.19687.14.camel@gmail.com>        <2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley>        <1492368692.22852.9.camel@gmail.com>        <DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley>        <1492380399.19991.13.camel@gmail.com>        <5EBADDE444D141918F6873BE8456E026@PhilipOakley> <xmqqefwqims1.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Wed, 19 Apr 2017 09:14:31 +0100
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
X-CMAE-Envelope: MS4wfAtzQV6DA9HCiiq7uAOyhIRe+P61poZxO8Mt/kd3aZvFGurJUxgdndnr6nxvUexK0xcqkvP9NAPyAO0tmtrxpV1udExxYSoUC2GyJwNvtjhRbC44pJ6u
 FJbUVEQtrB3eCWVzp98tdnFGs4P4c9nSFCgjQXKYYPUB+wNINBkNK1hkh6/yf7SKWLlNvhJ/RQTZNe/VRPKa8R28GZiDRlCOj2+l0kckjuOK/Ld2NSoZpDoR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks,

The link does contatin the ref to the original commit, which is helpful. 
(expands to https://github.com/git/git/commit/0a1283bc3955a97557)

Philip
[I'll be off-line all day]
----- Original Message ----- 
From: "Junio C Hamano" <gitster@pobox.com>
To: "Philip Oakley" <philipoakley@iee.org>
Cc: "Christoph Michelbach" <michelbach94@gmail.com>; "Git Mailing List" 
<git@vger.kernel.org>
Sent: Tuesday, April 18, 2017 1:26 AM
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout 
<tree-ish> clearer


> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I'd guess that the misunderstanding is that you maybe thought that the
>> whole directory would be reset to it's old state and the files b and c
>> deleted, rather than just the named files present in that old commit
>> being extracted. If we'd created and added a file d just before the
>> checkout, what should have happened to d, and why?
>
> It probably is a bit unfair to call it "misunderstanding".  I've had
> this entry in the "Leftover Bits" list for quite some time:
>
>    git checkout $commit -- somedir may want to remove somedir/file that
>    is not in $commit but is in the original index. Anybody who wants to
>    do this needs to consider ramifications and devise transition plans.
>    Cf. $gmane/234935
>
> In the thread, this message:
>
> https://public-inbox.org/git/xmqqeh8nxltc.fsf@gitster.dls.corp.google.com/
>
> may be a good summary.
> 

