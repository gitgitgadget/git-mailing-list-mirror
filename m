From: David Kastrup <dak@gnu.org>
Subject: Multiple branches and git-svn
Date: Wed, 15 Aug 2007 12:17:15 +0200
Message-ID: <864pj16r10.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 12:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILFwl-0007aQ-3M
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 12:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXHOKR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbXHOKRZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 06:17:25 -0400
Received: from main.gmane.org ([80.91.229.2]:43895 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbXHOKRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 06:17:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILFwH-0003Ib-MB
	for git@vger.kernel.org; Wed, 15 Aug 2007 12:17:21 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 12:17:21 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 12:17:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:5FK6Gn8pXUjtAH98JcmWk0JpWf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55891>


After having had several embarrassing occurences with git-svn dcommit,
I think it would not be amiss to mention in the docs just how git-svn
happens to figure out which Subversion remote it is associated with.

One surprising relevation was that this association changed after a
git-rebase.

It may be a general git thing, or it may be git-svn specific, but it
was not exactly what I expected.  And the docs were not really that
helpful.

In particular, man git-svn is completely silent about this.

-- 
David Kastrup
