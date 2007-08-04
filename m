From: Pavel Roskin <proski@gnu.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 04 Aug 2007 01:41:25 -0400
Message-ID: <1186206085.28481.33.camel@dv>
References: <1186163410.26110.55.camel@dv>
	 <200708031914.04344.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 07:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHCOU-0007Q4-38
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 07:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbXHDFl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 01:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbXHDFl3
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 01:41:29 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:33101 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbXHDFl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 01:41:28 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IHCQj-0002ht-J3
	for git@vger.kernel.org; Sat, 04 Aug 2007 01:44:01 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IHCOD-0000GA-85; Sat, 04 Aug 2007 01:41:25 -0400
In-Reply-To: <200708031914.04344.andyparkins@gmail.com>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54792>

Hello, Andy!

On Fri, 2007-08-03 at 19:14 +0100, Andy Parkins wrote:
> On Friday 2007, August 03, Pavel Roskin wrote:
> 
> > I don't suggest that StGIT gives up on the git-based storage, but this
> > mode of operation could be implemented in two ways.
> 
> git's shiny new git rebase -i has removed, for me, those times when I needed 
> stgit.  Perhaps those who've move from git to quilt would try again when 
> 1.5.3 is out with the magic that is "rebase -i".

I don't understand how one option can replace StGIT.  I assume you were
trying to avoid StGIT already, and "git-rebase -i" was just the last
missing piece.

It would be great if you could tell me how your approach would deal with
the issue of editable patches I mentioned already.  In case I was
unclear, here's the quote from one of the developers:

[quote]
Sometimes, I just make patches in quilt, then I do "quilt 
refresh", "quilt pop -a", "cd patches" and modify the patches 
and series file manually, e.g. by moving one patch from one file 
into the other. The "cd ..", "quilt push -a" and off I am. That 
the "database" of quilt is in a known format and I can hack on 
it with an editor is a plus for me :-)
[end of quote]

-- 
Regards,
Pavel Roskin
