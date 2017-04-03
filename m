Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CCF1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 16:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbdDCQU4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 3 Apr 2017 12:20:56 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64310 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdDCQU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 12:20:56 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v33GKrX7065587
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Apr 2017 12:20:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'ken edward'" <kedward777@gmail.com>, <git@vger.kernel.org>
References: <CAAqgmoP2uyd5_k-JDOBpBV8ay6BueUvKkwcWAZ_C1n4=4xpECg@mail.gmail.com>
In-Reply-To: <CAAqgmoP2uyd5_k-JDOBpBV8ay6BueUvKkwcWAZ_C1n4=4xpECg@mail.gmail.com>
Subject: RE: How do you script linux GIT client to pass kerberos credential to apache enabled GIT server?
Date:   Mon, 3 Apr 2017 12:20:45 -0400
Message-ID: <002501d2ac96$42a272a0$c7e757e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCwP1mwVYDMwJW1B3/tTUAbTqn+N6P4rSlQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On April 3, 2017 12:04 PM, Ken Edward Wrote:
>I have my git repositories behind an apache server configured with kerberos. Works fine if the user is logged in on their workstation.
>Apache gets the kerberos credential, and validates, and  then sends the GIT repo being requested.
>BUT, I want to write a script on linux that will also pass the kerberos credential to the apache GIT server without having any manually intervention. Seems I would create a kerberos keytab for the principal and then use that to >authenticate.... kinit supports authenticating from a keytab using the -k -t <keytab-path> options, but has anyone done this?

Have you attempted prototyping this using curl? It might be able to help out a bit. I have done this in the past with Stash and their REST and credentials, but not using Kerberos. Just a thought.
Cheers,

Randall

