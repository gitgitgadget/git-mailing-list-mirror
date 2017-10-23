Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0717202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932167AbdJWM0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 08:26:43 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:54603 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbdJWM0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 08:26:42 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 6boVeCoNKlmqO6boVeBUCP; Mon, 23 Oct 2017 13:26:41 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=eSlMDywwzFMwNr1NtXQA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <8F505EA8D16F4A0F890AE9DEEB91434B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>
Cc:     <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Ben Peart" <Ben.Peart@microsoft.com>,
        "Jonathan Tan" <jonathantanmy@google.com>,
        "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
        "Mike Hommey" <mh@glandium.org>,
        "Lars Schneider" <larsxschneider@gmail.com>,
        "Eric Wong" <e@80x24.org>,
        "Christian Couder" <chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <xmqq8tg4djkm.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
Date:   Mon, 23 Oct 2017 13:26:41 +0100
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
X-Antivirus: AVG (VPS 171023-0, 23/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfD9r7m6DHYs3dR9T4eIw+5eHZBzcgI8TEVWWJK1eP/3NHEZLaQNhCwMt+NXerNgZnW8wT4SKT/iE6R361Btv75eDLrCqfHbfE8SX9avZFMmTDcaFznwu
 GquRs7X7iXa7DhDD4LAV8e3qUGG4axPCt9xhDTfOs3ZvmxIGMx81RpqB9DkF7m5LWBzrXu5WIVD/Y/Gks3jzEZ22rRJJkCBvMMgpWkmu9671ept9tnoqms3A
 qRWJB3v/mFpiM/prT+FckXZQCq5yB6cqIpO6H1gd2ndvNBQpn2tS9TLImlWUfm861sGtvRXhoII3GlwXQmuKpRNWcze7blNq/S3+GfKQj0PWebsGmYKyEiQK
 RbSPdfKL3VWviG4ACkM4EL4+GTwraLsx0zr5j+MwNuE9dTw+finAdwlzZxmkl9SkbpgKFPUuan4YK6l9BkZjknRvDjh71Ch69HNU7cH7Cv5uOFi8S035DHoO
 bgHCpylAEUjukbxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

From: "Junio C Hamano" <gitster@pobox.com>
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Goal
>> ~~~~
>
> Totally offtopic, but is it only me who finds these "section
> headers" in cover letters from some people irritating and/or
> jarring?

Personally I find that, for significant patch series, that clearly breaking 
out these distinct sections is of advantage. At this stage (the very first 
patch 0/n) there is no specific conversation, so the subject line is a short 
'hello' to the topic, and then the contributor is (it is to be hoped) 
setting out their proposal in a clear manner.

So I do like these headings for larger series, though there is some 
judgement to be made as to when the subject line alone is sufficient.

As a separate follow on, one thing that does annoy me is that in subsequent 
versions of the various patch series, folk tend to drop all explanation of 
why the series is of any relevance, leaving just the 'changed since last 
time' part. This means that new readers who try and pick up / review / 
contribute to a series later on in its development are not told the purpose. 
When the list is active it can, accidentally, do a disservice to the 
potential contributors who may feel that only core contributors are able to 
contribute.

Whether this series needed a Goal heading is separate discussion ;-)

> ..          It perhaps is because I view the cover letter more as a
> part of conversation, not a presentation.  And when you walk up to
> somebody and start a conversation, you do not declare section
> headers ;-)
>
> Saying "I want to be able to do these things in the future, and here
> is to prepare for that future" at the beginning nevertheless is a
> good thing.  It gives us readers an overall vision we can agree to
> (or be against, or offer alternatives) and sets expectations on what
> the series would do and where it stops and leaves the remainder to
> follow-up work.
>
>> Packet related functions in Perl can be useful to write new filters or
>> to debug or test existing filters. So instead of having them in
>> t0021/rot13-filter.pl, let's extract them into a new Git/Packet.pm
>> module.
>
> I left some comments on individual patches to point out places that
> may need improvements.  I agree with the overall direction.
>
> Thanks for starting this topic.
--
Philip 

