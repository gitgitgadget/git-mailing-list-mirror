Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A7E203BD
	for <e@80x24.org>; Fri, 28 Oct 2016 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030229AbcJ1QcE (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 12:32:04 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:30104 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937878AbcJ1QcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 12:32:02 -0400
Received: from PhilipOakley ([92.22.74.108])
        by smtp.talktalk.net with SMTP
        id 0A4Tc6zL0gKst0A4Vcr5Sk; Fri, 28 Oct 2016 17:32:00 +0100
X-Originating-IP: [92.22.74.108]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=gemZZafLxLrjWEucDwrW+g==:117
 a=gemZZafLxLrjWEucDwrW+g==:17 a=IkcTkHD0fZMA:10 a=A9qS8gIqAAAA:8
 a=BLBKj1IIAAAA:8 a=tLPf1Row0DvHGO6g3z0A:9 a=QEXdDO2ut3YA:10 a=nM1JtKY_qDwA:10
 a=H28RkzuXznr5akrmL4QT:22 a=DGJeqclcRXVSur9XdYk5:22
Message-ID: <B5FD05E58E36480894F1BDBBC9589EE1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>
Cc:     "Stefan Beller" <sbeller@google.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, "Simon Ruderich" <simon@ruderich.org>,
        "Jeff King" <peff@peff.net>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org> <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org> <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com> <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com> <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com> <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com> <2ddca5e3-3c4d-b555-4309-a180ceed581e@kdbg.org>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
Date:   Fri, 28 Oct 2016 14:01:45 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDcmyMFOVqJSpT2So0pvLnlhZ+LGE/GGyTbEToj3GtKdCuUzuzCRUJTECx0foqpVUiR370XqlaY4jXMma9wgkX5rP+f6HkQw+615J/dhFgUwx3i/ki1v
 mmhAGwVTmgN0hgr9X7LTMpydA4QOo+BgGKSB6KiNcK8GYHl6xaTR6/z8WjRDmV+01Dz9jsSb2qdulk9yZwsYNBqVeYzLRTV2VDPc4aifSCExfAP3GzBR+KVE
 TYuJTofFzkPCMs85uu8vG3R++OvYhP9tS3Nw3kBSwFJuIlhsOonOkNN/yHrDMwzNLIoaxAfKfY3NObnqr2AuDczcNDFZal93UN5ULdRVLM4tbmzI8T2ukrBE
 jphBXRU1Buxg0IA3cjlGDQkSONqB3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Sixt" <j6t@kdbg.org>
>
> One point is that the DCLP idiom must be implemented correctly. There are 
> solutions, of course, and when the initialization is over, we have a 
> miniscule overhead at each pthread_mutex_lock call.
>

I had to look up DCLP ( = Double Checked Locking Patterns), and found a good 
write up on the issues..

http://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf "C++ and the 
Perils of Double-Checked Locking", which include 'C' issues, and 
multi-thread, multi-processor issues. Not an easy issue when fighting 
optimisers..

--

Philip 

