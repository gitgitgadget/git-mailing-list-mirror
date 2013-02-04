From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Sun, 3 Feb 2013 18:48:00 -0600
Message-ID: <20130204004800.GC6243@kroah.com>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
 <20130131174103.GA20111@kroah.com>
 <510AAF4F.6060201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
To: Konstantin Ryabitsev <mricon@kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2CeJ-0008Cs-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 04:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913Ab3BDDWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 22:22:44 -0500
Received: from mail.kernel.org ([198.145.19.201]:49317 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab3BDDWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 22:22:38 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 582EF20275;
	Mon,  4 Feb 2013 03:22:37 +0000 (UTC)
Received: from localhost (1007host2.starwoodbroadband.com [12.108.174.2])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7AF842026E;
	Mon,  4 Feb 2013 03:22:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <510AAF4F.6060201@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215352>

On Thu, Jan 31, 2013 at 12:52:15PM -0500, Konstantin Ryabitsev wrote:
> On 31/01/13 12:41 PM, Greg KH wrote:
> > Ugh, uploading a 431Mb file, over a flaky wireless connection (I end up
> > doing lots of kernel releases while traveling), would be a horrible
> > change.  I'd rather just keep using the same older version of git that
> > kernel.org is running instead.
> 
> Well, we do accept compressed archives, so you would be uploading about
> 80MB instead of 431MB, but that would still be a problem for anyone
> releasing large tarballs over unreliable connections. I know you
> routinely do 2-3 releases at once, so that would still mean uploading
> 120-180MB.

That would mean I can't do kernel releases while on ferry rides, which
is probably a good thing in the end :)

> I don't have immediate statistics on how many people release using "kup
> --tar", but I know that at least you and Linus rely on that exclusively.

What causes you to upgrade the version of git on the server?  Are you
relying on packages for a distro, or is this "hand installed" by
yourself?  As long as I stay in lock-step with your updates, all should
be fine.

Oh, maybe we can report back to the user, the version of git that is
being used on the server, if the checksums don't match, so that I know
to at least see if my version is different from yours?

thanks,

greg k-h
