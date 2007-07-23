From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: RFC: git pull or git rebase?
Date: Mon, 23 Jul 2007 08:22:23 +0300
Message-ID: <20070723052223.GA20614@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICqNP-0004fj-HS
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 07:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347AbXGWFWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 01:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbXGWFWW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 01:22:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:40056 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbXGWFWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 01:22:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1090117ugf
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 22:22:19 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr3928194ugh.1185168139188;
        Sun, 22 Jul 2007 22:22:19 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id h1sm4956467ugf.2007.07.22.22.22.16
        (version=SSLv3 cipher=OTHER);
        Sun, 22 Jul 2007 22:22:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53392>

Hi!
I'm working on several kernel-related projects at the same time:
- some of them are small, and private, so I do a fetch
  and rebase to update to Linus' code, to keep history clean
- some of them are larger, and involve several other people,
  so I do git pull (the history is messy anyway)

Problem is, I get confused sometimes and do a git pull
instead of git rebase, or vice versa. Of course I can just
reset to ORIG_HEAD when I realise my mistake.

However, I wonder whether this happens to others, too.
Would it make sense to add a branch attribute that says
"do not pull this branch" or "do not rebase this branch"?
Maybe even make git do the right thing automatically,
so that git would look at this attribute and perform
pull or rebase as appropriate?

Thanks,

-- 
MST
