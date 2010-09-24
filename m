From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t/t3903-stash: improve testing of git-stash show
Date: Fri, 24 Sep 2010 16:43:18 -0400
Message-ID: <47BAA71F-CF5C-4A98-BBB9-C502C81E3230@silverinsanity.com>
References: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com> <BVPnfVXRBMtK-9WPRRt3RH05x0aSmoFQsrb6lVp2uyULwHxOV-DnAXrmucCvrGrPQX_-AdS0fnA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: jon.seymour@gmail.com, robbat2@gentoo.org, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzF7E-00053n-6y
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751Ab0IXUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:43:23 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38557 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0IXUnW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 16:43:22 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1A7FC1FFC6B7; Fri, 24 Sep 2010 20:43:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 5AF731FFC6B5;
	Fri, 24 Sep 2010 20:43:13 +0000 (UTC)
In-Reply-To: <BVPnfVXRBMtK-9WPRRt3RH05x0aSmoFQsrb6lVp2uyULwHxOV-DnAXrmucCvrGrPQX_-AdS0fnA@cipher.nrlssc.navy.mil>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157057>


On Sep 24, 2010, at 4:40 PM, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> Recently, the 'stash show' functionality was broken for the case when a
> stash-like argument was supplied.  Since, commit 9bf09e, 'stash show' when
> supplied a stash-like argument prints nothing and still exists with a zero
> status.  Unfortunately, the flaw slipped through the test suite cracks
> since the output of 'stash show' was not verified to be correct.
> 
> Improve and expand on the existing tests so that this flaws is detected.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> On 09/24/2010 03:27 PM, Brian Gernhardt wrote:
>> I bisected the issue to a9bf09e (detached-stash: simplify git stash show),
>> which is when "git stash show" started using parse_flags_and_rev (via
>> assert_stash_like()).
>> 
>> More worrying to me is that the tests for "git stash show" don't bother
>> to test the output.  I'll be working on that now.
> 
> I was preparing these tests when your email came in.

I spent longer finding the source of the problem than you did.  I was just putting the finishing touches on it when I got this.  Yours is more through than mine, so I won't bother finishing.

~~ Brian
