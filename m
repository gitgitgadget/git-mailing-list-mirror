From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 18:36:36 -0400 (EDT)
Message-ID: <2853.10.10.10.24.1115850996.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> 
    <2780.10.10.10.24.1115848852.squirrel@linux1> 
    <1115849141.22180.123.camel@tglx> 
    <2807.10.10.10.24.1115850254.squirrel@linux1>
    <1115850619.22180.133.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzhR-0000qq-B9
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVEKWgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEKWgk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:36:40 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:44464 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261288AbVEKWgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:36:37 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511223636.PGWV11463.simmts6-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 18:36:36 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BMaaqL003447;
	Wed, 11 May 2005 18:36:36 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 18:36:36 -0400 (EDT)
In-Reply-To: <1115850619.22180.133.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 6:30 pm, Thomas Gleixner said:

> At this point it is completely irrelevant if you pulled from A or B. The
> originator of Head A is A forever.

But who cares what repository was used to create the object?   You can't
talk to a repository.   What you want to know is who created the object,
and Author/Committer completely solves that problem.

If on the otherhand you're trying to reliably track the chain-of-command
that landed the object in your repository, your patch falls short.

Sean


