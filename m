From: David Brown <git@davidb.org>
Subject: Re: Subversion developer: svn is for dumb people
Date: Thu, 18 Oct 2007 09:57:11 -0700
Message-ID: <20071018165711.GA24460@old.davidb.org>
References: <47176CE0.7030609@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiYgW-0003Ho-FB
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477AbXJRQ5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbXJRQ5N
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:57:13 -0400
Received: from mail.davidb.org ([66.93.32.219]:34918 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758212AbXJRQ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:57:12 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IiYgJ-0006Qn-Aq; Thu, 18 Oct 2007 09:57:11 -0700
Mail-Followup-To: Steven Grimm <koreth@midwinter.com>,
	'git' <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47176CE0.7030609@midwinter.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61547>

On Thu, Oct 18, 2007 at 07:25:36AM -0700, Steven Grimm wrote:

> I can't say he's completely wrong, especially about the 20/80% idea (though 
> I think "20%" is generous), but some of his specific arguments about DVCS 
> are on the bogus side. "Centralized systems encourage code reviews," for 
> one -- I challenge him to find a project with a more pervasive and 
> effective code-reviewing culture than the git project. I find code reviews 
> *harder* in a centralized system because you end up building external tools 
> to help people try out each other's changes.

The review comment is completely bogus.  Centralized systems, at least like
SVN and P4 encourage a check-it-in-deal-with-the-problems-later attitude.
The tool discourages you from trying out other's changes, whereas a DVCS
tends to have lots of little branches and easy migration between them.

I think this is less an issue of distributed or not, but more that branches
are just so expensive in most other revision control systems.  Whether that
is expensive in resource, or just in understanding what is going on (for
example, requiring users to track merge ancestors is rediculous).

David
