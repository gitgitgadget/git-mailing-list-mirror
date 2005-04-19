From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Tue, 19 Apr 2005 07:05:26 -0400
Message-ID: <20050419110521.GC28269@abridgegame.org>
References: <20050418210436.23935.qmail@science.horizon.com> <1113869248.23938.94.camel@orca.madrabbit.org> <42645969.2090609@qualitycode.com> <1113874931.23938.111.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Tue Apr 19 13:06:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNqYo-0003JA-GT
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 13:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVDSLK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 07:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDSLK1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 07:10:27 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:38463 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261419AbVDSLKW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 07:10:22 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DNqXm-0007OZ-KQ; Tue, 19 Apr 2005 07:05:26 -0400
To: Ray Lee <ray-lk@madrabbit.org>
Mail-Followup-To: Ray Lee <ray-lk@madrabbit.org>,
	Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <1113874931.23938.111.camel@orca.madrabbit.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 06:42:11PM -0700, Ray Lee wrote:
> On Mon, 2005-04-18 at 21:05 -0400, Kevin Smith wrote:
> > You could guess, but that's not good enough for darcs to be able to
> > reliably commute the patches later.
>
> Who said anything about guessing? If a user replaces all instances of
> foo with bar, that's as close to proof as you can ever get, without
> recording intent of the user at the time it's done. Now, I realize that
> darcs *does* record intent, but I claim that's immaterial.

The problem is, how do you know how to define a token? That's also included
in a darcs patch.  And a darcs user may choose not to use a replace patch,
if (for example) he's renaming a local variable, since he might not want to
mess with other functions in the same file.

Guessing the author's intent cannot reliably reproduce the author's stated
intent.  Either we need to include that information in one form or another
(and in one location or another), or we've got to simply disallow replaces
(and moves?) when interacting with git.
-- 
David Roundy
http://www.darcs.net
