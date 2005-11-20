From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes
 through
Date: Mon, 21 Nov 2005 00:46:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210041370.24681@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051117230723.GD26122@nowhere.earth>
 <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth>
 <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de>
 <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051120223249.GI3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 00:47:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edytd-0005sL-Vt
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 00:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVKTXqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 18:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKTXqx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 18:46:53 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:18828 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932143AbVKTXqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 18:46:52 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4DFE313FD98; Mon, 21 Nov 2005 00:46:51 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2DC3C9F39C; Mon, 21 Nov 2005 00:46:51 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 130B39C78A; Mon, 21 Nov 2005 00:46:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C09B613FD98; Mon, 21 Nov 2005 00:46:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20051120223249.GI3393@nowhere.earth>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12412>

Hi,

On Sun, 20 Nov 2005, Yann Dirson wrote:

> On Sun, Nov 20, 2005 at 02:24:53AM +0100, Johannes Schindelin wrote:
> > 
> > ORIG1 .. ORIG2 .. .. ORIG_HEAD
> >                          |
> >                          |   GIT1 .. GIT2 .. .. GIT_HEAD
> >                          |   /                    /
> >                          | /                     /
> >                       UNIFYING_MERGE           /
> >                                    \         /
> >                                      \     /
> >                                NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES
> > 
> Note: it's not only about research (ie. something that would be static
> for browsing only), it's also about using the results of the research
> in further developement.

Then you could base your future development on 
NEW_HEAD_FOR_ARCHEOLOGICAL_PURPOSES.

> Well, no doubt this approach can be used in many cases.  But it makes
> IMHO the history somewhat confusing, and has limitations.  Let's say I
> had a patch against ORIG2, and at a later date I find a successor for
> it, based on GIT2.  I would not have an incarnation of GIT2 with ORIG2
> as ancestor: to be on the safe side I would have had to duplicate the
> whole GIT1..* history.

You could still branch from GIT2, cherry picking from the patch to ORIG2, 
and then committing the successor based on GIT2, thus reinstating the 
hypothetical history.

Note: the history may be confusing, but ask any history teacher: history 
*is* confusing! It is all about people. If you want to make it less 
confusing, I am afraid you have to leave the path of true history.

> And after I have done some work on my branch of duplicate commits, if
> I used the type of unifying merges you suggest, I'm stuck forever with
> the old GIT1..GIT_HEAD line, whether I need it or not (if it comes
> from import of 2.4 patches, and thus has no signed tags whatsoever, I
> do not need it any more).

But the GIT1..GIT_HEAD line was actually the correct history! Remember: He 
who forgets his past is doomed to repeat his mistakes! Don't pretend that 
the past was different than it was. It's not worth the hassle.

Ciao,
Dscho
