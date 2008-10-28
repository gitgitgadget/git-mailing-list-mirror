From: Jing Xue <jingxue@digizenstudio.com>
Subject: Any way to amend AuthorDate?
Date: Tue, 28 Oct 2008 16:06:22 -0400
Message-ID: <20081028200622.GB6810@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 00:04:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuxbS-0008PA-R4
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 00:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYJ1XCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbYJ1XCp
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:02:45 -0400
Received: from k2smtpout03-01.prod.mesa1.secureserver.net ([64.202.189.171]:34505
	"HELO k2smtpout03-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752567AbYJ1XCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:02:44 -0400
X-Greylist: delayed 6181 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Oct 2008 19:02:44 EDT
Received: (qmail 18022 invoked from network); 28 Oct 2008 20:06:28 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-01.prod.mesa1.secureserver.net (64.202.189.171) with ESMTP; 28 Oct 2008 20:06:27 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id D687B100A22
	for <git@vger.kernel.org>; Tue, 28 Oct 2008 20:06:27 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnayHk-0cW3z for <git@vger.kernel.org>;
	Tue, 28 Oct 2008 16:06:23 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-141-25.dc.dc.cox.net [70.174.141.25])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 17061100A0F
	for <git@vger.kernel.org>; Tue, 28 Oct 2008 16:06:23 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 2429A48E9A; Tue, 28 Oct 2008 16:06:22 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99329>

Is there any way to amend a commit and change only the Author Date?

For instance, I have a binary file that's been checked in in two
consecutive commits. After squashing them into one, the new commit would
keep the timestamp of the earlier one of the two original commits. I
would like it to have either the later timestamp or whenever the squash
happens.

Thanks for any pointers.
-- 
Jing Xue
