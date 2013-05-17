From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 15:34:57 +0200
Message-ID: <20130517133457.GA11496@inner.h.apk.li>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu> <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com> <5195F3EB.8000308@alum.mit.edu> <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com> <51962D52.7070200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 17 16:03:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdLG1-000299-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 16:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab3EQODh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 10:03:37 -0400
Received: from continuum.iocl.org ([217.140.74.2]:33475 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3EQODh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 10:03:37 -0400
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2013 10:03:36 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4HDYv211738;
	Fri, 17 May 2013 15:34:57 +0200
Content-Disposition: inline
In-Reply-To: <51962D52.7070200@alum.mit.edu>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224691>

On Fri, 17 May 2013 15:14:58 +0000, Michael Haggerty wrote:
...
> We both know that the CVS history omits important data, and that the
> history is mutable, etc.  So there are lots of hypothetical histories
> that do not contradict CVS.  But some things are recorded unambiguously
> in the CVS history, like
> 
> * The contents at any tag or the tip of any branch (i.e., what is in the
> working tree when you check it out).

Except that the tags/branches may be made in a way that can't
be mapped onto any commit/point of history otherwise exported,
with branches that are done on parts of the trees first, or
likewise tags.

...
> That being said, I appreciate that cvsimport can do incremental imports.
>  cvs2git doesn't even attempt it.  I've thought about what it would take
> to implement correct incremental imports in cvs2svn/cvs2git, and it is

Do these two produce stable output? That is, return the same commits
for multiple runs on the same repo?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
