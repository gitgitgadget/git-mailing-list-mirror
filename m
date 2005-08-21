From: Johnny Stenback <jst@mozilla.org>
Subject: cg-update question.
Date: Sun, 21 Aug 2005 00:17:42 -0700
Message-ID: <43082A96.1070700@mozilla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 21 09:18:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6k5g-0007bT-Lx
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 09:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVHUHR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHUHR6
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 03:17:58 -0400
Received: from pippin.dreamhost.com ([66.33.211.27]:28603 "EHLO
	pippin.dreamhost.com") by vger.kernel.org with ESMTP
	id S1750814AbVHUHR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 03:17:57 -0400
Received: from [192.168.0.100] (dpc674551026.direcpc.com [67.45.51.26])
	by pippin.dreamhost.com (Postfix) with ESMTP id EA63616D315
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 00:17:50 -0700 (PDT)
User-Agent: Mail/News 1.6a1 (X11/20050816)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all,

I hope it's ok to ask cogito questions on this list...

I just realized that if I've got an uncommitted local change in a tree 
and I update my tree with cg-update to merge in changes from a different 
tree... cg-update will pull the changes and do the merge. So that's all 
cool, but as it does the merge, it will re-write my local file that has 
the uncommitted change, even if that file didn't change in the 
repository I pulled from, i.e. nothing to merge for that file.

This is, to me at least, not the desired behavior, if there's no reason 
for cg-update to touch a file it shouldn't.

Thoughts? If someone points me in the right direction I'm willing to 
take a stab at fixing this myself...

-- 
jst
