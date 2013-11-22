From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 17:52:37 +0100
Message-ID: <87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 17:52:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjtyR-0007a7-JH
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 17:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab3KVQwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 11:52:51 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:49970 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab3KVQwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 11:52:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E498F4D6580;
	Fri, 22 Nov 2013 17:52:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lK0_ASrhHj4l; Fri, 22 Nov 2013 17:52:39 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 60A004D6414;
	Fri, 22 Nov 2013 17:52:38 +0100 (CET)
In-Reply-To: <20131122102345.GC12042@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2013 05:23:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238196>

Jeff King <peff@peff.net> writes:

>> * jk/pack-bitmap (2013-11-18) 22 commits
[...]
>>  Borrows the bitmap index into packfiles from JGit to speed up
>>  enumeration of objects involved in a commit range without having to
>>  fully traverse the history.
>
> Looks like you picked up my latest re-roll with Ramsay's fix on top.
> There wasn't a lot of review on this past round (I'm not surprised; it's
> a dauntingly large chunk to review).  I outlined a few possible open
> issues in the cover letter, but I'd be happy to build those on top,
> which I think will make review of them a lot easier.
>
> Do we want to try this in 'next' post-1.8.5, or should I try to prod an
> area expert like Shawn into doing another round of review?

Hmm, maybe I missed something, but AFAICS you (or Vicent) never acted on
or responded to my June reviews in this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/228918

and again mentioned here, though I didn't point out all of them:

  http://thread.gmane.org/gmane.comp.version-control.git/236587/focus=236740

Granted, the way I verified this was checking whether you renamed
rlw_xor_run_bit() to something more fitting, so perhaps you just forgot
that one thing but did all the rest.

-- 
Thomas Rast
tr@thomasrast.ch
