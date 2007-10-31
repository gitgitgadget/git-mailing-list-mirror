From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-rebase--interactive.sh: Make 3-way merge strategies
 work for -p.
Date: Wed, 31 Oct 2007 02:42:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310239100.4362@racer.site>
References: <1193797232-1062-1-git-send-email-B.Steinbrink@gmx.de>
 <1193797232-1062-2-git-send-email-B.Steinbrink@gmx.de>
 <1193797232-1062-3-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-319672811-1193798523=:4362"
Cc: git@vger.kernel.org
To: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3YI-0004Gb-Nf
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbXJaCnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbXJaCnQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:43:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:38960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752183AbXJaCnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:43:16 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:43:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp039) with SMTP; 31 Oct 2007 03:43:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aSQ9+CVAaZTmUQ7icX/Ng8CDiHxb2qLrimolMHs
	eiUHMayzI90y30
X-X-Sender: gene099@racer.site
In-Reply-To: <1193797232-1062-3-git-send-email-B.Steinbrink@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62785>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-319672811-1193798523=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Björn,

On Wed, 31 Oct 2007, Björn Steinbrink wrote:

> +			new_parents=${new_parents# $first_parent}

I wanted to comment that this might not be present in shells other than 
bash, but I see that we rely on that construct already in am, clone, 
commit, filter-branch, merge, pull, rebase, stash and submodule.

So I think it's okay.

The whole series is _very_ nicely done, and appears to me as obviously 
correct.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks,
Dscho

--8323584-319672811-1193798523=:4362--
