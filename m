From: lamikr <lamikr@cc.jyu.fi>
Subject: Setting up git server?
Date: Fri, 16 Jun 2006 02:19:04 +0300
Message-ID: <4491EAE8.6090009@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 01:19:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr17K-0005yL-8I
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 01:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWFOXTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFOXTI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 19:19:08 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:18566 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S1750755AbWFOXTG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 19:19:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id k5FNJ4pp016158
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 02:19:04 +0300
Received: from posti5.jyu.fi ([127.0.0.1])
 by localhost (posti5.jyu.fi [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16019-09 for <git@vger.kernel.org>; Fri, 16 Jun 2006 02:19:03 +0300 (EEST)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id k5FNJ2p5016153
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 02:19:03 +0300
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 8B78A468316
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 02:19:05 +0300 (EEST)
User-Agent: Mozilla Thunderbird 1.0.6-7.6.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21922>

Hi

I have git-repo cloned from the linux-omap-2.6 that we have used as a
base for our h6300 development.
Earlier we have kept our kernel in svn (sync between git-branches and
svn has happened about once in a month by using
traditional diff files...)

I have now pulled the server to "/repos/git/linux-omap-h6300-2.6" and
setup the /etc/xinetd.d/git-daemon by using docs in
http://www.kernel.org/pub/software/scm/git/docs/everyday.html

How can I now create the git url for this? For example something like
this: git://aragorn.kortex.jyu.fi/repos/git/linux-omap-h6300-2.6.git

Mika
