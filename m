From: John Ellson <ellson@research.att.com>
Subject: BUG:  "rpmbuild -ta cogito-0.12.tar.gz" fails
Date: Wed, 06 Jul 2005 14:40:00 -0400
Message-ID: <dah8i2$c8v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 06 20:41:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqEpq-0007Jz-7u
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 20:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVGFSk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 14:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVGFSk7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 14:40:59 -0400
Received: from main.gmane.org ([80.91.229.2]:48519 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261921AbVGFSkr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 14:40:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DqEoi-00079S-8A
	for git@vger.kernel.org; Wed, 06 Jul 2005 20:40:16 +0200
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 20:40:16 +0200
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 20:40:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"rpmbuild -ta cogito-0.12.tar.gz" fails because cogito.spec.in refers to
".bz2" in its "Source:" line, instead of to ".gz".



This is obviously a trivial patch.  Do I need prior approval to send 
patches to this group?     What is the the significance of 
"Signed-off-by:"     Is there a FAQ I should read?


John
