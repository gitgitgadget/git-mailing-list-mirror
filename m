From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 17:16:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141715470.25221@racer.site>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih693-00007D-Vh
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbXJNQQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 12:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbXJNQQi
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:16:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:44924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757584AbXJNQQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 12:16:37 -0400
Received: (qmail invoked by alias); 14 Oct 2007 16:16:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 14 Oct 2007 18:16:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/npTZuE3nn/ehWPKfZTXwvUohheB3kGWKiPHtDYW
	duOKqEBL3SQg/x
X-X-Sender: gene099@racer.site
In-Reply-To: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60861>

Hi,

On Sun, 14 Oct 2007, Christian Couder wrote:

> Here is my bisect dunno patch series again.
> The changes since last time are the following:
> 
> [PATCH 1/7] rev-list: implement --bisect-all
> [PATCH 2/7] Bisect: fix some white spaces and empty lines breakages.
> 
> -> No change.
> 
> [PATCH 3/7] Bisect: implement "bisect dunno" to mark untestable revisions.
> 
> -> Added dunno stuff in "bisect_replay" that I had forgotten.
> -> Use "bisect_write_good" and "bisect_write_bad" in "bisect_replay" 
> while at it.
> 
> [PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
> [PATCH 5/7] Bisect: factorise some logging into "bisect_write".
> [PATCH 6/7] Bisect: factorise "bisect_{bad,good,dunno}" into "bisect_state".
> 
> -> Some new factorisation and clean up work.
> 
> [PATCH 7/7] Bisect: add "bisect dunno" to the documentation.
> 
> -> Document "bisect dunno" and fix some short usage descriptions.

Thanks for doing this.  I think that especially the factorisation adds 
tremendously to the readibility.

Ciao,
Dscho
