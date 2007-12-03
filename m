From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Use regex for :/ matching
Date: Mon, 3 Dec 2007 10:55:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031052410.27959@racer.site>
References: <20071203043258.GA16658@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 11:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz8xy-0005kI-0K
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 11:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbXLCKzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 05:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXLCKzi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 05:55:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:46851 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751834AbXLCKzh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 05:55:37 -0500
Received: (qmail invoked by alias); 03 Dec 2007 10:55:35 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp010) with SMTP; 03 Dec 2007 11:55:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XVzhV8qHX3423zoXScZbp6Sn6O+TNnbW47ouWoM
	V4sA3hb0ZFawve
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203043258.GA16658@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66906>

Hi,

On Sun, 2 Dec 2007, Jeff King wrote:

> The sha1 syntax :/ used to be a strict prefix match.
> Instead, let's use a regular expression, which can save on
> typing. E.g.,
> 
>   git show :/"object name: introduce ':/<oneline prefix>'"
> 
> vs
> 
>   git show :/introduce..:/.oneline

Heh: 
http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=2546cd9732bb8d4bc1d2485ba7bbc1d5c8bac935

Except that I did not support ".." (does yours?), _and_ that my patch is 
not as nice as yours.

But then, my patch also works when save_commit_buffer == 0.  But I can 
refactor this into its own patch, since it really is a separate issue.

Ciao,
Dscho
