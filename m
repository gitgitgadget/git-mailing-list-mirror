From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 22:11:54 +0000
Message-ID: <20060315221154.GA6494@localhost.localdomain>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <7vacbrie79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 15 23:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJeDi-0008KT-8C
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 23:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWCOWLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWCOWLu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 17:11:50 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:61998 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751360AbWCOWLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 17:11:49 -0500
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060315221148.IGAX29343.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 15 Mar 2006 22:11:48 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout04-winn.ispmail.ntl.com with SMTP
          id <20060315221147.RLUA18957.aamtaout04-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Wed, 15 Mar 2006 22:11:47 +0000
Received: (qmail 6808 invoked by uid 1000); 15 Mar 2006 22:11:54 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacbrie79.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17618>

On Wed, Mar 15, 2006 at 01:35:22PM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Linus Torvalds <torvalds@osdl.org> writes:
> >
> >> I agree that it is inconsistent as-is. So a patch to make it use the 
> >> "git-repo-config" form (the argument being that internally, we use the 
> >> full names) might be good if just for consistency.
> >
> > If we do the dash-form for consistency's sake,...
> 
> Probably I should add that personally my preference is to standardize on
> the dashless form.
> 

That would remove the possibility to run "git-push" in my scenario.  And
what is the benefit?  Wasting CPU cycles to an extra execve?
Duplicating git --exec-path to PATH?

Personally I recommend to always run git helper programs with absolute
path, this would remove all confusions, not play with users' PATH
environment, and save CPU cycles.

Qingning
