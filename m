From: Christoph Bartoschek <ponto@pontohonk.de>
Subject: Prevent switching branches when local modifications exist
Date: Thu, 14 Jun 2012 00:52:01 +0200
Message-ID: <h5ina9-g9n.ln1@homer.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 01:00:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SewXy-0004o1-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2FMXAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 19:00:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:47448 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab2FMXAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 19:00:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SewXk-0004Ck-M0
	for git@vger.kernel.org; Thu, 14 Jun 2012 01:00:04 +0200
Received: from p5dc13925.dip.t-dialin.net ([93.193.57.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 01:00:04 +0200
Received: from ponto by p5dc13925.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 01:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5dc13925.dip.t-dialin.net
User-Agent: KNode/4.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199956>

Hi,

how can I prevent that git allows me to switch branches when there are 
uncommited local modifications?

[14.1 (steiner_topo)]$ git checkout -b ergo
Switched to a new branch 'ergo'
[14.1 (ergo)]$ echo blub >> src/invtree.C
[14.1 (ergo)]$ git checkout steiner_topo
M       src/invtree.C
Switched to branch 'steiner_topo'
[14.1 (steiner_topo)]$ 

How can the last checkout be prevented?

-- 
Christoph Bartoschek
