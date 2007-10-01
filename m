From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Referring a commit-id remote repo.
Date: Mon, 1 Oct 2007 11:25:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011122500.28395@racer.site>
References: <20071001041635.GA22102@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 12:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcITz-0003et-Oj
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXJAK02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXJAK01
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:26:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:60085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751238AbXJAK01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:26:27 -0400
Received: (qmail invoked by alias); 01 Oct 2007 10:26:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 01 Oct 2007 12:26:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wAvMuJGRwNuAgtFIFsEYS36PKGyZOdj5lTE+1hl
	jLTCzQyrdeXmT8
X-X-Sender: gene099@racer.site
In-Reply-To: <20071001041635.GA22102@old.davidb.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59595>

Hi,

On Sun, 30 Sep 2007, David Brown wrote:

> The question I have: is there any way I can look at this particular 
> commit ID on the remote repo?  I couldn't come up with any way to get 
> git fetch to retrieve it.

Unless you have push access, no.  And this is very much by design.  For 
example, when somebody mistakenly pushed a secret (like what lines in the 
kernel infringe on M$ patents, if any) it should be possible to rebase (in 
a hurry), force a push, and have the safe feeling that nobody can fetch 
the secret any longer.

Ciao,
Dscho
