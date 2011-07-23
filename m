From: Reuben Thomas <rrt@sc3d.org>
Subject: Possible bug
Date: Sat, 23 Jul 2011 21:25:59 +0100
Message-ID: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 22:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkjGB-0001rJ-8q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 22:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263Ab1GWU4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 16:56:37 -0400
Received: from exprod7og108.obsmtp.com ([64.18.2.169]:49475 "HELO
	exprod7og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751186Ab1GWU4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 16:56:36 -0400
X-Greylist: delayed 1834 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jul 2011 16:56:35 EDT
Received: from mail-pz0-f53.google.com ([209.85.210.53]) (using TLSv1) by exprod7ob108.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTis1gxLCQC33Q0NGW3EQexgcKBH3Y5TY@postini.com; Sat, 23 Jul 2011 13:56:36 PDT
Received: by pzk6 with SMTP id 6so7609746pzk.40
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 13:56:35 -0700 (PDT)
Received: by 10.142.171.11 with SMTP id t11mr1840972wfe.224.1311452759757;
 Sat, 23 Jul 2011 13:25:59 -0700 (PDT)
Received: by 10.142.47.20 with HTTP; Sat, 23 Jul 2011 13:25:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177705>

Observe the following exchange with git 1.7.4.1, which I found rather
perplexing:

$ cat ~/reportbug-git
$ git rm -f ../INSTALL
rm 'INSTALL'
$ git ci -m "INSTALL is now provided by gnulib." ../INSTALL
error: pathspec 'ALL' did not match any file(s) known to git.
$ cd ..
$ git ci -m "INSTALL is now provided by gnulib." INSTALL
[master 0895314] INSTALL is now provided by gnulib.
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 120000 INSTALL

Is this a bug, or merely some magic I don't know about?

-- 
http://rrt.sc3d.org
