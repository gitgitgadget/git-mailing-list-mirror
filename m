From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 23:23:41 -0700
Message-ID: <20070918062341.GD13571@hand.yhbt.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com> <11900461843997-git-send-email-hjemli@gmail.com> <20070918005013.GA6368@muzzle> <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:24:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXWV8-0001dE-HP
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 08:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbXIRGXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 02:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbXIRGXn
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 02:23:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50640 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605AbXIRGXm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 02:23:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CD2317DC029;
	Mon, 17 Sep 2007 23:23:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58528>

Lars Hjemli <hjemli@gmail.com> wrote:
> On 9/18/07, Eric Wong <normalperson@yhbt.net> wrote:
> > Would automatically enabling --no-ff when it detects merging of two (or
> > more) SVN branches be a good thing?
> 
> I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.

That still involves having to get the user to use something new to avoid
shooting themselves in the foot.  Perhaps putting a
"test -d $GIT_DIR/svn" condition in front of the git-svn call I proposed
in git-merge would be alright.

If anybody else is thinking about 'git-svn rebase', this is completely
different.  Using git-rebase alone doesn't allow git-svn users to shoot
themselves in the foot like git-merge does.  'git-svn rebase' only
serves to minimize typing and brain power needed to operate git-svn.

-- 
Eric Wong
