From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Mon, 19 Feb 2007 12:09:56 -0800
Message-ID: <7vfy917vu3.fsf@assigned-by-dhcp.cox.net>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org>
	<7virdybu9a.fsf@assigned-by-dhcp.cox.net>
	<20070219073238.GA30030@spearce.org>
	<20070219125219.GD25490@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:10:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEpk-0000kb-Se
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbXBSUJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbXBSUJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:09:58 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62079 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529AbXBSUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:09:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219200957.KKTD21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 15:09:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RY9w1W0061kojtg0000000; Mon, 19 Feb 2007 15:09:56 -0500
In-Reply-To: <20070219125219.GD25490@thunk.org> (Theodore Tso's message of
	"Mon, 19 Feb 2007 07:52:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40144>

Theodore Tso <tytso@mit.edu> writes:

> ..., and (2) fetching
> groups of remotes would be overloading concepts for git-fetch, which
> makes not only the implementation hard, but also the potential
> semantics.

I am with you 100% on this one.  Pushing to two separate places
makes perfect sense, but fetching (or worse, pulling) from two
separate places has certain "Huh?" factor in its semantics.
