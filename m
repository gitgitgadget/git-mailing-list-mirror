From: Eli Barzilay <eli@barzilay.org>
Subject: Feature Request: raw body in format strings
Date: Mon, 22 Mar 2010 23:28:44 -0400
Message-ID: <m3wrx3ogwj.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 04:29:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntuni-0007wr-39
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 04:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab0CWD27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 23:28:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:47350 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0CWD27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 23:28:59 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NtunZ-0007v4-GS
	for git@vger.kernel.org; Tue, 23 Mar 2010 04:28:57 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 04:28:57 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 04:28:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:BleyL8s6dXOY7Wt/IQBtf2fdZic=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142987>

I've asked here whether there is any way to get the full content of a
commit in a format string and got no replies.  What I want is close to
"%s%b" except that "%s" will be the first paragraph wrapped into a
single line.

Looking at the code I see that there is no way to get that, but it's
really easy to add it.  Does it make sense to do so?  I have a change
that adds a "%B" that does just that, and it seems that it works fine.
(But I don't know what's the procedure for sending patches.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
