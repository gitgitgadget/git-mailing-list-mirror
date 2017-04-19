Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877FF1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760564AbdDSHcM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:32:12 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:37269 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760561AbdDSHcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 03:32:10 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 0k5wdewgFcpsk0k5wdNpcY; Wed, 19 Apr 2017 08:32:09 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=5VET6gVex9WtIZa_MwIA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <AC79ED43D69A4063B2F30AE43B1AEE63@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Christoph Michelbach" <michelbach94@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <1492287435.14812.2.camel@gmail.com><9535BE255A654CADB7B0AE7599A6FA96@PhilipOakley><1492347718.19687.14.camel@gmail.com><2DCA89C3FDFF41E5B3651018BF837267@PhilipOakley><1492368692.22852.9.camel@gmail.com><DF5E72F5BD2F4BB99D8EC4DF1B4543F7@PhilipOakley><1492380399.19991.13.camel@gmail.com><5EBADDE444D141918F6873BE8456E026@PhilipOakley><1492452173.11708.22.camel@gmail.com><5FD0803E166B4D2F9F64D8D21AC23EB3@PhilipOakley> <xmqqa87eimje.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] Documentation/git-checkout: make doc. of checkout <tree-ish> clearer
Date:   Wed, 19 Apr 2017 08:32:08 +0100
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
X-CMAE-Envelope: MS4wfMGM8oWl1tUf60mrK1rorqrASaF8sQKvpw9UYYhOImaWKAoCwZX8zK1wsNi7oIvNPmIbYjOUtagcej1fYKuBvlC6aS+JR70X41/UfwWvXzslY0GxVawv
 I31IakRJwbgFhCMS3GWXdqMo67YEXqGtRglQP8hzk4wt2pjW/f9NWs9KJPm9A1/8NpQF+rqWWrchudpsdyQwLNBOm1G6slKLPIQ9VsBOSiOqT+iUulA1pFLu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>    Sent: Tuesday, April 18, 2017 
1:31 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>>> If we'd created and added a file d just before the checkout, what
>>>> should
>>>> have happened to d, and why?
>>>
>>> I understand what the command does. It behaves perfectly as I expected
>>> it to. I did not find this script but wrote it to demonstrate that what
>>> the documentation says is different from how it behaves after having
>>> read what the documentation says it should do and noticing that that's
>>> not how I expected it to work from experience.
>>>
>>> What it really does is to copy all files described by the given paths
>>> from the given tree-ish to the working directory. Or at least that's my
>>> expectation of what it does.
>>>
>>> The documentation, however, says that the given paths are *restored*.
>>> This is different.
>>
>> I don't see that difference in the phrase *restored*, compared to your
>> 'copy all files described by the given paths'. Could you explain a
>> little more?
>
> I am obviously not Christoph, and I was the one that defined how
> "checkout <tree> -- <pathspec>" should work, but when you say
> "restore" (which is not what I wrote ;-)) it is fair to expect lack
> of 'd' could also be "restored", in addition to path that was in the
> directory.
>
> Obviously, "grab all paths that match <pathspec> out of <tree>, add
> them to the index and copy them out to the working tree" will never
> be able to _restore_ the lack of 'd', even it may match the
> <pathspec> being used to do this checkout, by removing it from the
> current index and the working tree.
>
My attempt at asking about an additional file 'd' ended up being a bit of a 
red herring as it went off at a tangent.

Hopefully Christoph will hang in to help clarify the original issue. I think 
I'm getting a sense of the potential confusion between the different 
messages Git sends out, and which one is the right one here. On the one hand 
Git promotes the two step staging area approach, but on the other hand the 
checkout of a file suggests IIUC that all checkouts will end up as staged 
revisions (one step only).

Philip 

