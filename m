From: Max Kirillov <max@max630.net>
Subject: Re: Rebasing merge commits
Date: Wed, 19 Mar 2014 23:00:29 +0200
Message-ID: <20140319210029.GA6457@wheezy.local>
References: <CAHd499BFAmfDAjNr0RhCiy4vEBn2xJzCtTmwrB-U51qJryB+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQNju-00080w-FH
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbaCSVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:09:24 -0400
Received: from p3plsmtpa08-04.prod.phx3.secureserver.net ([173.201.193.105]:41565
	"EHLO p3plsmtpa08-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384AbaCSVJX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 17:09:23 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2014 17:09:23 EDT
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-04.prod.phx3.secureserver.net with 
	id fZ1D1n00C4CavkR01Z1K5n; Wed, 19 Mar 2014 14:01:23 -0700
Content-Disposition: inline
In-Reply-To: <CAHd499BFAmfDAjNr0RhCiy4vEBn2xJzCtTmwrB-U51qJryB+Dw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244491>

On Tue, Mar 18, 2014 at 01:11:06PM -0500, Robert Dailey wrote:
> What's the general recommendation on rebasing after
> creating a merge commit on my branch?

Basically, rebase does not do anything magic. It just
cherry-picks commits over a custom revision. You could do it
manually: reset to the master and then cherry-pick all
your commits (or whichever you would like to pick) from the
older topic1. git rebase --onto would be useful to make it
a bit less manual it there are many commits and few merges.

I used to do it myself, but later I have made my own rebase
which can somehow handle merges:
https://github.com/max630/git-rebase2/
You could try it also.

-- 
Max
