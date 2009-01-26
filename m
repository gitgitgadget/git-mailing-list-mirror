From: Peter Simons <simons@cryp.to>
Subject: Emacs git-mode feature request: support fill-paragraph correctly
Date: Mon, 26 Jan 2009 12:57:39 +0100
Organization: private
Message-ID: <87tz7mth3g.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ7s-00063z-N7
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbZAZL54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZAZL5z
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:57:55 -0500
Received: from main.gmane.org ([80.91.229.2]:60664 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZAZL5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:57:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LRQ6E-00007P-2I
	for git@vger.kernel.org; Mon, 26 Jan 2009 11:57:54 +0000
Received: from p54bd1659.dip0.t-ipconnect.de ([84.189.22.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:57:54 +0000
Received: from simons by p54bd1659.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 11:57:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bd1659.dip0.t-ipconnect.de
Cancel-Lock: sha1:jAJlbYsG110+UquRfWq/tllFjmk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107202>

Hi,

when I choose to commit in Emacs' git mode, I'm prompted to enter a
commit message in a buffer that looks something like this:

   Author: Joe Doe <joe.doe@example.org>
   --- log message follows this line ---
   foo.txt: lots of important changes

Now, when I hit M-q (fill-paragraph), Emacs doesn't recognize that
the "--- log message ..." line ought to be considered a paragraph
separator. As a result, the re-filled buffer is messed up:

   Author: Joe Doe <joe.doe@example.org> --- log message follows
   this line --- foo.txt: lots of important changes

Other modes, such as message-mode, do support that kind of thing
correctly, so apparently it is possible to configure what the editor
considers as a paragraph. Is there some Emacs wizard out there who'd
be kind enough to improve git-mode accordingly?

Take care,
Peter
