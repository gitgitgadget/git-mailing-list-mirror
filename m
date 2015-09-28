From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Why not git reset --hard <path>?
Date: Mon, 28 Sep 2015 17:36:01 -0400
Message-ID: <20150928213601.GA4071@thunk.org>
References: <20150928203449.29024.qmail@ns.horizon.com>
 <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com>
 <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.keller@gmail.com>,
	George Spelvin <linux@horizon.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 23:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgg5l-0003fQ-5b
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 23:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbbI1VgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 17:36:07 -0400
Received: from imap.thunk.org ([74.207.234.97]:47820 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbbI1VgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 17:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=175R7uryrzr2ttazlax+UR7bBziUhxQBLhWjXeDVtGw=;
	b=tTJUOdPD+DFrCG5ImjMHfC9DCHdc7c5xXE1jPoypdh7Y959vwqlgVNyEOwPvseEPWdk0Ng+ZBnYNFA9GLnXIGIIU0kyUzxg402BtInK0+E4mYKEhhE9JZ8BrrR0YR6LHf7R/AZ1D+i8gDBcZDl8qABlMewo5mXkoVrEa/PMYVow=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Zgg5Z-0000Ol-PU; Mon, 28 Sep 2015 21:36:01 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 44D0F82CEF0; Mon, 28 Sep 2015 17:36:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278754>

I personally have in my .gitconfig:

[alias]
	revert-file = checkout HEAD --

I'm not sure revert-file is the best name, but it's what I've used
because I've been contaminated by the concept/naming of "p4 revert",
which I do use a fair amount to undo local edits for one or more files
when I've been forced to use perforce or perforce-like systems.  Given
that it confuses the concept of how "git revert" works, maybe
something like "git unedit <pathspec>" would work better.

Given though it's so easy to address this with a single line in a
user's .gitconfig, I guess the question is whether it's worthwhile to
make a change that would be visible to all users, and perhaps more
importantly, all new users to git.

	     	     	     	      - Ted
