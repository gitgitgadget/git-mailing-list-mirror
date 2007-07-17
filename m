From: bdowning@lavos.net (Brian Downing)
Subject: Re: Seeing differences at origin/branch?
Date: Tue, 17 Jul 2007 11:12:16 -0500
Message-ID: <20070717161216.GP19073@lavos.net>
References: <18071eea0707170853r41962edfge603ccec7b2e72cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApf6-00024H-4P
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbXGQQM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbXGQQM1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:12:27 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:29716 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXGQQM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:12:26 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 17 Jul 2007 12:12:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjMzAGiHnEZKhvbzRmdsb2JhbACHLogMAQEBNQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 496B0309F31; Tue, 17 Jul 2007 11:12:16 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <18071eea0707170853r41962edfge603ccec7b2e72cb@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52767>

On Tue, Jul 17, 2007 at 04:53:03PM +0100, Thomas Adam wrote:
> This is perhaps going to seem like a very CVS/SVN type of question,
> but is there a way to see a list of differences between one's local
> copy and the origin branch?  I'm after something analogous to "svn
> status -u" really (yes, I know I could get my hands scorched for such
> things.  :P).  Is this possible?
> 
> I've tried:
> 
> git-diff-tree -p origin/master
> 
> But that won't list changes waiting for me that I would get when I
> issue a "git pull".

Use "git fetch" to fetch the remote changes, but not merge them into
your local tracked branches.  "git pull" basically just does "git fetch"
then "git merge" into your current branch if it is tracking a remote
branch.

You might as well use "git diff" as well, as "git-diff-tree" is
definitely plumbing.

% git fetch origin
...
% git diff origin/master

-bcd
