From: Johan Herland <johan@herland.net>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive
 filesystems
Date: Thu, 24 Feb 2011 09:50:27 +0100
Message-ID: <201102240950.27139.johan@herland.net>
References: <201102231811.45948.johan@herland.net>
 <201102240158.24363.johan@herland.net>
 <7v8vx643z4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 09:50:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsWuD-0007oD-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 09:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1BXIuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 03:50:32 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44129 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab1BXIuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 03:50:32 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH40090L5W6WM50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 09:50:30 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9F2821EEEE84_D661BD6B	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 08:50:30 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 848DB1EEEE6D_D661BD6F	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 08:50:30 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH400E415W5PY10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 09:50:30 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7v8vx643z4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167784>

On Thursday 24 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Wednesday 23 February 2011, Junio C Hamano wrote:
> >> I think two things are sensible to do, are relatively low hanging
> >> fruits,
> >> 
> >> and are of low risk:
> >>  - break checkout on such a tree on incapable filesystems; and
> > 
> > Wouldn't that be a regression from the current state (where the poor
> > user in a case-insensitive worktree can at least "git rm" the
> > offending files, and keep working without assistance from a
> > case-sensitive worktree)?
> 
> Depends on the definition of "break".  I meant "exit with non-zero
> status", not necessarily changing what is left in the working tree from
> what the current code gives us.

Ah, ok. I have no problem with that.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
