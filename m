From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: fix dash complaining about "Missing '))'"
Date: Tue, 24 Jul 2007 23:22:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707242321470.14781@racer.site>
References: <46A66F39.20507@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDSm2-0003cQ-CU
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 00:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbXGXWWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbXGXWWb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 18:22:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:59963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752671AbXGXWWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 18:22:31 -0400
Received: (qmail invoked by alias); 24 Jul 2007 22:22:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 25 Jul 2007 00:22:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XwdNSiL8XvWwSUCekoa8NuIHFrAT+NjijYn3jyF
	o3jtraMFVP15s/
X-X-Sender: gene099@racer.site
In-Reply-To: <46A66F39.20507@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53654>

Hi,

On Tue, 24 Jul 2007, Ren? Scharfe wrote:

> On e.g. Ubuntu, dash is used as /bin/sh.  Unlike bash it parses
> commands like
> 
>   a=$((echo stuff) | wc)
> 
> as an arithmetic expression while what we want is a subshell inside
> a command substitution.

Ah, well.  I think I should switch to Ubuntu, to suffer the same...

Ciao,
Dscho
