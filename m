From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git guidance
Date: Thu, 29 Nov 2007 10:52:20 -0500
Message-ID: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 16:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixlgx-0007AQ-3i
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 16:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757003AbXK2PwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbXK2PwX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 10:52:23 -0500
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:39352
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755917AbXK2PwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 10:52:22 -0500
Received: (qmail 14917 invoked from network); 29 Nov 2007 15:52:21 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 29 Nov 2007 15:52:21 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 87F7F100A37;
	Thu, 29 Nov 2007 15:52:21 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qjF2DGIgCWRB; Thu, 29 Nov 2007 10:52:20 -0500 (EST)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id C7D19100A8F; Thu, 29 Nov 2007 10:52:20 -0500 (EST)
Received: from mailrelay2.private.geico.com (mailrelay2.private.geico.com
	[205.143.204.198]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Thu, 29 Nov 2007 10:52:20 -0500
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66542>


Quoting Al Boldi <a1426z@gawab.com>:

> Sure, browsing is the easy part, but Version Control starts when things
> become writable.

But how is that supposed to work?  What happens when you make some
changes to a file and save it?  Do you want the "git file system" to
commit it right aways or wait until you to issue a "commit" command?
The first behavior would obviously be wrong, and the second would make
the "file system" not operationally transparent anyways. Right?

By the way, the only SCM I have worked with that tries to mount its
repository (or a view on top of it) as a file system is ClearCase with
its dynamic views. And, between the buggy file system implementation,
the intrusion on workflow, and the lack of scalability, at least in
the organization I worked for, it turned out to be a horrible,
horrible, horrible idea.

Cheers.
-- 
Jing Xue
