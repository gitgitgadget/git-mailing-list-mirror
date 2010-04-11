From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn --set-tree question
Date: Sat, 10 Apr 2010 17:50:11 -0700
Message-ID: <20100411005011.GA22778@dcvr.yhbt.net>
References: <71104242.20100404172723@vitalyk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Vitaly R. Tskhovrebov" <tskhovrebov@vitalyk.ru>
X-From: git-owner@vger.kernel.org Sun Apr 11 02:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lNU-0002H7-Bb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 02:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0DKAuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 20:50:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56459 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267Ab0DKAuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 20:50:12 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103821F689;
	Sun, 11 Apr 2010 00:50:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <71104242.20100404172723@vitalyk.ru>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144617>

"Vitaly R. Tskhovrebov" <tskhovrebov@vitalyk.ru> wrote:
> Hello, guys.
> 
> I have some unusual situation here.
> 
> We  need  to  move  git  repo  to  svn with commit history. After some
> research I found a way with creating an empty svn, and then making
> git svn --set-tree [git_revision_number_here]
> 
> Commit  history  imports  well,  but  i  loose  commiters'  names  and
> comments. How to move them too?

Hi Vitaly,

You'll have to get the SVN admin to enable changing revprops on the repo
itself.  There's a hook you need to enable server-side and you'll
probably have to write a script for changing the revprops of each
revision to map to the git one.

-- 
Eric Wong
