From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Mon, 30 Jul 2012 11:56:58 +0200
Message-ID: <50165A6A.8010705@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de> <cover.1343309173.git.git@drmicha.warpmail.net> <7vtxwu75gy.fsf@alter.siamese.dyndns.org> <20120726184337.GB16037@sigill.intra.peff.net> <7vzk6m5ln9.fsf@alter.siamese.dyndns.org> <50126005.7060202@drmicha.warpmail.net> <7vboj115as.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 11:57:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svmiq-0003IU-D1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 11:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab2G3J5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 05:57:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52281 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752644Ab2G3J5A (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 05:57:00 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D173720A08;
	Mon, 30 Jul 2012 05:56:59 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 30 Jul 2012 05:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=iZd3Bv2KEgq3u/X1Qvi1fP
	UyxH4=; b=W/TpI8SKnHhjepA3vf6vZsBOnrXnhs5VRNSRPI6Wtm53kb5djQobYm
	o38LhoWEq9m9e9coKshBE2Kpx7KH/Mk54IekT7SgDmf3FfYRf4CrU5FtVzpQcPJe
	WfJQC+Z58D8rFquNoLPd6/PLJT7Es2OMRkUplhqlBIkTzEu2imc8Q=
X-Sasl-enc: 2LS+3LR4vWOUEym2AZnh2nlGO2Zt3n4/tfPsKJNXZ9l/ 1343642219
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 22A008E01E7;
	Mon, 30 Jul 2012 05:56:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <7vboj115as.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202531>

Junio C Hamano venit, vidit, dixit 27.07.2012 19:29:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> 5/5 needs a fix in the subject line, sorry. It should be:
>>
>> t3910: use the UTF8_NFD_TO_NFC test prereq
>>
>> (5/5 hasn't hit next)
> 
> That is because I thought that you would like the lazy-probe and
> that you would be capable of rerolling it on your own ;-)
> 

Well, I do like the lazy-probe, and I would like to lazy-probe ;)

Due to the nice design of test_lazy_prereq, the test scripts don't need
any adjustment in order to get lazy. Now, that's what I call lazy!

So, 5/5 does not need any reroll, right? Anyway, 5/5 with the proper
subject line comes in a minute.

And thanks for the un-lazy lazyfing reroll of 1/5 and 4/5.

Michael
