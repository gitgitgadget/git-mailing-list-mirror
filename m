From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: git grep in .
Date: Tue, 20 Jun 2006 18:08:36 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060620160836.GA20153@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 20 18:08:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsimQ-0003da-7B
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 18:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWFTQIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 12:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWFTQIj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 12:08:39 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:20713 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751375AbWFTQIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 12:08:38 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FsimK-0002nK-Hn
	for git@vger.kernel.org; Tue, 20 Jun 2006 18:08:36 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5KG8aM20283
	for git@vger.kernel.org; Tue, 20 Jun 2006 18:08:36 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22210>

Hello,

git grep behaves wrongly if I give it . as path to search in.

E.g.

	uzeisberger@io:~/gsrc/git$ git version
	git version 1.4.0

	uzeisberger@io:~/gsrc/git$ git grep git-grep 
	.gitignore:git-grep
	Documentation/git-grep.txt:git-grep(1)
	Documentation/git-grep.txt:git-grep - Print lines matching a pattern
	Documentation/git-grep.txt:'git-grep' [--cached]
	Documentation/git.txt:gitlink:git-grep[1]::
	Makefile:       git-grep$X git-add$X git-rm$X git-rev-list$X \
	builtin-grep.c:"git-grep <option>* <rev>* [-e] <pattern> [<path>...]";

	uzeisberger@io:~/gsrc/git$ git grep git-grep .

	uzeisberger@io:~/gsrc/git$ 

I'd expect that `git grep git-grep .` gives the same results as `git
grep git-grep`.

Best regards
Uwe

-- 
Uwe Zeisberger

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
