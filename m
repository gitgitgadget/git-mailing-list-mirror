From: Andi Kleen <andi@firstfloor.org>
Subject: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 19:46:56 +0200
Message-ID: <20080822174655.GP23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 19:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWahy-00064h-Oa
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbYHVRow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYHVRow
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:44:52 -0400
Received: from one.firstfloor.org ([213.235.205.2]:49884 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbYHVRov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:44:51 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 2A97518900B8; Fri, 22 Aug 2008 19:46:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93333>


A common use case for git here is to just use it as a code 
downloader without actually changing anything in the main branch.

Especially in Linux kernel land there seem to be quite a few tree
which are frequently rebased, which means that the usual "git pull -u"
usually leads to conflicts even when one hasn't changed anything
at all and just wants the latest state of that tree.

I found this initially quite frustrating ("$@#!-git cannot 
even download new trees"), until I managed to
script the necessary magic incarnations after some
documentation study (which are quite a handfull to type manually). 

But I presume that's a reasonable common usage. Would it 
make sense to have some standard git sub command that does that? 
("get latest state of remote branch, doing what it takes to get it")
Or is there already one that I missed?

Thanks,
-Andi

-- 
ak@linux.intel.com
