From: MikeW <mw_phil@yahoo.co.uk>
Subject: Re: A good Git technique for referring back to original files
Date: Wed, 13 Feb 2013 12:50:42 +0000 (UTC)
Message-ID: <loom.20130213T134501-179@post.gmane.org>
References: <loom.20130212T085620-989@post.gmane.org> <vpq1ucl9agt.fsf@grenoble-inp.fr> <loom.20130212T110458-119@post.gmane.org> <CALeLG_nFgApPT1B+6sPy7P+jrtjB4KQOBpPO9bEd0rsWKqWi8A@mail.gmail.com> <loom.20130213T123734-484@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 13:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5boi-0001fE-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 13:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586Ab3BMMvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 07:51:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:45482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932438Ab3BMMvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 07:51:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U5bnx-0000Vn-4s
	for git@vger.kernel.org; Wed, 13 Feb 2013 13:51:17 +0100
Received: from static.kpn.net ([static.kpn.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 13:51:17 +0100
Received: from mw_phil by static.kpn.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 13:51:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.204.2.113 (Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216255>

MikeW <mw_phil <at> yahoo.co.uk> writes:

> 
> Paul Campbell <pcampbell <at> kemitix.net> writes:
> 
> > 
> > Hi Mike,
> > 
> > I think git-cvsimport and git-subtree could help you here.
> > 
> 
> That looks very interesting, had not considered git subtree and it looks like
> the right kind of method.
> 
> Thanks.
> Mike

The only alternative I can think of is to scan through Working_SDK and replace
the files there with symlinks back to the matching files within the
original subprojects - such scripts exist !

Then any changes in Working_SDK will update the (baselined) originals in-place.

But then no explicit use of git except for tracking work prior to pushing
back to CVS.

Oh well, thanks for ideas, will see which work best.

Mike
