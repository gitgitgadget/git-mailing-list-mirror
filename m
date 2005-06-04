From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: SSH pull problems
Date: Sat, 04 Jun 2005 15:05:26 +0200
Message-ID: <42A1A716.9030304@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 04 15:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeYIC-0003rY-So
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 15:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFDNFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 09:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFDNFh
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 09:05:37 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:20371 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261340AbVFDNFd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 09:05:33 -0400
Received: (qmail 15732 invoked from network); 4 Jun 2005 13:05:27 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 4 Jun 2005 13:05:27 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id EC7D659C23A
	for <git@vger.kernel.org>; Sat,  4 Jun 2005 15:05:26 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I had some problems today with git+ssh protocol.
First, when using cg-clone, it couldn't execute cg-rpush, although it's
there in /usr/local.
Maybe that has something to do with that being added to the path in
/etc/profile.

Second, I don't know how to specify the port number,
the typical notation of git+ssh://xyz:port/repo didn't work.

Anybody knows what to do with these?
SSH would be very useful for me if it worked right.

AstralStorm
