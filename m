From: Jing Xue <jingxue@digizenstudio.com>
Subject: git-svn error when cloning apache repo
Date: Sat, 15 Sep 2007 19:08:33 -0400
Message-ID: <20070915230833.GA8525@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWgtk-0003sm-7g
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbXIOXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 19:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbXIOXRz
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:17:55 -0400
Received: from k2smtpout05-02.prod.mesa1.secureserver.net ([64.202.189.57]:59889
	"HELO k2smtpout05-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752643AbXIOXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:17:54 -0400
Received: (qmail 5368 invoked from network); 15 Sep 2007 23:17:54 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-02.prod.mesa1.secureserver.net (64.202.189.57) with ESMTP; 15 Sep 2007 23:17:53 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 15332100A33
	for <git@vger.kernel.org>; Sat, 15 Sep 2007 23:08:40 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H4OrDwbldT3T for <git@vger.kernel.org>;
	Sat, 15 Sep 2007 19:08:34 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 352FD100A0B
	for <git@vger.kernel.org>; Sat, 15 Sep 2007 19:08:34 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 250657B520; Sat, 15 Sep 2007 19:08:33 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58276>

I'm trying to clone the Apache Ivy repo and got this error. What does
the "Using higher level of URL" mean?  Also, of course, what does the
error message mean?

$ git svn clone https://svn.apache.org/repos/asf/incubator/ivy/core/ ivy-core -T trunk -b branches -t tags
Initialized empty Git repository in .git/
Using higher level of URL: https://svn.apache.org/repos/asf/incubator/ivy/core => https://svn.apache.org/repos/asf
W: Ignoring error from SVN, path probably does not exist: (175002): RA layer request failed: REPORT request failed on '/repos/asf/!svn/bc/100': REPORT of '/repos/asf/!svn/bc/100': Could not read chunk size: Secure connection truncated (https://svn.apache.org)
branch_from: /incubator/ivy/tags => /incubator/ivy/tags/1.4.1
Found possible branch point: https://svn.apache.org/repos/asf/incubator/ivy/tags/1.4.1 => https://svn.apache.org/repos/asf/incubator/ivy/core/tags/1.4.1, 499505
Initializing parent: tags/1.4.1@499505
Found possible branch point: https://svn.apache.org/repos/asf/incubator/ivy/trunk => https://svn.apache.org/repos/asf/incubator/ivy/tags/1.4.1, 488008
Initializing parent: tags/1.4.1@488008
RA layer request failed: REPORT request failed on '/repos/asf/!svn/vcc/default': REPORT of '/repos/asf/!svn/vcc/default': 400 Bad Request (https://svn.apache.org) at /home/jingxue/bin/git-svn line 3155

Any thoughts are appreciated.

Thanks.
-- 
Jing Xue
