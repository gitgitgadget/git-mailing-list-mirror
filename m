From: Phil Hord <hordp@cisco.com>
Subject: Re: Special branch for remote
Date: Wed, 27 Jul 2011 10:35:21 -0400
Message-ID: <4E302229.4030402@cisco.com>
References: <j0ohjr$fcd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paulo J. Matos" <pocmatos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:35:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm5Ct-0001gY-MX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab1G0Of1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 10:35:27 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:64091 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1G0OfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 10:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=901; q=dns/txt;
  s=iport; t=1311777325; x=1312986925;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=35iCaurS+D/mItMqQVvMxpk2qoU6Oh1gAz1/PpGX1wo=;
  b=IZ26DIiii54JcCBROtuVjQmrHFZ2OkGxvFXmE5fW0nyBq98zHN7rSCqP
   58rw6k6rUD8Wxatfl0zP36E6Ta5l5STyEH0+T5SVWNJsc0TsDbCYQRfn9
   y0NEz/2pIMnC9HsQ22M81ICM5JRNq5unv7K7JAVnwLrUcWNzoxLgXq9d3
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAAMiME6rRDoH/2dsb2JhbAA1AQEBAQMUAW8BEQwYCSIPCQMCAQIBAlEHDgEOAQEfpxl3iQCjTZ5uhkAEknWFB4t3
X-IronPort-AV: E=Sophos;i="4.67,276,1309737600"; 
   d="scan'208";a="6997444"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by rcdn-iport-9.cisco.com with ESMTP; 27 Jul 2011 14:35:23 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p6REZMV4014512;
	Wed, 27 Jul 2011 14:35:22 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <j0ohjr$fcd$1@dough.gmane.org>
X-TagToolbar-Keys: D20110727103521714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177969>

On 07/27/2011 04:18 AM, Paulo J. Matos wrote:
> Hi all,
>
> I have a huge repository for a software I am developing. In it I have
> source code, docs, experiments, tests, etc. However, I want to push
> only the src/ to the github remote, nothing else. What's the best way
> to achieve this. Do I need to simply create a new branch and then push
> the new branch to github or there's anything else involved that I need
> to know?
>

Yes, you can do this with branches. See [1] for an example of a similar
workflow.

You can also manage this with submodules [2] or subtree-merge [3].

I prefer submodules since it keeps the huge stuff (docs and bins) away
from my source code and makes my source code repo much more responsive.

[1] http://www.braintreepayments.com/devblog/our-git-workflow
[2] http://progit.org/book/ch6-6.html
[3] http://progit.org/book/ch6-7.html

HTH,
Phil
