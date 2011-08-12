From: Fabricio Nascimento <fabriciosn@gmail.com>
Subject: [BUG] Git won't commit
Date: Fri, 12 Aug 2011 10:13:45 -0700 (PDT)
Message-ID: <1313169225059-6681082.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 19:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrvIt-0008HL-6k
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 19:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1HLRNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 13:13:46 -0400
Received: from sam.nabble.com ([216.139.236.26]:48804 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab1HLRNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 13:13:45 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <fabriciosn@gmail.com>)
	id 1QrvIn-0001yu-27
	for git@vger.kernel.org; Fri, 12 Aug 2011 10:13:45 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179236>

Hello Everybody,

Hope this is the right place to send this bug report.

It just appeared today, last time I've made a successful commit was 3 days
ago. Now every commit, in no matter which repository I have (I've tried old
ones, cloned today, github ones etc) fails with the following message.

[master 09-mapas] git commit
fatal: could not read 'template': No such file or directory

It happens both with the stock git binary that came with Xcode 4.1 on OSX
Lion (1.7.4.4) [/usr/local/bin/git], and the homebrew version (1.7.6)
[/usr/bin/git].

I haven't changed much of my system during those days besides installing
macports and tinycdb (with ports). Don't see any close relation, both
tinycdb and macports were removed.

Curiously, it works well with the git binary that comes with Github.app for
mac, whose version is 1.7.4.



--
View this message in context: http://git.661346.n2.nabble.com/BUG-Git-won-t-commit-tp6681082p6681082.html
Sent from the git mailing list archive at Nabble.com.
