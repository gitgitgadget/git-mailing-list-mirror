From: Richard Purdie <rpurdie@rpsys.net>
Subject: git pull fails with http urls?
Date: Tue, 04 Sep 2007 15:10:53 +0100
Message-ID: <1188915053.5705.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZj7-0001ta-5z
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbXIDOt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbXIDOt4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:49:56 -0400
Received: from tim.rpsys.net ([194.106.48.114]:40040 "EHLO tim.rpsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbXIDOtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:49:55 -0400
X-Greylist: delayed 2332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2007 10:49:55 EDT
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l84EB2vg015074
	for <git@vger.kernel.org>; Tue, 4 Sep 2007 15:11:02 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 14922-03 for <git@vger.kernel.org>; Tue,  4 Sep 2007 15:10:58 +0100 (BST)
Received: from [192.168.1.15] (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l84EAsFJ015068
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 4 Sep 2007 15:10:54 +0100
X-Mailer: Evolution 2.10.1 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57586>

I've noticed a problem with pulling http urls. I can clone them fine:

  git clone http://www.gnome.org/~alexl/git/gio.git/

and I can pull with:

  git pull

which works as expected however if I try:

  git pull http://www.gnome.org/~alexl/git/gio.git/

it fails with:

  error: pick-rref: HEAD not found
  No such ref HEAD at http://www.gnome.org/~alexl/git/gio.git/

The HEAD file is there at http://www.gnome.org/~alexl/git/gio.git/HEAD
and:

  git pull http://www.gnome.org/~alexl/git/gio.git/ master

works. It seems git just doesn't want to see/understand the HEAD file?

Is the above supposed to work or is something wrong with the above
commands? I see this with git 1.5.2.3 and 1.5.3, google suggests this
might have worked with 1.4.x and broke in 1.5...

Regards,

Richard
