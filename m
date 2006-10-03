From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH 0/2] Some StGit improvement
Date: Tue, 03 Oct 2006 23:07:24 +0200
Message-ID: <20061003213025.8F18028AF4@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 03 23:30:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUrq6-000278-Ci
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 23:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWJCVaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 17:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbWJCVaG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 17:30:06 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7966 "EHLO torino.dewire.com")
	by vger.kernel.org with ESMTP id S1030557AbWJCVaD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 17:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id A081280286A
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:27:09 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22597-06 for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:27:09 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 62BA8800782
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:27:09 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 00E8028F58
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:30:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id lucd+YcnbppO for <git@vger.kernel.org>;
	Tue,  3 Oct 2006 23:30:25 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8F18028AF4
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:30:25 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28303>

Here are some small improvements I made to the wonderful StGIT. 
The first one is a new command to do the popping and pushing
necessary to float a patch to the top of the stack. 

The second is a small improvement to change the [PATCH] prefix 
to identify what the patch is for. In this case StGIT.

The third one makes the --cover work. There are some usability
issues with --cover, but at least it works now.

-- robin
