From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 18:32:13 +0100
Message-ID: <491B131D.2050501@drmicha.warpmail.net>
References: <80wsf9ovsp.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:33:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Jav-0007Pw-TZ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYKLRcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbYKLRcS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:32:18 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51889 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368AbYKLRcS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 12:32:18 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id EF0671ACCC2;
	Wed, 12 Nov 2008 12:32:16 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 12 Nov 2008 12:32:16 -0500
X-Sasl-enc: 8sdUJkTgb3AG0BXZMP9s2gqtwqnm8XnOM3VbP8p5PRZd 1226511136
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 46C0E2A573;
	Wed, 12 Nov 2008 12:32:16 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <80wsf9ovsp.fsf@tiny.isode.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100778>

Bruce Stephens venit, vidit, dixit 12.11.2008 15:36:
> The following works fine with 1.6.0.2 and before, but not 1.6.0.3 or
> later:
> 
> 	git clone -n git git-test
>         cd git-test
>         git checkout -b work v1.6.0.2
> 
> When it breaks, the error is:
> 
> 	error: Entry '.gitignore' would be overwritten by merge. Cannot merge.
> 
> I'm guessing it's a bug rather than a deliberate change?

Bisecting gives:


5521883490e85f4d973141972cf16f89a79f1979 is first bad commit
commit 5521883490e85f4d973141972cf16f89a79f1979
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Sep 7 19:49:25 2008 -0700

    checkout: do not lose staged removal

CCing Junio...

Michael
