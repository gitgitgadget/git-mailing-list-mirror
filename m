From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 00:33:41 +0000
Organization: linutronix
Message-ID: <1115858022.22180.256.camel@tglx>
References: <1115847510.22180.108.camel@tglx>  <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx>  <428297DB.8030905@zytor.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:25:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1Vr-00072K-KN
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVELAcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVELAcw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:32:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53635
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261270AbVELAcu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:32:50 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id C5C6265C003;
	Thu, 12 May 2005 02:32:48 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id A59B62807D;
	Thu, 12 May 2005 02:32:50 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428297DB.8030905@zytor.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 16:40 -0700, H. Peter Anvin wrote:
> > I expect neither of those two things to happen, but a complete working
> > directory path is better than nothing to make educated guesses.
> > Committer names (maintainers) can be the same over repositories, but its
> > unlikely that somebody who manages more than one subsystems uses the
> > same working directory for them.
> > 
> 
> I can tell you what would happen in at least my case: you'll see each 
> "repository" with about 23 different IDs.

You won. :)

So what alternatives do we have ?

- commit history per repository
  .git/head-history               rsync and user error prone 
- .git/repoid                     rsync error prone
- GIT_REPO_ID=xyz                 user  error prone
- directory name based guessing   hpa error prone

What's your preferred error scenario ?

tglx


