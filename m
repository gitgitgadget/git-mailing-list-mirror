From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Mon, 10 May 2010 12:31:59 +0200
Message-ID: <4BE7E09F.3040303@drmicha.warpmail.net>
References: <4BE60E89.8010709@pcharlan.com> <20100509110221.GA16639@coredump.intra.peff.net> <4BE7166A.5030107@pcharlan.com> <20100510054756.GB13340@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pete Harlan <pgit@pcharlan.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 10 12:32:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBQHK-0002pm-Ki
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 12:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242Ab0EJKb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 06:31:57 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36544 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755953Ab0EJKb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 06:31:56 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5B8D0F3C32;
	Mon, 10 May 2010 06:31:56 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 10 May 2010 06:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hp/X1TSAOYdFbmIFX74Tw9Ol6V0=; b=GHzQfLmzM4xk+nqudLy8xdddUDaIzYqRXnbLHSxCx2Hm5n52KiWmFxNtwWCB2vF4eflflcEHrvXok5nUBEGGnwP8VorMZov8kRyUxSugRHtBe5Rr2Ta3A881odfsrqkau87J+vmmL78pReuxk0uldSnxaVX7lbmOOHOGaRgi6sQ=
X-Sasl-enc: tgjIGyknlLKrYJ5yn9cHsKjjIlWnyAENbyW/pvDbN0zU 1273487515
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7A9A01D582;
	Mon, 10 May 2010 06:31:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100510054756.GB13340@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146791>

Jeff King venit, vidit, dixit 10.05.2010 07:47:
> On Sun, May 09, 2010 at 01:09:14PM -0700, Pete Harlan wrote:
> 
>>> I guess it comes down to how much detail we want to show.
>>
>> For me it isn't only a matter of detail; I find "Cloning into
>> bar/.git" misleading, since bar is getting more than a .git directory.
> 
> Yeah, I can buy that line of reasoning. Junio's nitpick aside, I think
> most users perceive the clone process as creating the whole "bar"
> directory.
> 
>> Thank you for looking at this.  I agree with you, and have added a
>> second patch that implements that.
> 
> These patches look good to me. I agree with Junio about just squashing
> them.
> 
> -Peff

Back from a conference, I'm being late for the party (Which way round is
better? ;) ).

But I still want to suggest not sacrificing correctness for "user's
expectations" and rather trying to do combine them. So how about saying

Cloning into $GIT_DIR...
Checking out branch $branch in $WORK_DIR...

where the latter happens for non-bare repos only, of course, and
incidently confirms the use of "-b" or of the default.

Michael
