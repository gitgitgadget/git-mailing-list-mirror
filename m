Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879B220372
	for <e@80x24.org>; Mon,  9 Oct 2017 19:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbdJITlU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 9 Oct 2017 15:41:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:58153 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbdJITlT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 15:41:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v99JdtO4084437
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 Oct 2017 15:39:56 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Sascha Manns'" <Sascha.Manns@mailbox.org>, <git@vger.kernel.org>
References: <1507577714.2359.27.camel@mailbox.org>
In-Reply-To: <1507577714.2359.27.camel@mailbox.org>
Subject: RE: Auto adding changed files
Date:   Mon, 9 Oct 2017 15:39:43 -0400
Message-ID: <000201d34136$5e9f1640$1bdd42c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFQIEhLZKL9i3cQEL0Huz5NqRiBjaPiK3uw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On October 9, 2017 3:35 PM Sascha Manns wrote:
>if i'm in a git repo and change a file, it is listed in git status. But i have to add this file manually and commit them.

$ git commit -a

From the git commit help:  by using the -a switch with the commit command to automatically
"add" changes from all known files (i.e. all files that are already
listed in the index) and to automatically "rm" files in the index
that have been removed from the working tree, and then perform the
actual commit;

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



