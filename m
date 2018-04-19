Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C611F404
	for <e@80x24.org>; Thu, 19 Apr 2018 14:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDSOFx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 19 Apr 2018 10:05:53 -0400
Received: from relaya.standardlife.com ([193.138.107.173]:13643 "EHLO
        relaya.standardlife.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbeDSOFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 10:05:52 -0400
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Apr 2018 10:05:51 EDT
From:   Andrew Ducker <andrew_ducker@standardlife.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Bug Report - Pull remote branch does not retrieve new tags
Thread-Topic: Bug Report - Pull remote branch does not retrieve new tags
Thread-Index: AdPX5XNOymz7t1oeS5WHVE1MIFeBEQ==
Date:   Thu, 19 Apr 2018 13:55:29 +0000
Message-ID: <adc410f016e8405fb81fa92e45675e2a@standardlife.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.85.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What happens:
When I create a new tag on the remote (changing nothing else)
"git pull origin master" produces the following:
  From git.internal.company.com:team/testrepo
   * branch            master     -> FETCH_HEAD
  Already up-to-date.

If I instead do a "git pull" I get:
  From git.internal.company.com:team/testrepo
   * [new tag]         Testing11  -> Testing11
  Already up-to-date.

What I think should happen:
The "git pull origin master" should retrieve the tag.

This is with 2.16.2.windows.1, but also occurred on my previously installed version (2.12.2.windows.2)

My understanding is that "git pull" and "git pull $repo $currentbranch" should function identically.

Is this a bug, or am I misunderstanding the manual page?

Thanks,

Andy
Confidentiality - This email is confidential.
Not meant for you? - If you don't think this email is meant for you, please let us know. Do not copy or forward the information it contains, and delete this email from your system.
Views expressed - Any personal views or opinions expressed in this email are the sender's, and do not necessarily reflect the views of Standard Life Aberdeen group.
Monitoring - We filter and monitor emails to protect our systems and to keep them running smoothly.
Emailing us - Email isn't a secure form of communication. If you want to send us confidential information please send it by post. However, if you do communicate with us by email on any subject, you are giving us permission to email you back.
Phoning us - Calls may be monitored and/or recorded to protect both you and us and help with our training. Call charges will vary.
Standard Life Aberdeen group - Standard Life Aberdeen group comprises Standard Life Aberdeen plc and its subsidiaries. For more information on Standard Life Aberdeen group visit our website http://www.standardlifeaberdeen.com/.
Standard Life Aberdeen plc (SC286832), Standard Life Assurance Limited (SC286833) and Standard Life Employee Services Limited (SC271355) are all registered in Scotland at Standard Life House, 30 Lothian Road, Edinburgh EH1 2DH. Standard Life Assurance Limited is authorised by the Prudential Regulation Authority and regulated by the Financial Conduct Authority and the Prudential Regulation Authority.
For more information on Standard Life Assurance limited visit our website http://www.standardlife.co.uk
