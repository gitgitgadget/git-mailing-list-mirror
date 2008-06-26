From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 11:26:40 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806261120370.5253@sf.creativecommons.org>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com> <20080626094522.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806261224020.9925@racer> <20080626161941.GX20723@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwCY-0002bX-FG
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbYFZS0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757910AbYFZS0s
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:26:48 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:58230 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761825AbYFZS0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:26:47 -0400
Received: from sf.creativecommons.org (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 4DA36A014B;
	Thu, 26 Jun 2008 14:26:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTPS id E43CA134CC36;
	Thu, 26 Jun 2008 11:26:40 -0700 (PDT)
X-X-Sender: paulproteus@sf.creativecommons.org
In-Reply-To: <20080626161941.GX20723@cs-wsok.swansea.ac.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86468>

On Thu, 26 Jun 2008, Oliver Kullmann wrote:

> I have around 10 CVS repositories, each with around 5 modules. This has 
> developed over time, and now I want to combine them all into a single 
> Git repository, with a new directory structure introduced.

I had a similar desire with git-svn; instead, what I do is a 
git-filter-branch that renames all the files in the repository.

man git-filter-branch gives you one way to do that; I basically 
re-invented that due to not scrolling all the way to the bottom, and run 
it every night on the git-svn repo since I want my everything-renamed repo 
to be kept as an up-to-date mirror of the svn repo.

That's my idea for you.

-- Asheesh.

-- 
Fast, cheap, good: pick two.
