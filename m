From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git log missing last line of output
Date: Wed, 27 May 2009 17:42:40 +0200
Message-ID: <4A1D5F70.4030101@drmicha.warpmail.net>
References: <gvhrtf$vpr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed May 27 17:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9LHl-0006HF-Ip
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 17:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760177AbZE0Pmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759797AbZE0Pmz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 11:42:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43896 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759731AbZE0Pmy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 11:42:54 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0D2B8345B21;
	Wed, 27 May 2009 11:42:56 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 27 May 2009 11:42:56 -0400
X-Sasl-enc: E9igamo2Vu3dz6625qFtZ5ejJiYI1NNdaUOiV4ZJlRek 1243438975
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 630F5326AE;
	Wed, 27 May 2009 11:42:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <gvhrtf$vpr$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120072>

Neal Kreitzinger venit, vidit, dixit 27.05.2009 00:57:
> Git log is not displaying the last line of output (for a plain "$ git log" 
> the last line of output should be the title line of the initial commit). 

It should be the last line of the commit message, which is the "title
line" (subject) if and only if the message consists of the subject line
only.

> (I'm using git 1.5.5.6 on rhel 5.3.)  This missing last line also occurs 
> with "git log --since" in which the last line of output should be the title 
> line of the first commit after the specified date, but it is missing in this 
> scenario also.  I've searched the release notes for 1.5.6 thru 1.6.3.1 and 
> did not find this mentioned.  Does this also happen in newer versions of git 
> after 1.5.5.6?

I can't reproduce this with git 1.5.5.6 (vanilla, not rhel). Do you have
a minimal reproducible test case?

Michael
