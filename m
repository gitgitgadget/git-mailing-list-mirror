From: David Kastrup <dak@gnu.org>
Subject: How to stage a tree with all changes?
Date: Wed, 13 Jun 2007 18:22:23 +0200
Message-ID: <861wgf964g.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 18:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVcQ-000210-Ck
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbXFMQWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbXFMQWs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:22:48 -0400
Received: from main.gmane.org ([80.91.229.2]:60191 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbXFMQWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:22:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HyVcI-0006rK-A6
	for git@vger.kernel.org; Wed, 13 Jun 2007 18:22:42 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 18:22:42 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 18:22:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:9YvNjV+/0493hthwQruQzgTm7gM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50089>


Suppose I have a number of changes in a tree: additions, deletions,
renames and so on.

How do I stage and commit all of that?

git-commit -a

omits new files.

git-add .
git-commit -a

seemingly overlooks deletions.

What am I overlooking?  This should be simple, shouldn't it?

-- 
David Kastrup
