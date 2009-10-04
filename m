Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10874 invoked by uid 107); 4 Oct 2009 13:24:06 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756525AbZJDNTI (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZJDNTI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:19:08 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:48407 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751263AbZJDNTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:19:07 -0400
Received: from [10.5.26.28] (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n94DIKH4006986
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 4 Oct 2009 09:18:23 -0400
Subject: Re: [PATCH] tests: make all test files executable
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From:	Mark Rada <marada@uwaterloo.ca>
In-Reply-To: <20091002083946.GA8627@coredump.intra.peff.net>
Date:	Sun, 4 Oct 2009 09:18:20 -0400
Cc:	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1762B430-2DC0-48F5-8C34-8428F9145A1E@mailservices.uwaterloo.ca>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca> <20091002080134.GD27664@coredump.intra.peff.net> <20091002083946.GA8627@coredump.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1076)
X-UUID:	c7a9e85f-ebf9-47e3-82de-9d1686c81e4a
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2009-10-02, at 4:39 AM, Jeff King wrote:

> On Fri, Oct 02, 2009 at 04:01:34AM -0400, Jeff King wrote:
>
>>> 0 files changed, 0 insertions(+), 0 deletions(-)
>>> mode change 100644 => 100755 t/t5531-deep-submodule-push.sh
>>> mode change 100644 => 100755 t/t9501-gitweb-standalone-http- 
>>> status.sh
>>>
>>> diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep- 
>>> submodule-push.sh
>>> old mode 100644
>>> new mode 100755
>>> diff --git a/t/t9501-gitweb-standalone-http-status.sh
>>> b/t/t9501-gitweb-standalone-http-status.sh
>>> old mode 100644
>>> new mode 100755
>>
>> When applying via "am", I only got the first change in my tree.  
>> I'll see
>> if I can confirm and make a test case.
>
> Ah, nevermind. The problem is that your patch was word-wrapped, making
> the second "diff --git" line bogus. It would have been nice to have it
> print a warning instead of silently ignoring that bit of the patch.
>

I didn't have format=flowed buggering things up this time, so I don't
quite understand the problem; could you please explain with more  
details?

When I try to apply the patch from a saved copy of the e-mail, I get
the following error:

	# git am ~/Downloads/\[PATCH\]\ tests_\ make\ all\ test\ files\  
executable.eml
	Patch format detection failed.
	zsh: exit 1     git am

The difference between the patch created by format-patch and the saved
e-mail is just some e-mail header information. Is that a different error
than what you were getting? I'm not sure what I'm doing wrong here, help
would be appreciated.

--
Mark Rada (ferrous26)
marada@uwaterloo.ca


