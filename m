From: John Goerzen <jgoerzen@complete.org>
Subject: git-email automatic --to detection?
Date: Sun, 24 Feb 2008 16:29:56 -0600
Message-ID: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 23:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPNL-0006Xo-33
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYBXWaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbYBXWaP
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:30:15 -0500
Received: from main.gmane.org ([80.91.229.2]:53911 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbYBXWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:30:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JTPMK-00087E-B2
	for git@vger.kernel.org; Sun, 24 Feb 2008 22:30:12 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 22:30:12 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 22:30:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74972>

One of my favorite features of Darcs is that users can submit patches
by typing:

  darcs send -a

This will look at the repo the local copy was cloned from, find all
local changesets that aren't on the remote, and email off a set of
patches to the remote maintainer.  It finds the email address to send
to by looking at _darcs/prefs/email *on the remote*, which is roughly
the same as setting an option in .git/config.

There are a couple of nice things about this:

1) Patch submitters don't have to keep track of where to send patches
for each project they work on

2) Potential submitters don't have to be notified if the submission
address changes

As far as I can tell from looking at git-send-email(1),
git-format-patch(1), and git-config(1), git doesn't have this
capability.  Is that correct?  If so, is it possible to add something
like this?  Would it also be possible to unify git-format-patch and
git-send-email into a single command that generates and sends the patch(es)?

Thanks,

-- John
