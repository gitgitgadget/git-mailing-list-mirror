Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DC91F744
	for <e@80x24.org>; Tue, 12 Jul 2016 00:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbcGLAqF (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 20:46:05 -0400
Received: from dmz-mailsec-scanner-4.mit.edu ([18.9.25.15]:49940 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752443AbcGLAqE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2016 20:46:04 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jul 2016 20:46:04 EDT
X-AuditID: 1209190f-06fff70000007bf7-fb-57843c9b9ab8
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by  (Symantec Messaging Gateway) with SMTP id 1A.EF.31735.B9C34875; Mon, 11 Jul 2016 20:40:59 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id u6C0ewEZ004184;
	Mon, 11 Jul 2016 20:40:59 -0400
Received: from [18.189.105.18] ([18.189.105.18])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u6C0eu3Y008384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 Jul 2016 20:40:57 -0400
Subject: Re: [ANNOUNCE] Git v2.9.1
To:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:	Anders Kaseorg <andersk@mit.edu>
Message-ID: <57843C98.7020200@mit.edu>
Date:	Mon, 11 Jul 2016 20:40:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160711235417.GA26163@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IR4hRV1p1t0xJusOOWjkXXlW4mi4beK8wW
	P1p6mC36l3awObB4HDrcwejxrHcPo8fFS8oenzfJBbBEcdmkpOZklqUW6dslcGWcbTnPVHCB
	s2Lnp2vsDYyX2LsYOTkkBEwk9kx/w9jFyMUhJNDGJPGkezI7hLORUeLhr5VQzlomiYmvj7GB
	tAgLKEls/tPBAmKLCLhKTFn3kwmiqJdRYvvRlWBzmQWsJZadfgZWxCagJvHh6FdWEJsXyN70
	4RoziM0ioCpx8flJsKGiAhESs7b/YIKoEZQ4OfMJWC8n0Jydt7czQ8w0k5i3+SGULS+x/e0c
	5gmMArOQtMxCUjYLSdkCRuZVjLIpuVW6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYwQEt
	yb+DcU6D9yFGAQ5GJR7eB6ebw4VYE8uKK3MPMUpyMCmJ8jYzt4QL8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuG1MQXK8aYkVlalFuXDpKQ5WJTEeRkZGBiEBNITS1KzU1MLUotgsjIcHEoSvKus
	gRoFi1LTUyvSMnNKENJMHJwgw3mAhvPbgAwvLkjMLc5Mh8ifYlSUEuedCdIsAJLIKM2D6wUn
	nL2ZQq8YxYFeEeY1A6niASYruO5XQIOZgAbXOjSDDC5JREhJNTD2r3zmk/yFP6DRtSgucVsU
	q/CGjcwaee3LOxsOZQbyHXmqwu2zNOulsfqWYIXGLne/9ucP9Z3+S9zffHreihNcMo/ZVn7f
	9/juHccigXOdpWGlDv7vuntcs/dJPkq8lPWqcnfv/d0nMjevPO5gwX7o3opXJ3hlvtqXq311
	eDjjw8lf8pqOu2cpsRRnJBpqMRcVJwIAx/AxWBMDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/11/2016 07:54 PM, Jeff King wrote:
> Yes, that's somewhat the point of the test.
>
> How does it fail for you (what does it look like with "-v")? We may be
> able to check for an outcome that matches both cases.

On Ubuntu i386 and Ubuntu armhf, I get the following verbose output from 
t0006-date.sh:


expecting success:
		echo "$time -> $expect" >expect &&
		test-date show:$format "$time" >actual &&
		test_cmp expect actual
	
--- expect	2016-07-11 23:20:55.835136188 +0000
+++ actual	2016-07-11 23:20:55.835136188 +0000
@@ -1 +1 @@
-5758122296 -0400 -> 2152-06-19 18:24:56 -0400
+5758122296 -0400 -> 2038-01-18 23:14:07 -0400
not ok 19 - show date (iso:5758122296 -0400)
#	
#			echo "$time -> $expect" >expect &&
#			test-date show:$format "$time" >actual &&
#			test_cmp expect actual
#		

expecting success:
		echo "$time -> $expect" >expect &&
		test-date show:$format "$time" >actual &&
		test_cmp expect actual
	
--- expect	2016-07-11 23:20:55.839136188 +0000
+++ actual	2016-07-11 23:20:55.839136188 +0000
@@ -1 +1 @@
-5758122296 -0400 -> 2152-06-19 22:24:56 +0000
+5758122296 -0400 -> 2038-01-19 03:14:07 +0000
not ok 20 - show date (iso-local:5758122296 -0400)


Anders

