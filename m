From: Uwe Kleine-Koenig <ukleinek@informatik.uni-freiburg.de>
Subject: git log -p file.c
Date: Thu, 14 Jun 2007 11:02:17 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070614090217.GA8271@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 11:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HylDm-000085-94
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 11:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbXFNJCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 05:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbXFNJCX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 05:02:23 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:56304 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbXFNJCW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2007 05:02:22 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HylDg-0006ae-JN
	for git@vger.kernel.org; Thu, 14 Jun 2007 11:02:20 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l5E92Ia1008492
	for <git@vger.kernel.org>; Thu, 14 Jun 2007 11:02:18 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l5E92HmL008491
	for git@vger.kernel.org; Thu, 14 Jun 2007 11:02:17 +0200 (MEST)
Mail-Followup-To: Uwe Kleine-Koenig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50182>

hello,

when I run

	git log -p file.c

I don't get the complete change a commit introduces but only how file.c
changed.  This is kind of surprising for me, I had expected to get the
whole diff.

Reading git-log(1), -p should "Show the change the commit introduces in
a patch form."  It's not 100% clear, but as I understand it, this means
the whole patch should be shown?

And is it intended that (clean) merges are shown?

Best regards
Uwe

PS: I currently have only very limited access to the internet, so the
version used is 1.5.2.1.133.gd44c7.  Sorry if that issue is already
resolved :-)

-- 
Uwe Kleine-Koenig

http://www.google.com/search?q=gigabyte+in+bit
