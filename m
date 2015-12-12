From: Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Fri, 11 Dec 2015 21:15:17 -0700
Message-ID: <EC1A4F48-729B-4DC5-ADB4-C0BEAE104908@codeaurora.org>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com> <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com> <20151207225714.GA3785@sigill.intra.peff.net> <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com> <20151210041941.GA4056@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Daniel Koverman <dkoverman@predictiveTechnologies.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:16:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7bbC-0004mW-RN
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 05:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbbLLEPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 23:15:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48850 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbLLEPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 23:15:17 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B56713EDDD;
	Sat, 12 Dec 2015 04:15:16 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id 6AD9313EEFA; Sat, 12 Dec 2015 04:15:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.1.8] (c-76-25-249-107.hsd1.co.comcast.net [76.25.249.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: nasser@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id A8F4813EDDD;
	Sat, 12 Dec 2015 04:15:15 +0000 (UTC)
In-Reply-To: <20151210041941.GA4056@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3096.5)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282298>


> On Dec 9, 2015, at 9:19 PM, Jeff King <peff@peff.net> wrote:
> 
> On Tue, Dec 08, 2015 at 05:34:43PM +0000, Daniel Koverman wrote:
> 
>> It is also good to know that 2000 remote refs is insane. The lower
>> hanging fruit here sounds like trimming that to a reasonable
>> number, so I'll try that approach first.
> 
> It's definitely a lot, but it's not unheard of. The git project has over
> 500 tags. That's not 2000, but you're within an order of magnitude.
> 
> I have seen repositories with 20,000+ tags. I consider that a bit more
> ridiculous, but it does work in practice.
> 

We have one at $DAY_JOB with 400,000+ refs. It presents some issues, but
Martin has raised those with the community and it works pretty well now.

Ref advertisement is still a pain...

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
