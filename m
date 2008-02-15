From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-clone should create packed refs
Date: Fri, 15 Feb 2008 00:53:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802150051320.30505@racer.site>
References: <200802150133.19247.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 01:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPopw-0000fz-Si
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 01:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYBOAxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 19:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYBOAxW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 19:53:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:37190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbYBOAxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 19:53:20 -0500
Received: (qmail invoked by alias); 15 Feb 2008 00:53:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 15 Feb 2008 01:53:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CI7QH9dLCx6yI2SR/iUZicEN2yBNMP0Pfa9Rqxv
	zXUi02yVov0W9U
X-X-Sender: gene099@racer.site
In-Reply-To: <200802150133.19247.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73934>

Hi,

On Fri, 15 Feb 2008, Johan Herland wrote:

> when git-clone is cloning repos with thousands of refs, it makes sense 
> to create a packed-refs file directly in the clone, instead of having to 
> run "git pack-refs" (or "git gc") afterwards to (re)pack the refs.

Sure, and it's easy, too.  The format of the packed-refs file is exactly 
the same as the output of "git ls-remote <origin>".

Ciao,
Dscho
