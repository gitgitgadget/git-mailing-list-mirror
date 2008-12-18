From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff should not fire up $PAGER, period!
Date: Thu, 18 Dec 2008 04:22:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812180419090.14632@racer>
References: <3c6c07c20812171818k6b6e3555ja991e20d74d8291b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9VF-0003gL-ME
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYLRDX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYLRDX0
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:23:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:39432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751807AbYLRDXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:23:25 -0500
Received: (qmail invoked by alias); 18 Dec 2008 03:23:23 -0000
Received: from pD9EB2D4F.dip0.t-ipconnect.de (EHLO noname) [217.235.45.79]
  by mail.gmx.net (mp049) with SMTP; 18 Dec 2008 04:23:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/BgSxdRgTB8SYotX+mzHhrSb4sD33D/e8C2ARvLX
	hvRbNCKwOhS/Up
X-X-Sender: gene099@racer
In-Reply-To: <3c6c07c20812171818k6b6e3555ja991e20d74d8291b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103427>

Hi,

On Wed, 17 Dec 2008, Mike Coleman wrote:

> I still find git-diff's unsolicited invocation of $PAGER a bit
> jarring, but I also find that I like it.

It might have its reason in that it follows the common flow, where 
interactive use of _any_ diff program is _just useless_ unless piped to a 
pager.

And no, redirecting to a file is not interactive.

Can we please stop with those bogus and pointless, not to mention 
uninformed, discussions about design decisions that have been verified to 
be useful, or at least not harmful in any way, for a _long_, _long_ time?

The git list is high volume already, but at least so far it was high 
signal/noise ratio.

Let's keep it that way,
Dscho
