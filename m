From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Egit: how to merge after fetch (or pull)
Date: Thu, 9 Apr 2009 05:39:47 +0200
Message-ID: <200904090539.47489.robin.rosenberg.lists@dewire.com>
References: <3ae83b000904081456i37ad65ate133469fa9a8f23c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 05:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrl8x-0000kc-H6
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 05:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217AbZDIDj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 23:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759260AbZDIDj5
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 23:39:57 -0400
Received: from mail.dewire.com ([83.140.172.130]:9645 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759250AbZDIDj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 23:39:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0263B147D0E5;
	Thu,  9 Apr 2009 05:39:50 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdHvZ4BvZTN4; Thu,  9 Apr 2009 05:39:50 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 04F8E80265A;
	Thu,  9 Apr 2009 05:39:49 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <3ae83b000904081456i37ad65ate133469fa9a8f23c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116139>

onsdag 08 april 2009 23:56:23 skrev John Bito <jwbito@gmail.com>:
> I'd like to pull a branch before I do more work on it.  After fetch,
> git status says the branch is behind origin by N commits.
> 
> Can you tell me if there is an operation I can do via egit to get the
> origin changes onto my branch? (Most of the documentation I found for
> Egit appears to be before the fetch command was implemented.)
> 
> In the mean time, I've been using 'git pull'. Unfortunately, I found
> that it's important to shut down Eclipse while doing a git operation
> using Cygwin - a GC run when Egit had a file open caused a problem in
> the repository that subsequent pushes propagated to my GitHub
> repository.  It would be nice to work entirely within Eclipse.

A very recent update to msysgit (not git core and hence not cygwin) might help there. 
Windows locks files when reading and the Eclipse plugin reads things from the
repo when changes are detected to see if anything interesting is there. The fix
in msysgit retries certain operations a number of times if they fail with access denied,
which is what you get if the file is open for reading.

Built-in pull is not there just yet.

-- robin
