From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fetch failure from git2.kernel.org?
Date: Sun, 22 Apr 2007 14:53:07 +0200
Message-ID: <20070422125307.GA2431@steel.home>
References: <86fy6ssp32.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 14:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfbZO-0000m5-LR
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 14:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbXDVMxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 08:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbXDVMxN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 08:53:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:30351 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030576AbXDVMxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 08:53:12 -0400
Received: from tigra.home (Fcb6c.f.strato-dslnet.de [195.4.203.108])
	by post.webmailer.de (fruni mo11) (RZmta 5.6)
	with ESMTP id 80156aj3M8d81e ; Sun, 22 Apr 2007 14:53:08 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0D746277BD;
	Sun, 22 Apr 2007 14:53:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A0B2DBDDE; Sun, 22 Apr 2007 14:53:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86fy6ssp32.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsD+I4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45236>

Randal L. Schwartz, Sun, Apr 22, 2007 12:03:45 +0200:
> 
> is this known?  transient?
> 
>     $ git-fetch
>     warning: no common commits
>     remote: Generating pack...
>     remote: Done counting 0 objects.
>     remote: aborting due to possible repository corruption on the remote side.
>     fatal: protocol error: bad pack header
>     fatal: Fetch failure: git://git2.kernel.org/pub/scm/git/git.git
>     $
> 

Confirm this. BTW, git1 and git2 point to the same 140.211.167.38
(poseidon.kernel.org). It used to be different addresses
