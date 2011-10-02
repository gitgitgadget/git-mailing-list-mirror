From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sun, 2 Oct 2011 08:38:57 +0200
Message-ID: <20111002063857.GA9385@inner.h.iocl.org>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com> <m3lit4oo9q.fsf@localhost.localdomain> <CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com> <CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com> <CAN0CFw2gVH7=LdKhseE3zo+Av_=kVdz=tH3s=BKeTK9bDOprcw@mail.gmail.com> <CACsJy8B2rhXvGKUsu10Po8cCi7p8uqWXWE5ZHB2Z6hH-aMyR2Q@mail.gmail.com> <CAN0CFw3ZDcXtD7WChjkT1Vg0cU_u==4KCHo8ff-ccbyxZ8xWjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 08:39:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAFhm-00011s-TE
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 08:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab1JBGjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 02:39:04 -0400
Received: from continuum.iocl.org ([217.140.74.2]:34597 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1JBGjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 02:39:01 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p926cvK11796;
	Sun, 2 Oct 2011 08:38:57 +0200
Content-Disposition: inline
In-Reply-To: <CAN0CFw3ZDcXtD7WChjkT1Vg0cU_u==4KCHo8ff-ccbyxZ8xWjg@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182596>

On Sat, 01 Oct 2011 20:34:43 +0000, Grant wrote:
...
> That's true.  I hope to be able to give different developers access to
> different parts of the code.  I really don't know if this will work.

Depending on the implementation it may drive away the good devs...

Anyway, what I think you need (for the reasons detailed in the svn list)
is a setup where the whole project is checked out in the staging area
where it can be tested in whatever way. That under a user id different
from the dev's. Then you change permissions so that he can only see
and edit the files you want him to. This at least eases the problem
of having to commit for each test, and gives you a meaningful history.
Additionally have sudo permissions to do commits etc. in the staging area.

(But still the dev's life will be, erm, suboptimal.)

> I just don't want my code to be stolen and I'm trying to find some way
> to prevent that from happening.

I'm just getting creative. When the one file that you allow access to
is server-side code (as opposed to, say, css or client js) then the
malevolent dev can use that to read the rest of the staging area anyway.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
