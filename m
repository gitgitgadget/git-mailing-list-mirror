From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Can the git exclude files mask out whole directories?
Date: Mon, 18 Sep 2006 19:28:07 +0100
Organization: Insert Joke Here
Message-ID: <1158604087.28026.160.camel@okra.transitives.com>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 18 20:28:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPNr7-000100-1N
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 20:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWIRS2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWIRS2K
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 14:28:10 -0400
Received: from mx.transitive.com ([217.207.128.220]:48810 "EHLO
	pennyblack.transitives.com") by vger.kernel.org with ESMTP
	id S1750833AbWIRS2J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 14:28:09 -0400
Received: from [192.168.1.82] (helo=okra.transitives.com)
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1GPNXJ-0004b8-Sh
	for git@vger.kernel.org; Mon, 18 Sep 2006 19:08:06 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27255>

Hi,

I may be being a bit dim but according to the man page I should be able
to specify paths with /'s in them. I want to exclude all CVS directories
so I can commit stuff. I have tried:

#
# Ignore CVS files
#
*/CVS/*

Amongst many variants and:

 git-ls-files --others --exclude-from=.git/info/exclude

And all my CVS directories still get listed. I can get what I want with
adding:

# Ignore CVS files
#
Entries
Entries.Log
Repository
Root
Tag

to my exclude file but that seems suboptimal. Besides I'll also want to
be ignoring whole build directories later. Have I subtly misunderstood
the man page?

Confused,

-- 
Alex, homepage: http://www.bennee.com/~alex/
Majority, n.: That quality that distinguishes a crime from a law.
