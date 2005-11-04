From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 16:47:20 +0100
Message-ID: <1131119240.11673.6.camel@localhost.localdomain>
References: <1131008187.6634.14.camel@localhost.localdomain>
	 <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Fri Nov 04 16:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY3mw-0003vw-4I
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbVKDPrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161148AbVKDPrY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:47:24 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:48527 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1161145AbVKDPrW
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 10:47:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jA4FlLGB032248
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 4 Nov 2005 16:47:21 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzkl3yl0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
X-Virus-Scanned: ClamAV 0.85.1/1162/Thu Nov  3 18:15:03 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11135>

Hi Thomas,

> > # cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> > defaulting to local storage area
> > 09:53:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
> > Getting alternates list
> > Getting pack list
> > error: The requested URL returned error: 404
> 
> That repository is packed but lacks objects/info/packs file.
> Perhaps you need to ask tglx to run git-update-server-info in
> the repository.

can please try to fix it according to Junio's proposal.

Regards

Marcel
