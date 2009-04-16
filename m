From: Miles Bader <miles.bader@necel.com>
Subject: renaming remote branches
Date: Thu, 16 Apr 2009 12:27:31 +0900
Message-ID: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 05:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuIHt-0003oI-EF
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 05:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZDPD1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 23:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbZDPD1k
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 23:27:40 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:62586 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZDPD1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 23:27:40 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n3G3RWTx017640;
	Thu, 16 Apr 2009 12:27:32 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Thu, 16 Apr 2009 12:27:32 +0900
Received: from dhlpc061 ([10.114.114.58] [10.114.114.58]) by relay11.aps.necel.com with ESMTP; Thu, 16 Apr 2009 12:27:31 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B66C152E274; Thu, 16 Apr 2009 12:27:31 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116665>

I can "rename" a remote branch by doing:

   git push REMOTE REMOTE/OLD:refs/heads/NEW
   git push REMOTE :OLD

is there any better way to do this (I mean, er... more
user-friendly/less-dangerous/... I dunno... "better" :-)?

Also, I note that the old name ("OLD") remains in .git/info/refs, both
locally and in the remote; is this a problem?  I can update the local
.git/info/refs by running "git update-server-info", but I'm not sure how
to do in for the remote repo without having a login there...

Thanks,

-miles

-- 
Erudition, n. Dust shaken out of a book into an empty skull.
