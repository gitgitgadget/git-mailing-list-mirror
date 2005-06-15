From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: git pull problem
Date: Tue, 14 Jun 2005 23:19:03 -0500
Message-ID: <200506142319.03537.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 15 06:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiPIL-0004rA-13
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 06:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVFOETU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 00:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFOETU
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 00:19:20 -0400
Received: from smtp821.mail.sc5.yahoo.com ([66.163.171.7]:30067 "HELO
	smtp821.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261486AbVFOETQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 00:19:16 -0400
Received: (qmail 68406 invoked from network); 15 Jun 2005 04:19:12 -0000
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@68.72.34.173 with login)
  by smtp821.mail.sc5.yahoo.com with SMTP; 15 Jun 2005 04:19:12 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I was trying to do:

	git-pull-script rsync://www.kernel.org/pub/scm/git/git.git

And got the following response:

...
fe/ca5e9b7c86b1aaa5903f1c2ca3afde09531c7b

sent 3804 bytes  received 468743 bytes  85917.64 bytes/sec
total size is 4930906  speedup is 10.43
Updating from 98a96b00b88ee35866cd0b1e94697db76bd5ddf9 to ce30a4b68ac220a2322dfe2a182194910143fafd.
fatal: git diff header lacks filename information (line 846)

Last time I did a pull and rebuild was on June 9th:

[dtor@anvil git]$ ls -la ~/bin/git-pull-script
-rwxr-xr-x  1 dtor dtor 425 Jun  9 01:08 /home/dtor/bin/git-pull-script

Just FYI.

-- 
Dmitry
