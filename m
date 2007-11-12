From: David Kastrup <dak@gnu.org>
Subject: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 14:11:58 +0100
Message-ID: <86k5on8v6p.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 14:12:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZ5t-0000ce-3K
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbXKLNMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbXKLNMe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:12:34 -0500
Received: from main.gmane.org ([80.91.229.2]:34589 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294AbXKLNMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:12:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrZ5M-0001xi-9k
	for git@vger.kernel.org; Mon, 12 Nov 2007 13:12:16 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 13:12:16 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 13:12:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:kKh7Dzb2MP6Kji/eiMY+qke3aTE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64618>


Hi,

I have a repository declared as bare.  Some commands treat it as such,
other's don't.  For example, I get

git-diff [no complaint]
git-status
fatal: /usr/local/bin/git-status cannot be used without a working tree.
git-reset [no complaint]
git-reset --hard
HEAD is now at db862c1... installmanager.sh: setze GIT_WORK_TREE
git-commit
fatal: /usr/local/bin/git-commit cannot be used without a working tree.
git-add
fatal: This operation must be run in a work tree

So this is all somewhat inconsistent.  What is the situation supposed
to be?

-- 
David Kastrup
