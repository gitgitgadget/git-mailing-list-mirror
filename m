Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63AF820195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbcGORUc (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:20:32 -0400
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:50528 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286AbcGORUb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 13:20:31 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.210])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u6FHKTKd002050
	for <git@vger.kernel.org>; Fri, 15 Jul 2016 13:20:29 -0400
Received: (qmail 21854 invoked by uid 0); 15 Jul 2016 17:20:29 -0000
X-TCPREMOTEIP: 23.28.40.196
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.195?) (andrew@kellerfarm.com@23.28.40.196)
  by 0 with ESMTPA; 15 Jul 2016 17:20:28 -0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <xmqq1t2uomw3.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 15 Jul 2016 13:20:28 -0400
Cc:	Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B3E20AFF-7661-43A0-A715-F0B9F3CD58DC@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <xmqq1t2uomw3.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 15.07.2016, at 1:02 nachm., Junio C Hamano <gitster@pobox.com> wrote:

> Expected outcome is an error saying "do not modify the index inside
> pre-commit hook", and a rejection.  It was meant as a verification
> mechansim (hence it can be bypassed with --no-verify), not as a way
> to make changes that the user didn't tell "git commit" to make.

Ah!  Good to know, then.  I’ll rewrite my hook to behave more correctly.

Thanks,
 - Andrew Keller

