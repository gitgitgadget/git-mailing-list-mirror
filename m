From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-diff: don't squelch the new SHA1 in submodule diffs
Date: Sun, 9 Sep 2007 01:18:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709090117331.28586@racer.site>
References: <20070908103022.GA15229MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Sep 09 11:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUION-0003wm-Op
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:43 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAde-0004dg-9W
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:26:58 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAdX-0006Os-UE
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXIIATK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbXIIATI
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:19:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:34864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755359AbXIIATH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:19:07 -0400
Received: (qmail invoked by alias); 09 Sep 2007 00:19:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 09 Sep 2007 02:19:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N1spp7GpNbpagugAwyZHwapzG2WfgkEtR+27v0X
	r/NLXuFPqXZgTB
X-X-Sender: gene099@racer.site
In-Reply-To: <20070908103022.GA15229MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: D4CFE4DC16C40E8BAD1D3B18F82697B12019371A
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 17 total 517803 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58162>

Hi,

On Sat, 8 Sep 2007, Sven Verdoolaege wrote:

> The code to squelch empty diffs introduced by commit
> fb13227e089f22dc31a3b1624559153821056848 would inadvertently
> populate filespec "two" of a submodule change using the uninitialized
> (null) SHA1, thereby replacing the submodule SHA1 by 0{40} in the output.
> 
> This change teaches diffcore_skip_stat_unmatch to handle
> submodule changes correctly.

Ah, I was wondering... This struck me as odd in msysGit, but I did not 
know if it was a problem I introduced in 4msysgit or not.  Unfortunately, 
I did not have the time to investigate further.

Thanks,
Dscho
