From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Tue, 27 Apr 2010 17:30:53 +0200
Message-ID: <4BD7032D.9050508@drmicha.warpmail.net>
References: <20100427135708.258636000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 17:36:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6mpK-0003lp-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 17:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab0D0Pa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 11:30:57 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46594 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643Ab0D0Pa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 11:30:56 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DAA91EAE24;
	Tue, 27 Apr 2010 11:30:55 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 27 Apr 2010 11:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cbqXZVXp64bnLlSTBUa1NXcIyhM=; b=h92N+gA5axUkAToD1CtmePMxIMkPtgwfUQuoCbllpAk9awu28VT4o5585kqdaK1t6hlpva+TIm0lskwsmVV5omWdgDBRSau9aCGuoFwOW9Y77I82jkEGJEvI3XFf79Xh1OUSAFeUJebvbrqNrkwp4a4+XeDcUxrjJJ5Jq54tlm4=
X-Sasl-enc: /U59l0nVpsXw7+Rzn/Qp9rDC2c2A+ZKTOEIOhx9un0Q0 1272382255
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E0071491C8;
	Tue, 27 Apr 2010 11:30:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100427135708.258636000@mlists.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145925>

Gary V. Vaughan venit, vidit, dixit 27.04.2010 15:57:
> Here are the portability patches we needed at TWW to enable git-1.7.1
> to compile and run on all of the wide range of Unix machines we
> support.  These patches apply to the git-1.7.1 release,  and address
> all of the feedback from the previous three times I posted them to
> this list, including fixing the massive testsuite failures I was
> experiencing and taking into account that the ss_family fixes and
> partial GMT_CMP_TEST fixes that have been pushed since my last post of
> this patch queue.

General remark: None of your patches have a s-o-b line. If you want to
have your patches in git you are required to sign-off on them (commit
-s) in order to certify that you can submit them under the license terms
of the project.

Your diff -> test_cmp are certainly something we want to have in any
case. The code changes look ugly, honestly, making the code much less
readable, but it seems to be the only way to make those older platforms
and compilers happy. (Erik pointed out some good ways to reduce the
uglyness somewhat.)

I can't test your target platform, but I would test the impact of the
code and test changes on mine. Do you have your series somewhere to pull
from?

Michael
