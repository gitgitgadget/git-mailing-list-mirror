From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git stash apply usability issues
Date: Thu, 18 Oct 2007 07:12:35 -0700
Message-ID: <471769D3.4080908@midwinter.com>
References: <47171A21.9030003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 16:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiW7H-0005zK-Gy
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 16:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410AbXJROMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757658AbXJROMk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 10:12:40 -0400
Received: from tater.midwinter.com ([216.32.86.90]:37244 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754901AbXJROMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 10:12:39 -0400
Received: (qmail 27504 invoked from network); 18 Oct 2007 14:12:39 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=rAOWyJQZT90BdRsDTWp9M9MHJyGHULIt918hVDvEiGSXBQXWCknW3mR9erQlb/oz  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 18 Oct 2007 14:12:39 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <47171A21.9030003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61531>

Johannes Sixt wrote:
> (2) when 'git stash apply' runs merge-recursive, it treats the current 
> state as 'ours' and the stash as 'theirs'. IMHO it should be the other 
> way round: I have stashed away changes to a binary file. Then 
> committed a different modification to it, and now want to apply the 
> stash. This results in a conflict that leaves the current state in the 
> working tree, but I had preferred that the stashed binary file were in 
> the working tree now.
>
> What do other git-stash users think about changing the order?

Seems right to me. I'd expect to get the stashed version in the working 
tree in that case.

-Steve
