From: David Fang <fang@csl.cornell.edu>
Subject: git test failure: t9903-bash-prompt.sh on darwin8
Date: Mon, 28 Oct 2013 19:11:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1310281859460.5295@hal-00.csl.cornell.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 00:34:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VawKf-00035v-QH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 00:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686Ab3J1Xep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 19:34:45 -0400
Received: from csl.cornell.edu ([128.84.224.10]:2348 "EHLO
	vlsi.csl.cornell.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540Ab3J1Xep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 19:34:45 -0400
X-Greylist: delayed 1383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2013 19:34:44 EDT
Received: from hal-00.csl.cornell.edu (hal-00.csl.cornell.edu [128.84.224.105])
	by vlsi.csl.cornell.edu (8.13.4/8.13.4) with ESMTP id r9SNBZi8025513
	for <git@vger.kernel.org>; Mon, 28 Oct 2013 19:11:40 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236875>

Hi,
 	I'm seeing a test failure with git-1.8.4 on powerpc-darwin8:

[11:00:56] t9903-bash-prompt.sh ...............................
not ok 13 - prompt - interactive rebase
not ok 14 - prompt - rebase merge

Details here:

http://paste.lisp.org/display/139525

The odd thing is that when I run the test t9903 interactively, 
post-mortem, it passes -- I am unable to reproduce the failure outside of 
the unprivileged build environment.
Interactively, the test always passes regardless of my interaction shell: 
csh, sh-2.0, bash-4.2.  (Noninteractive test happens to use bash-2.0.)

So I force the test to halt immediately upon failure to examine the 
temporary trash directory, and the difference between actual/expected:

http://paste.lisp.org/display/139525#4

What could cause the results to differ between by interactive and 
non-interactive testing of t9903?  Is there a real problem?

Fang


-- 
David Fang
http://www.csl.cornell.edu/~fang/
