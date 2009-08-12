From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Tie a CVS-aware app into GIT?
Date: Wed, 12 Aug 2009 22:30:29 +0200
Message-ID: <200908122230.29363.robin.rosenberg.lists@dewire.com>
References: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david.hagood@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 22:30:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbKT2-00088e-Po
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 22:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZHLUab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZHLUaa
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 16:30:30 -0400
Received: from mail.dewire.com ([83.140.172.130]:27267 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbZHLUaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 16:30:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7FE311434E8A;
	Wed, 12 Aug 2009 22:30:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5FE5JK3eSVS; Wed, 12 Aug 2009 22:30:30 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 00EBC8027E8;
	Wed, 12 Aug 2009 22:30:29 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <b988339dcd1bf764f0da46db763552d8.squirrel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125739>

onsdag 12 augusti 2009 20:01:45 skrev david.hagood@gmail.com:
> I have an application (closed source, unfortunately) that can use CVS to
> manage its files (specifically, Enterprise Architect by Sparx).
> 
> I'd rather use GIT to manage the files, but EA doesn't "speak" git - just
> CVS and Subversion (and Microsoft's SCC protocol, but...)
> 
> Are there any programs which
> 1) accept the same command line parameters as CVS or Subversion
> and
> 2) access a GIT repository.
> 
> git-svn is almost exactly NOT what I need, as it accepts "git" type
> command line parameters and access a SVN repo, rather than accepting SVN
> command line parameters and accessing a GIT repo.
> 
> Now, obviously, such a tool wouldn't have access to all the things that
> GIT can do, and that is NOT what I am expecting - what I want is just to
> enable EA to do the things it needs to do, namely adding/removing/moving
> files from a repo. Branching, commits, and so on can be done manually.
> 
> I've thought about git-cvsserver as a solution, but I don't know if it can
> be run on a local machine to access a local repository.

What makes you there would be an issue here?

-- robin
