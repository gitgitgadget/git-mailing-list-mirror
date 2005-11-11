From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 15:19:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111516170.7575@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 15:21:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaZkF-0002ZC-3j
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKKOTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVKKOTH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:19:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21408 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750779AbVKKOTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:19:05 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AC4C313F17F; Fri, 11 Nov 2005 15:19:04 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 906D79F24F; Fri, 11 Nov 2005 15:19:04 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B02A92739; Fri, 11 Nov 2005 15:19:04 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1EE3413F17F; Fri, 11 Nov 2005 15:19:04 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43737EC7.6090109@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11597>

Hi,

On Thu, 10 Nov 2005, H. Peter Anvin wrote:

> May I *STRONGLY* urge you to name that something different. "lost+found" 
> is a name with special properties in Unix; for example, many backup 
> solutions will ignore a directory with that name.

Two reasons against renaming:

- we call it fsck-objects for a reason. We are working on a file system, 
  which just so happens to be implemented in user space, not kernel space.
  If lost+found has to find a new name, so does fsck-objects.

- lost+found has a special meaning, granted. So, a backup would not be 
  made of it. So what? I *don't* want it backup'ed. I want to repair what
  was wrong with it. When I repaired it, the result is stored somewhere
  else. To backup lost+found would make as much sense as to backup /tmp.

Ciao,
Dscho
