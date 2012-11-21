From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Topics currently in the Stalled category
Date: Wed, 21 Nov 2012 10:27:50 +0100
Message-ID: <20121121092750.GA8262@shrek.podlesie.net>
References: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Wed Nov 21 10:28:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb6bK-0005Mz-48
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 10:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab2KUJ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 04:27:54 -0500
Received: from [93.179.225.50] ([93.179.225.50]:59778 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab2KUJ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 04:27:53 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 8CFAA654; Wed, 21 Nov 2012 10:27:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121121024647.BBCC82E9301@grass.foxharp.boston.ma.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210146>

On Tue, Nov 20, 2012 at 09:46:47PM -0500, Paul Fox wrote:
> junio c hamano wrote:
>  > Here is a list of stalled topics I am having trouble deciding what
>  > to do (the default is to dismiss them around feature freeze).
> ...
>  > * pf/editor-ignore-sigint (2012-11-11) 5 commits
>  > 
>  >  Avoid confusing cases where the user hits Ctrl-C while in the editor
>  >  session, not realizing git will receive the signal. Since most editors
>  >  will take over the terminal and will block SIGINT, this is not likely
>  >  to confuse anyone.
>  > 
>  >  Some people raised issues with emacsclient, which are addressed by this
>  >  re-roll. It should probably also handle SIGQUIT, and there were a
>  >  handful of other review comments.
>  > 
>  >  Anybody interested in moving this forward?
> 
> i started this, but then jeff took it and ran with it and made it
> right.  i think the remaining changes are small -- if jeff would
> prefer, i can probably finish it.  (but i won't guarantee not to
> mess up the "From:" lines.  :-)
> 

I'm also interested. I sometimes use ":r !command" in vim, so far I never
needed to use Ctrl-C, but maybe in future.

The SIGINT part seems to be finished, we need to decide what about SIGQUIT.

Krzysiek
