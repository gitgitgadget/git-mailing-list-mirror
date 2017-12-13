Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA781F407
	for <e@80x24.org>; Wed, 13 Dec 2017 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbdLMQar (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 11:30:47 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23286 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbdLMQaq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 11:30:46 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id P9vheIP8ICbAZP9vheDPfy; Wed, 13 Dec 2017 16:30:45 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=Olv5uz_2KpxtjQqyIRMA:9 a=wPNLvfGTeEIA:10
Message-ID: <63304896830043BF9F076F507000D454@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Brandon Williams" <bmwill@google.com>, <git@vger.kernel.org>
Cc:     "Brandon Williams" <bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com> <20171204235823.63299-1-bmwill@google.com> <20171204235823.63299-13-bmwill@google.com>
Subject: Re: [WIP 12/15] ls-refs: introduce ls-refs server command
Date:   Wed, 13 Dec 2017 16:30:44 -0000
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
X-Antivirus: AVG (VPS 171212-0, 12/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfG/P8LjSTHO0ftIhhxEZy5NTPPfsWv4U11cbD8IPIQ4/S0jqTvYi4hKYkX5xxbpRv6mZX+cafuJORaF6zBVMjsCZXVyNJTfhTrH0Irmd3q2XC6zkYT/W
 L6ihZi/4cqsv6/Dn4gECCj2g5Woum9nAMtYVI+q9QkXIteU2GXwvAllkAWAVHRhlWB0Jai+IRfCeJ16agieC8JDzQZPqW6cc1XfjSDpnz3QFjmd4KX4fu29a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Brandon Williams" <bmwill@google.com>
Sent: Monday, December 04, 2017 11:58 PM
> Introduce the ls-refs server command.  In protocol v2, the ls-refs
> command is used to request the ref advertisement from the server.  Since
> it is a command which can be requested (as opposed to manditory in v1),
> a clinet can sent a number of parameters in its request to limit the ref

s/clinet/client/

> advertisement based on provided ref-patterns.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
Philip
