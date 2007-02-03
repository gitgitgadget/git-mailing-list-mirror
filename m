From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Sat, 03 Feb 2007 15:01:59 -0800
Message-ID: <7v8xfe3kwo.fsf@assigned-by-dhcp.cox.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	<20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
	<b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
	<20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<20070202224250.GF5362@nan92-1-81-57-214-146.fbx.proxad.net>
	<b0943d9e0702021501g2cb9bb6cocae0d706c8742868@mail.gmail.com>
	<b0943d9e0702021525o2379883aqaf27f874134668c5@mail.gmail.com>
	<20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 00:02:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTtU-0006tN-MZ
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 00:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbXBCXCB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 18:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXBCXCB
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 18:02:01 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:48601 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751827AbXBCXCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 18:02:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203230200.RSRW1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Feb 2007 18:02:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KB1z1W00u1kojtg0000000; Sat, 03 Feb 2007 18:02:00 -0500
In-Reply-To: <20070203214619.GM5362@nan92-1-81-57-214-146.fbx.proxad.net>
	(Yann Dirson's message of "Sat, 3 Feb 2007 22:46:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38618>

Yann Dirson <ydirson@altern.org> writes:

> On Fri, Feb 02, 2007 at 11:25:28PM +0000, Catalin Marinas wrote:
>> OK, tried again and 'stg pull' doesn't update the base with the last
>> patch in the series ('stg rebase origin' updates it). I don't have
>> anything set up in my gitconfig in this area.
>
> So now that this particular problem has a fix, let's fix everything
> related.
>
> Since branch.*.merge accept local ref names, there is probably far
> more to change that what I initially feared.

If that is the case maybe we should fix branch.*.merge not to
match the local tracking branch name.  Matching it with local
tracking branch name when the remote name does not match was
werely a fallback to help broken configurations confused people
might create by hand, and has never been the part of sane
practice at all.
