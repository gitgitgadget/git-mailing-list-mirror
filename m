From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] Improve end-of-file detection in DirCache
Date: Mon, 13 Apr 2009 13:53:00 +0200
Message-ID: <200904131353.00738.robin.rosenberg.lists@dewire.com>
References: <1239205852-28138-1-git-send-email-robin.rosenberg@dewire.com> <1239290899-24589-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtKkN-0001DJ-59
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbZDMLxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZDMLxJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:53:09 -0400
Received: from mail.dewire.com ([83.140.172.130]:2619 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbZDMLxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:53:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AD88E14915BC;
	Mon, 13 Apr 2009 13:53:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUALiKk4ImtU; Mon, 13 Apr 2009 13:53:02 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3E0DE148897B;
	Mon, 13 Apr 2009 13:53:02 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1239290899-24589-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116433>


As a consequence, I'll reapply the GitMoveDeleteHook reverts we made just
prior to 0.4 and start deprecating GitIndex. Any preference for re-apply or
reverting the reverts?

The reverts are in  e7307f14c531d52cf231c39d844841c4adaf5e5a and 
2066e55e4740d9e9cfaf455596f832ff694f853a

I think the original patches are valid.

-- robin
