From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Recover from a bad push in StGit
Date: Sat, 19 Aug 2006 00:30:46 +0200
Organization: Dewire
Message-ID: <200608190030.47257.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 19 00:31:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GECs5-0006I3-9g
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 00:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWHRWa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 18:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWHRWa6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 18:30:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9560 "EHLO torino.dewire.com")
	by vger.kernel.org with ESMTP id S964844AbWHRWa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 18:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 4DE5780284A
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 00:28:42 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22337-04 for <git@vger.kernel.org>; Sat, 19 Aug 2006 00:28:41 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id E7B678027E1
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 00:28:39 +0200 (CEST)
To: git <git@vger.kernel.org>
User-Agent: KMail/1.9.4
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25700>

Hi,

I recently did some reordering of patches and goofed up (not totally, but 
anyway). I pushed a number of patches and forgot one in the middle resulting 
in a merge  conflict. Pop won't work since I have local changes from the 
conflict and I don't want to resolve the conflict either since I didn't mean 
to push the patch at that point.

Is there a simple way of undoing a bad push? 

In this case I had a fresh export do help me out so I could just delete the 
patches and re-import them again, but what if I didn't?

-- robin
