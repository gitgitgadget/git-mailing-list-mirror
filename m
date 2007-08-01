From: David Kastrup <dak@gnu.org>
Subject: git-commit --amend -m "..." complains?!?
Date: Wed, 01 Aug 2007 16:25:16 +0200
Message-ID: <86643znxgz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 16:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGFIw-0002HZ-8A
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 16:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbXHAOf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 10:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbXHAOf7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 10:35:59 -0400
Received: from main.gmane.org ([80.91.229.2]:39425 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbXHAOf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 10:35:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IGFDI-0002zg-Tz
	for git@vger.kernel.org; Wed, 01 Aug 2007 16:30:12 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 16:30:12 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 16:30:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:9EAbL5HwRsI6Zrw6ZqnmSdu+GYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54441>


I get

Option -m cannot be combined with -c/-C/-F/--amend.

but that makes no sense: of course there is ample reason for providing
an amended commit message on the command line.  -c, -C and -F indeed
all provide an alternative commit message, but --amend doesn't.

So what is the beef?

-- 
David Kastrup
