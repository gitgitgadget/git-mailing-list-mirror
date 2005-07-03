From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 3 Jul 2005 17:40:49 +0200
Message-ID: <20050703154049.GD18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz> <42C7D925.2070007@didntduck.org> <20050703154127.GA31848@pasky.ji.cz>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 17:58:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp6qV-00027q-1L
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 17:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVGCP5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGCP5R
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 11:57:17 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:16576 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261469AbVGCP5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 11:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 78A3733ED8
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 17:57:13 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 86B4533EC9
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 17:57:11 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 6DF4F4C0D1
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 17:57:11 +0200 (CEST)
Received: (qmail 10857 invoked by uid 500); 3 Jul 2005 15:40:49 -0000
To: Petr Baudis <pasky@suse.cz>
Mail-Followup-To: Petr Baudis <pasky@suse.cz>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703154127.GA31848@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 03, 2005 at 05:41:27PM +0200, Petr Baudis wrote:
> That's right. Well, for everything but the short id matching we could
> just check the ID validity by git-rev-parse instead of peeking into
> the object store - I just did that. 

Why not use it to actually resolve ids ?
I really miss the '^' parent notation in cogito.

skimo
