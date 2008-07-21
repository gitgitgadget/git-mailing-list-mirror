From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library 1.5.0
Date: Sun, 20 Jul 2008 18:29:55 -0700
Message-ID: <20080721012955.GA14129@untitled>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org> <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org> <37fcd2780807171137m1c5a8197vc94b2a42ac53a297@mail.gmail.com> <7vbq0tibuf.fsf@gitster.siamese.dyndns.org> <20080720201407.GM2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKkEq-0006gT-8Q
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbYGUB35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756334AbYGUB35
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:29:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55789 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657AbYGUB34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:29:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B96087F419B;
	Sun, 20 Jul 2008 18:29:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080720201407.GM2925@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89291>

Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sat, Jul 19, 2008 at 06:27:36PM -0700, Junio C Hamano wrote:
> > 
> > So what's the conclusion of this issue?
> > 
> > I'll just revert 2fe403e (git-svn.perl: workaround assertions in svn
> > library 1.5.0, 2008-07-06) for 1.6.0-rc0 unless I hear better
> > suggestions.
> 
> I have tested the change that I proposed, and it seems to solve the
> problem and, as far as I can tell, no other correction is necessary.
> Yet, I don't really understand git-svn well, so I could be wrong.
> 
> Reverting 2fe403e will only help users of svn library 1.4, while all
> new linux distributives, which will include Git 1.6.0, are going to
> install svn library 1.5.0, and if you use svn library 1.5.0, reverting
> 2fe403e does not fix anything but only add one more bug. Thus, unless
> we are going to require to install git-svn only with svn library 1.4,
> reverting this change does not seem to be very helpful for most users.
> 
> So, I hope my patch is better solution...
> 
> Dmitry

Thanks Dmitry,

Your patch works for me on 1.4.3, so if it works with
1.5.0, consider it: Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
