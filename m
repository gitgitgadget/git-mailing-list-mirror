From: Steve <shrotty@gmx.ch>
Subject: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 09:50:57 +0000 (UTC)
Message-ID: <loom.20090320T094550-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 10:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkbSv-0005z1-0o
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 10:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbZCTJzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 05:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbZCTJzH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 05:55:07 -0400
Received: from main.gmane.org ([80.91.229.2]:48808 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZCTJzF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 05:55:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LkbRO-0005kD-Pq
	for git@vger.kernel.org; Fri, 20 Mar 2009 09:55:02 +0000
Received: from 172.120.221.87.dynamic.jazztel.es ([87.221.120.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 09:55:02 +0000
Received: from shrotty by 172.120.221.87.dynamic.jazztel.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 09:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.221.120.172 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.0.7) Gecko/2009021906 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113928>

Hi

Using HTTP as transport, I've noticed that after using git-gc on a git server, I
can't push to that repo anymore: "No refs in common and none specified." Client
and server are both 1.6.2. Is ths a bug or do I have to do something after
executing git-gc on the server?

Thanks! Steve
