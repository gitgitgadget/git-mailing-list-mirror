From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: read-only git repositories
Date: Thu, 5 May 2005 08:39:12 -0400 (EDT)
Message-ID: <3018.10.10.10.24.1115296752.squirrel@linux1>
References: <Pine.LNX.4.21.0505041854040.30848-100000@iabervon.org>
    <200505050709.43307.alan@chandlerfamily.org.uk>
    <Pine.LNX.4.62.0505050231300.15451@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 14:33:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTfX6-0007LC-30
	for gcvg-git@gmane.org; Thu, 05 May 2005 14:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVEEMjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 08:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVEEMjS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 08:39:18 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:60294 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262086AbVEEMjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 08:39:14 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050505123913.XMGS1623.simmts8-srv.bellnexxia.net@linux1>;
          Thu, 5 May 2005 08:39:13 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j45CdAhl029480;
	Thu, 5 May 2005 08:39:11 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 5 May 2005 08:39:12 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.62.0505050231300.15451@qynat.qvtvafvgr.pbz>
To: "David Lang" <david.lang@digitalinsight.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2005 5:51 am, David Lang said:

> there are probably other uses and it seems like a fairly small
> modification to add a hook to use if the object isn't found initially
> that I thought I'd mention it to the group.
>
David,

Great idea!  This seems like an option that naturally falls out of the git
design.  You're right that there are lots of uses for it too; another
would be to keep all local changes in an isolated object store for backup
etc.

Sean


