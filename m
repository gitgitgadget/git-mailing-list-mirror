From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Wed, 7 May 2008 19:08:50 -0700
Message-ID: <064B1E1A-9C5C-49A4-AD08-0397FE4C517E@midwinter.com>
References: <20080508013956.GA24956@midwinter.com> <20080508015806.GA759@pe.Belkin>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Thu May 08 04:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtvZo-0007jr-8U
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 04:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759780AbYEHCIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 22:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbYEHCIw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 22:08:52 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58317 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758864AbYEHCIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 22:08:51 -0400
Received: (qmail 26742 invoked from network); 8 May 2008 02:08:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=hnMix6UKQXBDwLc++pwrkwbYGhUL1suQZdawqny8unmBeHp/X1TNgUJUtSQfCPSs  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 8 May 2008 02:08:50 -0000
In-Reply-To: <20080508015806.GA759@pe.Belkin>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81499>

On May 7, 2008, at 6:58 PM, Chris Shoemaker wrote:
> Second, what will happen when different developers have svn URLs with
> different schemes, e.g. http vs. svn+ssh?

That will cause the commit messages to be different, which means you  
won't have the same commit hashes, so this pretty much won't be  
useful. (You'd end up fetching the remote repo's entire svn history if  
you tried to do git fetch.)

The assumption here is that you have exactly the same revision history  
in your tracking branches as the repo you're fetching from.

-Steve
