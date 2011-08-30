From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Tue, 30 Aug 2011 17:41:01 +0200
Message-ID: <4E5D048D.4010902@drmicha.warpmail.net>
References: <4E587CC0.4090508@alum.mit.edu> <7vippiaduw.fsf@alter.siamese.dyndns.org> <7v1uw69h96.fsf@alter.siamese.dyndns.org> <20110829185546.GD756@sigill.intra.peff.net> <4E5CD5B9.80306@drmicha.warpmail.net> <20110830152217.GA13022@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 17:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyQR6-0006Ih-Jq
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 17:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465Ab1H3PlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 11:41:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56428 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755210Ab1H3PlF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 11:41:05 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 46A6120DAB;
	Tue, 30 Aug 2011 11:41:04 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 30 Aug 2011 11:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=K4bBEUD+C2gK9vqAMDgzc+
	4Z6vk=; b=E4RHH0VUGx7/wHUUXdSY9r6bdPnM3DhDtf/6GwT1DOA7SedH/2Nf8X
	mprwiWVUfqYWaq8sgYOCM5xyqc9Sp8J3apRuBUa8z8PRGpYOf25rEonwdtV9jxZN
	FgzEKCLMK2HhMWrNjKZjK1BbEqnxSbCMGRBQWxtpiQfx7c1SH8hUg=
X-Sasl-enc: 9X1ULDz8/IEECTOXQtm4+DlZ2p7PCjp5v5yDPsn+ssk+ 1314718863
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 36DCFAC02FF;
	Tue, 30 Aug 2011 11:41:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110830152217.GA13022@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180413>

Jeff King venit, vidit, dixit 30.08.2011 17:22:
> On Tue, Aug 30, 2011 at 02:21:13PM +0200, Michael J Gruber wrote:
...
>> Anyways, notes survive rebase etc.
> 
> You still have to manually configure:
> 
>   git config notes.rewriteRef refs/notes/commits
> 
> Perhaps that is something that should be changed.

Right, I've done that quite a while ago and forgot.

>> and at format-patch time you can decide whether you want to include
>> them or not (with my patch).
> 
> Yeah. Don't get me wrong, I think putting "---" notes into git-notes is
> way more flexible. It's just that it's also more complex, and
> unnecessarily so for many use cases.
> 
> We have some patches to hide that complexity, but I was at one point
> wondering if all of the complexity was worthwhile. But as I mentioned
> above, if you want to build anything more complex than a pure-patch
> workflow, the simple solution breaks down. So it probably is worth
> pursuing.

Reminds me of the ref namespace restructuring which could help sharing
notes... Oh, lots to do before git 3.0!

Michael
