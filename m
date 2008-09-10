From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about
	porcelain-level metadata
Date: Wed, 10 Sep 2008 14:30:26 +0200
Message-ID: <20080910123026.GJ10360@machine.or.cz>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org> <20080910104424.GH10360@machine.or.cz> <20080910114940.GA14127@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 14:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdOrG-0007E9-4m
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 14:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYIJMa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 08:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYIJMa3
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 08:30:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36422 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbYIJMa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 08:30:28 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 974FD393A36E; Wed, 10 Sep 2008 14:30:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910114940.GA14127@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95515>

On Wed, Sep 10, 2008 at 01:49:40PM +0200, Stephen R. van den Berg wrote:
> Maybe we have a misunderstanding about what "follow a link" means and
> when it is done.
> During most normal git operation, the origin links are just read, but
> not followed.
> The only commands that I expect to follow them are log --graph, gitk, fsck
> and blame.  I may have missed some corner use-cases, but this should
> cover most of it; i.e. most of git ignores them or just makes note of
> the hashvalues provided.

Oh, I'm sorry. By

	- During fetch/push/pull the full commit including the origin fields is
	  transmitted, however, the objects the origin links are referring to
	  are not (unless they are being transmitted because of other reasons).

I have understood that you fetch the origin target but not commits
referred from it, but instead you meant that you do not follow the
origin link at all.

				Petr "Pasky" Baudis
