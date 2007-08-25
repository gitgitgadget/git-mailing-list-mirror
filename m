From: Jing Xue <jingxue@digizenstudio.com>
Subject: how do you "force a pull"?
Date: Sat, 25 Aug 2007 07:19:46 -0400
Message-ID: <20070825111946.GA7122@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 13:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOtgP-0002Dn-4M
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 13:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933214AbXHYLT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 07:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764295AbXHYLT5
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 07:19:57 -0400
Received: from k2smtpout02-02.prod.mesa1.secureserver.net ([64.202.189.91]:48275
	"HELO k2smtpout02-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932338AbXHYLT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 07:19:57 -0400
Received: (qmail 10029 invoked from network); 25 Aug 2007 11:19:55 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-02.prod.mesa1.secureserver.net (64.202.189.91) with ESMTP; 25 Aug 2007 11:19:55 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 0E77F100A0F
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 11:19:55 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aSPDsqbYlmDj for <git@vger.kernel.org>;
	Sat, 25 Aug 2007 07:19:47 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 650D8100587
	for <git@vger.kernel.org>; Sat, 25 Aug 2007 07:19:47 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 3AE4E7B51B; Sat, 25 Aug 2007 07:19:46 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56630>

I am working in repo1, and make a savepoint commit and pack up and leave.

On another machine, I have a clone of repo1 (repo2). So I pull from
repo1, "git reset --soft HEAD" to get rid of the savepoint commit, and start working in repo2.

A while later I realize the earlier commit was actually a good commit
point. But I can no longer pull it again from repo1. It keeps giving me
the "Cannot merge" fatal error. "-f" doesn't help.

So in general my question is "how do you force pulling from a remote
repository?"  (short of, you know, recloning the repo...)

I have a feeling that either I'm still stuck in the traditional central-repository
mentality, or missing something real simple.

Thanks.
-- 
Jing Xue
