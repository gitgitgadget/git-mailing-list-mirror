From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Fri, 19 Oct 2007 21:05:04 +1000
Message-ID: <18200.36704.936554.220173@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 13:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiplj-0006dz-Iv
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:11:55 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Iipla-0000Sh-FH
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:11:46 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IiplR-0001rj-TQ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 13:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbXJSLFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 07:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXJSLFb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:05:31 -0400
Received: from ozlabs.org ([203.10.76.45]:59454 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbXJSLFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 07:05:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1CA9BDDE9A; Fri, 19 Oct 2007 21:05:29 +1000 (EST)
In-Reply-To: <20071019052823.GI14735@spearce.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, AWL=2.020,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 06B054C8D29328B25539AE7EDC33AF67CAA07704
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 16 total 622551 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61688>

Shawn O. Pearce writes:

> The following changes since commit 719c2b9d926bf2be4879015e3620d27d32f007b6:
>   Paul Mackerras (1):
>         gitk: Fix bug causing undefined variable error when cherry-picking
> 
> are available in the git repository at:
> 
>   git://repo.or.cz:/git/spearce.git gitk

OK, but ...

> Jonathan del Strother (2):
>       gitk: Added support for OS X mouse wheel
>       Fixing gitk indentation

This one is bogus.  Firstly, it doesn't have "gitk:" at the start of
the headline (and "Fixing" should be "Fix").  Secondly, the actual
change itself is bogus.  It changes an initial tab to 8 spaces on each
of 4 lines.  I like it the way it is - and if he wanted to change it,
he should have changed it throughout the file, not just on 4 lines.
So that change is rejected.

The other changes are OK.  If you could re-do your tree without
0d6df4de (and possible change "Added" to "Add" in e1b5683c while
you're at it), I'll do the pull.

Paul.
