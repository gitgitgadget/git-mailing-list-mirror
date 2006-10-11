From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: core-git and porcelains
Date: Wed, 11 Oct 2006 20:08:46 +0200
Organization: Dewire
Message-ID: <200610112008.46873.robin.rosenberg.lists@dewire.com>
References: <egivn8$5mf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 20:08:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXiV8-000525-Ao
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbWJKSIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWJKSIN
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:08:13 -0400
Received: from [83.140.172.130] ([83.140.172.130]:54329 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1161109AbWJKSIL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 14:08:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 6DC4A80285B;
	Wed, 11 Oct 2006 20:05:10 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19512-05; Wed, 11 Oct 2006 20:05:10 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 0A9618003E1;
	Wed, 11 Oct 2006 20:05:07 +0200 (CEST)
To: Pazu <pazu@pazu.com.br>
User-Agent: KMail/1.9.4
In-Reply-To: <egivn8$5mf$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28732>

onsdag 11 oktober 2006 16:39 skrev Pazu:
[...]
> For the larger part of my day, however, I'm looking into using git as a
> personal tool in a very large corporate project; This project is
> currently controlled using subversion, and my idea is to use git as a
> 'staging' system, where I work (possibly offline) before pushing changes
> to the upstream (remote, slow as hell) subversion repository. Here,
> git-svn seems to be my best friend.

I work against a CVS repo in the way you want to use SVN and I find StGIT
to be a perfect fit for my needs. StGIT's doesn't replace GIT's command so I 
use StGIT for it's patch management and the standard git commands for the 
rest.  I can't see that working agains SVN should be any different, except 
the git-svn* vs git-cvs commands.  

The GIT commands aren't that hard to understand. The difficulty is to know 
which commands to use.  I use these commands

stg init, new, add, remove push, pop, refresh, status, pull, goto, diff (and a 
new command float that I wrote which simplified some pop-push sequences)

git log push, diff

In addition I use qgit for browsing when git log isn't comfortable enough and 
occasionally the standard patch command.

-- robin
