From: Jing Xue <jingxue@digizenstudio.com>
Subject: gitk fails to parse git log output in 1.5.3
Date: Sun, 2 Sep 2007 18:31:28 -0400
Message-ID: <20070902223128.GA19198@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 00:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxyn-0004dT-SP
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 00:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXIBWbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbXIBWbh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 18:31:37 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:34879
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750874AbXIBWbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 18:31:37 -0400
Received: (qmail 29049 invoked from network); 2 Sep 2007 22:31:36 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 02 Sep 2007 22:31:36 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id A5DB8100A0D
	for <git@vger.kernel.org>; Sun,  2 Sep 2007 22:31:36 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUGc8R2wazsj for <git@vger.kernel.org>;
	Sun,  2 Sep 2007 18:31:30 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id BBF5C1000A2
	for <git@vger.kernel.org>; Sun,  2 Sep 2007 18:31:30 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 9FA2E7B520; Sun,  2 Sep 2007 18:31:28 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57396>

gitk shows an error "Can't parse git log output: {\x1b[33commit..." at
startup and quits.

Obviously it's because my git-log outputs in color mode. But the same
happens (and git-log still outputs in colors) after I set color.pager=false. 

What am I missing?

Thanks.
-- 
Jing Xue
