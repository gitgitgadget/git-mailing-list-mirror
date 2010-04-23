From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: diff without num-stat
Date: Fri, 23 Apr 2010 10:14:48 +0200
Message-ID: <4BD156F8.5090307@drmicha.warpmail.net>
References: <19408.40250.102191.314496@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri Apr 23 10:18:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5E5N-00013h-AF
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 10:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab0DWIR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 04:17:58 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35212 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753986Ab0DWIR5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 04:17:57 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A790EEB1F8;
	Fri, 23 Apr 2010 04:17:56 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 23 Apr 2010 04:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0F4a2Vsyr4Ma7RmDwPu5b7ZHoM8=; b=s1mxDrQApeNoNr/AmQMcMfkAqS2wmKtCJMoY+Uk1Xbn+tsrmNbyldcHnmxlM1DT4MPDPMmwfcE6YZ0BTsjl+ZYgUz30a+Ozsg/91+/9m8NfgPEFdcULr+lWNPRffwWO1WKkbKkMPttiV/VMMXZIDWD2dRfeAvGLZhne9e2w8AOw=
X-Sasl-enc: r3mikuq8zBxPcThFwnoNJEUVMxlK8f37ODqxM68LvKbb 1272010676
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1ED104D7CA0;
	Fri, 23 Apr 2010 04:17:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <19408.40250.102191.314496@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145595>

Eli Barzilay venit, vidit, dixit 22.04.2010 21:02:
> `git diff' has a `--numstat' flag, but is there any way to *avoid* the
> numstat?  (I'm using `--stat' but want to void the summary line, and
> I'd like to avoid piping it to `head'.)

So, what DO you want? Except for the different formatting:

--stat output minus --numstat output == summary line

where "summary line" is something like

5 files changed, 5974 insertions(+), 0 deletions(-)

Do you want to (a)void the numstat or the summary?

Michael
