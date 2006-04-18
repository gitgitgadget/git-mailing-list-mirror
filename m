From: David Woodhouse <dwmw2@infradead.org>
Subject: Clone with local alternates?
Date: Wed, 19 Apr 2006 00:48:51 +0100
Message-ID: <1145404132.16166.97.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 19 01:48:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVzw7-0006GS-V5
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 01:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWDRXsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 19:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDRXsp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 19:48:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34787 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750837AbWDRXso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 19:48:44 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FVzw3-00018h-46
	for git@vger.kernel.org; Wed, 19 Apr 2006 00:48:43 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18885>

Often I want to clone a remote repository but would like to use an
existing local source tree as 'alternates'. 

One way of doing this is to clone the local tree with 'git-clone -l -s',
find the latest common commit shared with the remote tree to be fetched,
revert to that with 'git-reset --head $last' and then pulling from the
remote. 

Is that _really_ the best way of doing it though? It would be better if
we just had a '--local-alternates=/foo' option to git-clone when cloning
a remote repository.

-- 
dwmw2
