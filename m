From: Bill Lear <rael@zopyra.com>
Subject: Parallel make problem?
Date: Mon, 4 Feb 2008 14:15:49 -0600
Message-ID: <18343.29301.981552.418860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 21:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7jy-0000Uu-Q9
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbYBDUQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYBDUQA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:16:00 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61146 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbYBDUP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:15:59 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m14KFw905960;
	Mon, 4 Feb 2008 14:15:58 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72555>

I just downloaded 1.5.4 and am building with gnu make, passing the '-j5'
flag to invoke multiple jobs.  I get the following:

% make -j5 prefix=/opt/git-1.5.4 all doc info
[...]
make[1]: Entering directory `/home/blear/build/git-1.5.4/Documentation'
rm -f doc.dep+ doc.dep
/usr/bin/perl ./build-docdep.perl >doc.dep+
Writing perl.mak for Git
make -C ../ GIT-VERSION-FILE
mv doc.dep+ doc.dep
make -C ../ GIT-VERSION-FILE
mv doc.dep+ doc.dep
mv: cannot stat `doc.dep+': No such file or directory
[...]

it does not seem to fail from there, but I am concerned that this is
a problem and thought it worth reporting.


Bill
