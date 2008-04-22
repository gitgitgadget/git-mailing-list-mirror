From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 16:39:26 +0300
Message-ID: <20080422133926.GB3098@mithlond.arda.local>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:42:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIkA-0002yY-RQ
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763444AbYDVNkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762993AbYDVNkR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:40:17 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:47588 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762439AbYDVNkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 09:40:16 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A0047A7B1; Tue, 22 Apr 2008 15:39:29 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JoIiU-0002Ae-Px; Tue, 22 Apr 2008 16:39:26 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80118>

Johannes Schindelin wrote (2008-04-22 13:56 +0100):

> With the --mirror mode, you can no longer discern clearly between
> local and remote branches.  This is basically what we had in the
> beginning, before the "separate remotes layout".

Hmm, to me it looks like --mirror is for mirroring remote repository and
hence the "+" makes sense in here too. It's like "I want to make my
repository a copy of that remote repository" hence the name 'mirror'.
It'll possibly overwrite local branches but in my way of thinking
mirroring implies that possibility. The 'git remote' manual says that
--mirror "only makes sense in bare repositories", so the manual seems to
guide towards not having local working directory nor changes.
