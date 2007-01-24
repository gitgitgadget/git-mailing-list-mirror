From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 24 Jan 2007 01:05:51 +0100
Message-ID: <20070124000551.GC4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com> <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com> <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701231403qefb28f0h91d3f599699b9908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 01:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Vez-00088L-41
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 01:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbXAXAGi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 19:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933111AbXAXAGi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 19:06:38 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:48277 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932952AbXAXAGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 19:06:37 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2825F279DD;
	Wed, 24 Jan 2007 01:06:36 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 13EE32012; Wed, 24 Jan 2007 01:05:52 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701231403qefb28f0h91d3f599699b9908@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37582>

On Tue, Jan 23, 2007 at 10:03:26PM +0000, Catalin Marinas wrote:
> >I'll have to think more about that - I'm not sure I get you point.  By
> >moving/cloning we keep (or could keep) the patches' history.  By
> >importing we cannot do that.
> 
> The 'pick' command could be (easily) fixed to preserve the history of
> a patch (I'll add this to the todo list). The log commit would have
> the picked patch's log as a parent rather than none.

Right - "branch --clone" could also use that (or maybe it does already
by design).  Together with this, "pick --fold" and possibly "sync"
(although I never used the latter so I'm not 100% sure how it works)
could register a merge, and sometime in the future we could use this
information to be able to do some merging.  I'm not going to look
into this soon, but I have this popping out regularly in my head ;)


> As I said, I'll first like to get a 1.0 out this spring.

Yes.  Maybe we should get 0.12 out of the door soon, with some more
bugs fixed.  I'm trying to finish putting out in a decent shape stuff
about parent branches, git-fetch use and the other related issues
mentionned those last days.  Maybe that will be ready before enough
bugs are squashed for 0.12, but maybe not :)

Best regards,
-- 
yann.
