From: Eli Barzilay <eli@barzilay.org>
Subject: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 05:12:38 -0400
Message-ID: <19402.52486.274010.66636@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 18 11:12:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3QYi-0000z5-Bf
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 11:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab0DRJMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 05:12:40 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:57255 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab0DRJMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 05:12:39 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O3QYQ-0003Qi-9F
	for git@vger.kernel.org; Sun, 18 Apr 2010 05:12:38 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145218>

Is there a way to have *no* default or some invalid default for the
name/email -- something that will make git refuse to create a commit?

For example, I'd be happy if I could put this in my global config:

  [user]
    name = "Eli Barzilay"
    email = "-"

and then have git barf at me when I try to commit with these settings,
since I prefer being forced to set the appropriate address for each
repository rather than deal with the alternative confusion (or just
accepting the limitations and always using the same name/email).

[When I tried to see if it's possible I was surprised to see that git
happily creates commits for "- <->" and even " <>".]

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
