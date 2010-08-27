From: Stephen Bash <bash@genarts.com>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 12:22:54 -0400 (EDT)
Message-ID: <29718856.121438.1282926174106.JavaMail.root@mail.hq.genarts.com>
References: <4C77DDDC.8070407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dan Loewenherz <dloewenherz@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 27 18:23:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op1hr-0007fr-2A
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 18:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab0H0QXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 12:23:02 -0400
Received: from hq.genarts.com ([173.9.65.1]:34136 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898Ab0H0QXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 12:23:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 34A931E268F5;
	Fri, 27 Aug 2010 12:23:00 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id An5xJNuIQ3ut; Fri, 27 Aug 2010 12:22:54 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 2E5DB1E268EA;
	Fri, 27 Aug 2010 12:22:54 -0400 (EDT)
In-Reply-To: <4C77DDDC.8070407@drmicha.warpmail.net>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154604>


> > I'm using a Mac with a journaled filesystem and Git version 1.7.2.1.
> 
> The journalling is no problem, but HFS is. I'm no Macxpert but if I
> remember correctly, then under HFS "readme" and "README" are the same
> file, i.e. HFS only remembers how you want it spelled. People will
> correct me where I'm wrong.
> 
> Your test script should produce the expected result if you use, say,
> "readme" and "RAEDME" , i.e. names which differ by more than just
> case.

It's a problem on some (most?) Macs.  A while back Apple introduced an option to format a partition as case sensitive (Wikipedia implies 10.3 introduced this feature).  For a long time after the feature was introduced the factory install continued to be not case sensitive, but I don't know if that's still the case (no pun intended).

Stephen
