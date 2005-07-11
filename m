From: Marc Singer <elf@buici.com>
Subject: git clone rsync:... ?
Date: Mon, 11 Jul 2005 14:30:50 -0700
Message-ID: <20050711213050.GA18693@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 11 23:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds5w1-00082K-Lf
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 23:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVGKVes (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 17:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVGKVdc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 17:33:32 -0400
Received: from florence.buici.com ([206.124.142.26]:47766 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262761AbVGKVav
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 17:30:51 -0400
Received: (qmail 18754 invoked by uid 1000); 11 Jul 2005 21:30:50 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  elf@florence /git > git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
  defaulting to local storage area
  ssh: rsync: Name or service not known
  fatal: unexpected EOF

I've read several messages that this is changing, but it still isn't
clear where we should be starting.  Moreover, I'd like to be able to
keep one repo that is just pulling from the net and then clone it for
different working directories.  Why?  Sometimes, in my ignorance, I
break my working repo.  It's handy to have one that I know is OK
without pulling from the net each time.
