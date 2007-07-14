From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches
Date: Sat, 14 Jul 2007 04:34:35 -0700
Message-ID: <20070714113435.GC14842@muzzle>
References: <1184405128718-git-send-email-madduck@madduck.net> <20070714105010.GA14842@muzzle> <20070714110431.GA3854@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 13:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9ftX-0002nu-Mo
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 13:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbXGNLeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 07:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756455AbXGNLeg
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 07:34:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41679 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379AbXGNLeg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 07:34:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7470D2DC032;
	Sat, 14 Jul 2007 04:34:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070714110431.GA3854@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52472>

martin f krafft <madduck@madduck.net> wrote:
> also sprach Eric Wong <normalperson@yhbt.net> [2007.07.14.1250 +0200]:
> > This looks good and useful, but can I also have a  shorthand "-s" for
> > this, too?  I'm lazy, thanks :)
> 
> Of course.
> 
> > Also, nitpicking, there's been some whitespace damage:
> > 
> > I use tab characters for indentation, and (should be using) spaces for
> > alignment.
> 
> What's the difference? Or is it simply:
> 
>   no. of tabs:   int(column / 8)
>   no. of spaces: column % 8

It's also easier/faster to navigate code with tabs since there are fewer
characters to iterate over, less granular points for indentation, making
it easier to to get to a desired indentation level.

The less granularity with tabs means I can avoid situations where where
I wonder if I'm correctly aligned with other pieces of code.  I even
have auto-indent set, but occasionally with spaces (when I work on Ruby
code) I still have problems with being off-by-one after editing
something.

There's absolutely no way I can misalign a block of code when alignment
granularity is 8 characters no matter how sleepy I get :)

I use tabs for indentation where they denote logically different code
paths / nesting.

Spaces (for alignment, not indentation) are mainly aesthetic.  I use
them in spaces when I need finer control (usually long conditionals in
if-statements that are wrapped).

Tabs can also be easily reconfigured in editors to change the amount of
screen real estate they consume.  Not really useful in git-svn since
I keep it <80 columns anyways.

> I am sorry, I tried to do it right, even paid attention to the
> tabs/spaces thing, but I guess I failed.

No worries.  The maintainers here are also very picky about trailing
whitespace and spaces that appear before tab characters, too and I
became much more disciplined about that myself the past year.

I have highlighting search set in my editor (vim :set hls)
and usually just search for spaces vs tabs to make sure I'm clean.

Of course, maintaining a consistent whitespace style helps a *lot* with
the git/Linux patch exchange development style because it avoids
needless patch application conflicts that arise from whitespace
differences.

-- 
Eric Wong
