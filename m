From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Add interactive patch menu help scrolled away if hunk is long
Date: Wed, 7 Sep 2011 12:43:52 +0000 (UTC)
Message-ID: <loom.20110907T143944-529@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 19:17:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LkF-0003Jk-OX
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab1IGRQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 13:16:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:44900 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab1IGRQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 13:16:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R1HU7-0005yj-8P
	for git@vger.kernel.org; Wed, 07 Sep 2011 14:44:07 +0200
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 14:44:07 +0200
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 14:44:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20100101 Firefox/6.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180875>

Hi,

when using git add -i, selecting the patch functionality, git shows the
  Stage this hunk [y,n,q,a,d,/,K,j,J,g,s,e,?]?
question for each hunk.

Apparently the '?' entry meant to show help is not very useful when the hunk is
long since the help is scrolled away as the hunk is reprinted.

Probably it would be better not to reprint the hunk when '?' is selected.

Sergio
