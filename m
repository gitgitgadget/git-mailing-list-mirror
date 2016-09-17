Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5491FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 14:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbcIQOdN (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 10:33:13 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:61844 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbcIQOdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 10:33:12 -0400
Received: from PhilipOakley ([92.22.56.161])
        by smtp.talktalk.net with SMTP
        id lGg0brJVPHGLwlGg0b5OWP; Sat, 17 Sep 2016 15:33:09 +0100
X-Originating-IP: [92.22.56.161]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=jHxjN4OXtc1iyzOC0JcFMQ==:117
 a=jHxjN4OXtc1iyzOC0JcFMQ==:17 a=8nJEP1OIZ-IA:10 a=zzrCErxyr38uilqMsaYA:9
 a=wPNLvfGTeEIA:10
Message-ID: <3C23ED270E0C486EB2063BC5AEC25678@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Subject: Finding a commit based on the diff index line?
Date:   Sat, 17 Sep 2016 15:33:10 +0100
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
X-CMAE-Envelope: MS4wfNMKJ+k9n3WbP21nwtTj0xkQzFnX/JAbZONOoDfr4fMutpFADGKtk5a2tLA/a3xHJTQD4EiXNBIR30zDYcLXTOJkvJYiRwcxCrl7tPMStSs0AsArROw9
 qzF50mtHEkOcbNlmNggijh0NrJuHK3NNYhOsueR7lcq1qSQEQJsdaw5t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm curating some of my old patch series (i.e. doing some tidying up) and 
I'm trying to determine the commits that generated some of my patches so 
that I can see if I still have them after they were rebased (a 'name that 
dangling branch' problem).

Is there an easy way of finding the commit sha1 that contains the given diff 
index line.

For example.
index fa05269..57033dd 100755
or
index 8ebcded..d9ab360 100644

which both should get back to Jeff King's 36d6792 (t0006: test various date 
formats, 2016-06-20).

It feels like it is something that should already possible without a 
mini-script. We have the rev range which should limit the range to a single 
commit, though if random blob revs were given the commit range would be 
'scattered'.


Is there a simple quick way of achieving this?

--
Philip 

