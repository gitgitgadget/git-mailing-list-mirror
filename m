From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: using stgit/guilt for public branches
Date: Fri, 4 May 2007 01:10:33 +0200
Organization: Dewire
Message-ID: <200705040110.34697.robin.rosenberg.lists@dewire.com>
References: <20070425122048.GD1624@mellanox.co.il> <200704252337.05851.robin.rosenberg.lists@dewire.com> <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 04 01:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjkRg-0002Bz-Tu
	for gcvg-git@gmane.org; Fri, 04 May 2007 01:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbXECXKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbXECXKm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 19:10:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2595 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbXECXKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 19:10:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2E44080265D;
	Fri,  4 May 2007 01:04:38 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09630-05; Fri,  4 May 2007 01:04:37 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CB961802651;
	Fri,  4 May 2007 01:04:37 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46117>

torsdag 03 maj 2007 skrev Yann Dirson:
[...]
> As for publishing, I use the following config entries to publish my
> own stack of patches to stgit.  You can see at
> http://repo.or.cz/w/stgit/ydirson.git that gitweb shows pretty clearly
> the structure of the stack (even though things could surely be made
> better).
> 
> I use "git push -f" to publish - maybe the "+" refspec syntax would
> work with push, I'll try it next time :)
> 
> [remote "orcz"]
>         url = git+ssh://ydirson@repo.or.cz/srv/git/stgit/ydirson.git
>         push = refs/heads/master:refs/heads/master
> 	push = refs/patches/master/*:refs/patches/master/*

Beautiful!!

I needed to change the update commit though for git to recognize the
refs/patches heads. Or is that only because I had initialized the repos
using v1.5.0 ?

-- robin
