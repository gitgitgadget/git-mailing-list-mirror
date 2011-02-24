From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 02:04:20 +0100
Message-ID: <201102240204.20822.johan@herland.net>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <201102240052.36379.johan@herland.net>
 <7voc6245yp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 02:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPdA-0007vL-1Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 02:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab1BXBEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 20:04:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58478 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab1BXBEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 20:04:23 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH300090KB9T780@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 02:04:21 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CB6511EEEF15_D65AE95B	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 01:04:21 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 91E091EEEE9E_D65AE95F	for <git@vger.kernel.org>; Thu,
 24 Feb 2011 01:04:21 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LH300NVBKB91B10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Feb 2011 02:04:21 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7voc6245yp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167761>

On Thursday 24 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > On Thursday 24 February 2011, Junio C Hamano wrote:
> >> Here are the topics that have been cooking.  Commits prefixed with '-'
> >> are only in 'pu' while commits prefixed with '+' are in 'next'.
> >> 
> >> [...]
> >> * jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
> >> 
> >>  - branch/checkout --track: Ensure that upstream branch is indeed a
> >> 
> >> branch
> >> 
> >> This supersedes "do not track HEAD" from Thomas.
> > 
> > What do you mean by "supersedes"? It builds on top of Thomas' patch (v2
> > was rebased on top it), but it does not _replace_ Thomas' patch.
> 
> I judge that the earlier one to special case only "HEAD" a failed attempt
> to the wider problem; what was posted to the list might have been
> relative to it, but what is queued reverts the effect of the previous
> patch and is relative to the mainline.

Ah, I see. I'm good with that. :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
