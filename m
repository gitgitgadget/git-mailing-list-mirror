From: David Fries <david@fries.net>
Subject: Re: [PATCH 2/2] git-gui blame add more common search hotkeys
Date: Tue, 19 Jul 2011 21:56:01 -0500
Message-ID: <20110720025601.GE26701@spacedout.fries.net>
References: <20110716165945.GA9722@spacedout.fries.net>
 <87sjq2cp8t.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jul 20 04:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjMxN-0006XY-CN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 04:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1GTC4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 22:56:11 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:57922 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab1GTC4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 22:56:10 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p6K2u29m021543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Jul 2011 21:56:02 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p6K2u1KJ021542;
	Tue, 19 Jul 2011 21:56:01 -0500
Content-Disposition: inline
In-Reply-To: <87sjq2cp8t.fsf@fox.patthoyts.tk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Tue, 19 Jul 2011 21:56:02 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177516>

On Tue, Jul 19, 2011 at 03:35:30PM +0100, Pat Thoyts wrote:
> David Fries <david@fries.net> writes:
> 
> That aside, the goto-line feature works fine for me. I don't think the
> n, Shift-n binding is working though. When I have the focus in the blame
> window and enter 'n' it tries to add an 'n' to the text in the search
> box. The use of Enter and Shift-Enter makes sense and works as I
> expect. So I will drop the 'n' and 'Shift-n' bindings I think.

I have some 6000 some line files that I was preparing change sets
and was needing to jump to a specific line.  That's what prompted me
to add the goto feature, I just went ahead and added the search
hotkeys while I was in looking at it.  I apparently didn't do enough
testing on the search, it's <Key-N> not the <Shift-Key-n> that I had
in there.  The n and N only work when the search bar is dismissed with
escape or something.  I'm more used to vi's searching where the search
field is dismissed with return and there isn't a search field left to
add to.  I'm fine with dropping the n/N bindings.

> The -accelerator field on a menu specifies the text to show. Its more
> usual to show "Ctrl-G" than "Control-Key-G" here so I'll adjust that as
> well. The 'bind' command actually ties up the key binding to the menu
> action.
> 
> With the above changes, I'll apply this to git-gui's master (which lives
> at repo.or.cz/git-gui.git) and it will get merged into git on the next
> merge.

Sounds good, thanks for merging it.

-- 
David Fries <david@fries.net>    PGP pub CB1EE8F0
http://fries.net/~david/
