From: Eli Barzilay <eli@barzilay.org>
Subject: git rev-list formatting
Date: Mon, 22 Mar 2010 07:30:57 -0400
Message-ID: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 12:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntfqp-0000Ir-Mu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0CVLbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:31:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:42233 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab0CVLbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:31:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ntfqg-0000Ck-VG
	for git@vger.kernel.org; Mon, 22 Mar 2010 12:31:11 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 12:31:10 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 12:31:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:0WOF8YTzqK1gDwfwlPrmA4iBUa4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142922>

Possible bug -- IIUC, this:

  git rev-list --pretty="%w(40,2,2)%b" $rev

should show all bodies wrapped as specified, but with 1.7.0.3 I see
only the first one wrapped, and the rest don't show up.  In one of my
attempts to sort this, I saw all bodies, but all bodies after the
first were not wrapped as specified.

Also, is there a way to avoid the "commit <sha1>" line, print some
information that I specify in the format string, and show the whole
message as is (without wrapping or other tweaks)?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
