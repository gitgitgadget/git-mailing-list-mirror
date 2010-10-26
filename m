From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 23/23] Provide 'git merge --abort' as a synonym to 'git
 reset --merge'
Date: Tue, 26 Oct 2010 03:26:32 +0200
Message-ID: <201010260326.33200.johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <20101025013217.GA25355@burratino> <201010251203.00389.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 26 03:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAYJH-0006WX-7M
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 03:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0JZB0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 21:26:37 -0400
Received: from smtp.getmail.no ([84.208.15.66]:48625 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab0JZB0g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 21:26:36 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV0062OIOBXN00@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:26:35 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 113F217993A5_CC62E4BB	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:26:35 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7E80717962BC_CC62E4AF	for <git@vger.kernel.org>; Tue,
 26 Oct 2010 01:26:34 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAV00JGGIOA8F00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 Oct 2010 03:26:34 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <201010251203.00389.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159975>

On Monday 25 October 2010, Johan Herland wrote:
> On Monday 25 October 2010, Jonathan Nieder wrote:
> > Johan Herland wrote:
> > >                                                  However, if there
> > > +were uncommitted changes when the merge started (and these changes
> > > +did not interfere with the merge itself, otherwise the merge would
> > > +have refused to start), and then additional modifications were made
> > > +to these uncommitted changes, 'git merge --abort' will not be able
> > 
> > > +reconstruct the original (pre-merge) uncommitted changes. Therefore:
> > I do not find this clear.  Could you give an example?

[...]

> > > +# - dirty worktree before merge matches contents on remote branch
> > 
> > Or maybe this was the example.  Here was Junio's explanation of it:
> > | It will discard the change, the one you independently picked up, but
> > | the change agreed with what was done by the the trash history that
> > | you are cancelling merge with.  You wouldn't miss losing the same
> > | change as in that trash history.
> 
> Yeah, but I've now found that I failed to test that case. Will be fixed
> in the next iteration.

Instead of sending an entire new patch series when I've only changed the 
last two patches, I'm gonna send only those two patches, marked "PATCHv5.1", 
as a reply to this email.


Hope this is ok,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
