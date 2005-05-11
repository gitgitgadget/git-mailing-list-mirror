From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 18:24:14 -0400 (EDT)
Message-ID: <2807.10.10.10.24.1115850254.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> 
    <2780.10.10.10.24.1115848852.squirrel@linux1>
    <1115849141.22180.123.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzVW-0007RG-Jn
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVEKWYS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEKWYS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:24:18 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:39099 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261515AbVEKWYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:24:15 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511222414.RQUB11606.simmts5-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 18:24:14 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BMOEMj003266;
	Wed, 11 May 2005 18:24:14 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 18:24:14 -0400 (EDT)
In-Reply-To: <1115849141.22180.123.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 6:05 pm, Thomas Gleixner said:

> Err,
> each parent is a commit, which is identified by its repoid. Why do you
> want to add redundant information ?
>

It's not necessarily the repoid you pulled the object from though.  It may
be the repoid of another completely separate repository.

Repo A -  creates object  HEAD = (A)
Repo B -  pulls objects from Repo A  FAST FORWARD HEAD = (A)
Repo C -  pulls from Repo B

Now as you traverse the history in Repo C, the object will show as coming
from Repo A, not Repo B.

Sean


