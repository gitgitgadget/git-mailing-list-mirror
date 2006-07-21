From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git BOF notes
Date: Fri, 21 Jul 2006 09:21:11 -0400
Message-ID: <20060721132111.GD32585@fieldses.org>
References: <20060719230155.GJ13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 15:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3uwO-0000Mz-7E
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 15:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWGUNVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 09:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGUNVM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 09:21:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:19592 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750723AbWGUNVL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 09:21:11 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1G3uwJ-0000XA-3J; Fri, 21 Jul 2006 09:21:11 -0400
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060719230155.GJ13776@pasky.or.cz>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24050>

On Thu, Jul 20, 2006 at 01:01:55AM +0200, Petr Baudis wrote:
> 	* Support for distributing and following the mutated history.
> 	  I'm actually not sure about the level of Git support for
> 	  this, Cogito supports cg-updating to a mutated history
> 	  if you have no local changes.

A fetch that doesn't fast-forward fails with a warning unless you
explicitly ask it (--force) to blow away your old history.

I don't see what more you could do.

--b.
