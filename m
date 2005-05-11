From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 22:30:19 +0000
Organization: linutronix
Message-ID: <1115850619.22180.133.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:23:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzah-0008GA-2u
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVEKW3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEKW3d
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:29:33 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:55938
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261286AbVEKW32
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:29:28 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 9C51465C003;
	Thu, 12 May 2005 00:29:26 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 3449128284;
	Thu, 12 May 2005 00:29:28 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2807.10.10.10.24.1115850254.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 18:24 -0400, Sean wrote:
> On Wed, May 11, 2005 6:05 pm, Thomas Gleixner said:
> 
> > Err,
> > each parent is a commit, which is identified by its repoid. Why do you
> > want to add redundant information ?
> >
> 
> It's not necessarily the repoid you pulled the object from though.  It may
> be the repoid of another completely separate repository.
> 
> Repo A -  creates object  HEAD = (A)
> Repo B -  pulls objects from Repo A  FAST FORWARD HEAD = (A)
> Repo C -  pulls from Repo B
> 
> Now as you traverse the history in Repo C, the object will show as coming
> from Repo A, not Repo B.

At this point it is completely irrelevant if you pulled from A or B. The
originator of Head A is A forever.

tglx


