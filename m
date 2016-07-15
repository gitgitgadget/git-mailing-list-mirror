Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E3E203C1
	for <e@80x24.org>; Fri, 15 Jul 2016 12:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbcGOMFI (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:05:08 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:45289 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbcGOMFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 08:05:04 -0400
X-Greylist: delayed 147872 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jul 2016 08:05:04 EDT
Received: from [204.148.29.50] (helo=[10.12.6.91])
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <beanie@benle.de>)
	id 1bO1rY-0005P9-Mr; Fri, 15 Jul 2016 14:05:00 +0200
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3200\))
Subject: Re: Multiple Keys in ssh-agent, fail to clone
From:	Benjamin Fritsch <beanie@benle.de>
In-Reply-To: <xmqqziplz63l.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 15 Jul 2016 08:04:59 -0400
Cc:	git@vger.kernel.org, Brendan Fosberry <brendan@codeship.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <7128CED1-381C-4489-A26D-3645D5A7BB69@benle.de>
References: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de>
 <xmqqziplz63l.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3200)
X-Df-Sender: YmVhbmllQGJlbmxlLmRl
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jul 13, 2016, at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Benjamin Fritsch <beanie@benle.de> writes:
> 
>> I read the Changelog for 2.9 and couldn’t find any reference to changed key handling. Is there anything that I can add to the `git clone` command to get the old behavior?
> 
> I do not think this has much to do with the version of Git, unless
> you are getting an updated SSH client together with your new version
> of Git from whoever distributes it.

Thank you for the great feedback. I could confirm that this is a problem on Bitbucket’s end. Sorry for the confusion.
I managed to successfully clone with Git 2.9 and Git 2.8

Best,
ben