From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about git-log --date and default behavior
Date: Mon, 27 Aug 2007 09:44:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708270943490.28586@racer.site>
References: <m2ejhpc1j0.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Seth Falcon <sfalcon@fhcrc.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaB0-0007PD-RM
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXH0ImX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXH0ImX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:42:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751109AbXH0ImX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:42:23 -0400
Received: (qmail invoked by alias); 27 Aug 2007 08:42:21 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp044) with SMTP; 27 Aug 2007 10:42:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zgaNF8OazZVzEphPJ5DRh/yKXXY3hwT5ufnLK32
	3gQ4DOy9pfrWVd
X-X-Sender: gene099@racer.site
In-Reply-To: <m2ejhpc1j0.fsf@ziti.fhcrc.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56783>

Hi,

On Sun, 26 Aug 2007, Seth Falcon wrote:

> Is there a way have git-log use --date=local as the default for my
> repositories?

I guess this could break scripts (AFAIR gitk uses "git log" instead of 
"git rev-list" these days, and parses the output).

Better stay with your alias.

Ciao,
Dscho
