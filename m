From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 16:21:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness>
References: <20080409101428.GA2637@elte.hu> <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 17:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkL5G-0002dN-4v
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 17:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908AbYDKPVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759691AbYDKPVt
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 11:21:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:43041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759639AbYDKPVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 11:21:48 -0400
Received: (qmail invoked by alias); 11 Apr 2008 15:21:45 -0000
Received: from unknown (EHLO eeepc-johanness.home) [138.251.11.75]
  by mail.gmx.net (mp022) with SMTP; 11 Apr 2008 17:21:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OTP5VPLSOMMwmIywF2Vygxeuu9OJwygRtZZdupq
	Qojy+mtDA/jxdl
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1207869946-17013-1-git-send-email-g2p.code@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79277>

Hi,

On Fri, 11 Apr 2008, Gabriel wrote:

> +	else {
> +		printf ("Added remote repository `%s' without fetching it.\n"
> +			"Before accessing the branches of this "
> +			"remote, run `git fetch %s' "
> +			"or `git remote update'.\n", name, name);

Is this really, really necessary?  I was quite happy when a few people 
made Git less chatty, recently.

Ciao,
Dscho
