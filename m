From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 20:36:25 +0100
Message-ID: <20070222193625.GA4489@pasky.or.cz>
References: <17885.60477.53356.123095@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 22 20:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKJk7-0005fP-JM
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 20:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXBVTg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 14:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXBVTg2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 14:36:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36441 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbXBVTg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 14:36:28 -0500
Received: (qmail 13119 invoked by uid 2001); 22 Feb 2007 20:36:25 +0100
Content-Disposition: inline
In-Reply-To: <17885.60477.53356.123095@lisa.zopyra.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40374>

On Thu, Feb 22, 2007 at 08:17:17PM CET, Bill Lear wrote:
> Git "indexing" of commits has a way to "go back":
> 
> % git diff HEAD~3
> 
> Can I say "all the way back", or "all the way back - 1" somehow?

What would that mean? :)

Do you mean to the "root" of the history? The trouble is, there can be
many of such roots (coming up from merges of previously disjunct
histories); even the git project itself has several. Which one to
choose?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
		-- Kurt Vonnegut, Sirens from Titan
