From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git-am and workflow question
Date: Sun, 11 Feb 2007 00:18:52 +0200
Message-ID: <20070210221852.GC32216@mellanox.co.il>
References: <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 23:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG0Y8-0000jb-M0
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 23:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXBJWSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbXBJWSX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 17:18:23 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:51781 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXBJWSW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 17:18:22 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id ea44ec54.2418367408.26787.00-001.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sat, 10 Feb 2007 15:18:22 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 11 Feb 2007 00:20:34 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 11 Feb 2007 00:16:19 +0200
Content-Disposition: inline
In-Reply-To: <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 10 Feb 2007 22:20:34.0626 (UTC) FILETIME=[AEFBEA20:01C74D61]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14988.001
X-TM-AS-Result: No--6.262800-4.000000-4
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39262>

> My second pass is actually applying the patch by piping each
> e-mail message from my e-mail client to "git am -3 -s", and if I
> do not like something in the patch, I make corrections and then
> run "git commit --amend".

git-commit --amend seems to rewrite the commit author which is
annoying if you only want to modify the log message a little. As a
work-around I copy the author info from the log and passing --author
explicitly, but is there an easier way?


-- 
MST
