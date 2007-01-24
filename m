From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 24 Jan 2007 21:03:39 +0100
Message-ID: <20070124200339.GA4036@nan92-1-81-57-214-146.fbx.proxad.net>
References: <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com> <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com> <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701231403qefb28f0h91d3f599699b9908@mail.gmail.com> <20070124000551.GC4083@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701240437l33a53f64tfea8267b78bff421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 21:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9oMH-0006j3-R3
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbXAXUEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXAXUEd
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:04:33 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:33097 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbXAXUEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:04:32 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id DE99175D55;
	Wed, 24 Jan 2007 21:04:30 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 31CAD1F07B; Wed, 24 Jan 2007 21:03:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0701240437l33a53f64tfea8267b78bff421@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37670>

On Wed, Jan 24, 2007 at 12:37:15PM +0000, Catalin Marinas wrote:
> >Right - "branch --clone" could also use that (or maybe it does already
> >by design).  Together with this, "pick --fold" and possibly "sync"
> >(although I never used the latter so I'm not 100% sure how it works)
> >could register a merge, and sometime in the future we could use this
> >information to be able to do some merging.  I'm not going to look
> >into this soon, but I have this popping out regularly in my head ;)
> 
> 'sync' is still experimental. I usually have the same patches on
> different branches (i.e. a stable kernel branch for customers and a
> more up-to-date branch for pushing patches upstream).

That sounds like a typical usecase we should document :)

> I wanted a way to automatically synchronise the changes made to some
> patches found in both branches. This command folds the remote patch
> onto the current one using a three-way merge. If they are identical,
> the current patch shouldn't change. If they are not identical, it
> leads to conflicts that have to be manually solved.

So, indeed "sync" is a kind of merge tool already.  It could be a good
start to implement merging of forked patches.  But going further would
probably require to further develop the technics to work with patches
of patches.

best regards,
-- 
Yann.
