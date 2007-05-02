From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:27:51 +0200
Message-ID: <200705021827.51335.kendy@suse.cz>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz> <20070502161515.GC4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org, dev@tools.openoffice.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 18:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHgL-0008R6-4c
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993482AbXEBQ1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993486AbXEBQ1y
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:27:54 -0400
Received: from styx.suse.cz ([82.119.242.94]:58370 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S2993482AbXEBQ1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:27:53 -0400
Received: from one.suse.cz (one.suse.cz [10.20.1.79])
	by mail.suse.cz (SUSE LINUX ESMTP Mailer) with ESMTP id 0C8ED62811A;
	Wed,  2 May 2007 18:27:52 +0200 (CEST)
User-Agent: KMail/1.9.1
In-Reply-To: <20070502161515.GC4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46033>

Hi Pasky,

On Wednesday 02 May 2007 18:15, Petr Baudis wrote:

> On Wed, May 02, 2007 at 04:24:24PM CEST, Jan Holesovsky wrote:
> > > What might help here is splitting repository into current (e.g. from
> > > OOo 2.0) and historical part,
> >
> > No, I don't want this ;-)
>
> Are you sure? Using the graft mechanism, Git can make this very easy and
> almost transparent for the user - when he clones he gets no history but
> he can use say some simple vendor-provided script to download the
> historical packfile and graft it to the 'current' tree. After that, the
> graft acts completely transparently and it 'seems' like the history
> goes on continuously from OOo prehistory up to the latest commit.

Interesting, I did not know that it is possible to do it so that it appears 
transparently; this would be indeed a tremendous win - we could start nearly 
from scratch ;-)

Please - where could I find more info?  Like what does the script have to do, 
etc.

> Besides, in case you discover a year later that the conversion was
> broken in some places etc., you can just fix this, re-run the conversion
> and simply regraft your history to point at the 'new' historical commit,
> without affecting your current development and commit ids at all. For
> this reason alone, I'd seriously consider grafting history separately
> when migrating any non-trivial project from other SCM to Git.
>
> Then again, due to the sheer tree sizes etc., I'm not sure how much
> would throwing the history away actually reduce the packfile size.

Thanks a lot,
Jan
