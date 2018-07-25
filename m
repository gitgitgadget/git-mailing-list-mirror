Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB561F597
	for <e@80x24.org>; Wed, 25 Jul 2018 13:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeGYOnu (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 10:43:50 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31729 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeGYOnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 10:43:50 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w6PDW1x0072050
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 09:32:01 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'David Hind'" <David.Hind@dynexsemi.com>, <git@vger.kernel.org>
References: <4b9575bf039e46cd9dc150111916e734@LINCEXCHANGE1.dynexsemi.com>
In-Reply-To: <4b9575bf039e46cd9dc150111916e734@LINCEXCHANGE1.dynexsemi.com>
Subject: RE: Using Git for applications other than code development
Date:   Wed, 25 Jul 2018 09:31:55 -0400
Message-ID: <006f01d4241b$de430c80$9ac92580$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkeLzy4qXmoLT4oUjtskokbW4/fKP/Q7TA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

I have used git over the past 3 years in a manufacturing environment to
manage component designs in a CAD/factory automation setting. There are a
few main factors that you need to consider:

1. You will need an external tool like Git for Windows, GitHub Client or
SourceTree for performing git operations on your workstations because your
design software is unlikely to support any VCS directly.
2. Your design software probably needs to store its designs in some text
form. This will allow a lot of the advanced git functions, like annotate, to
work nicely. This is not a requirement as git is happy to manage binaries
(your renderings, for example).
3. You might need to figure out a way to interpret changes when there are
conflicts between designers. This either means learning the underlying
format (auto-lisp??) or making choices of whose design is going to take
priority without trying to merge changes or otherwise resolve conflicts.
4. Lastly (but really there are more you will encounter), you will need to
decide on either a local shared repository (GitHub Enterprise, BitBucket
Server, GitLab, etc.) or a similar cloud solution (same names). There are
costs for each, usually depending on your team size. The costs are pretty
small for small teams and more than worth it, IMHO.
5. I have been repeatedly surprised at how many hardware component designers
actually have git experience (followed lastly deliberately).

Git is generally a good fit for advanced manufacturing. I'm including a
discussion of git in a seminar I am giving at IWF Atlanta next month.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of
David Hind
Sent: July 25, 2018 9:02 AM
To: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: Using Git for applications other than code development

Hi, 

I work for a company that is looking to adopt VCS and I like sound of Git
(although I have no experience of using VCS). My question is, everything
seems to be directed towards code developers. Can I use Git to do revision
control for other types of design document? For example electrical circuit
designs, circuit PCB designs etc.?

Thanks!
David 

________________________________________

Dynex Semiconductor Limited.
Registered in England and Wales: No 3824626
Registered Office: Doddington Road, Lincoln, LN6 3LF, United Kingdom

This e-mail and any attachments are confidential and may be privileged. If
you are not the intended recipient please notify the sender immediately,
delete the email from your system and do not disclose the contents to
another person, use it for any purpose or store or copy the information in
any medium.
Whilst we run anti-virus software on all internet emails we do not accept
responsibility for viruses and advise that in keeping with good computing
practice you should ensure this email and any attachments are virus free.

