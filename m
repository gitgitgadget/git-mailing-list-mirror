From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --contains flag to git tag
Date: Wed, 21 Jan 2009 09:21:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210919030.7929@racer>
References: <25058429.247441232510076471.JavaMail.root@scalix.vivisimo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:22:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYMK-0003j1-4M
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703AbZAUIVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbZAUIVW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:21:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:56566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1749667AbZAUIVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:21:22 -0500
Received: (qmail invoked by alias); 21 Jan 2009 08:21:20 -0000
Received: from pD9EB3014.dip0.t-ipconnect.de (EHLO noname) [217.235.48.20]
  by mail.gmx.net (mp058) with SMTP; 21 Jan 2009 09:21:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gZ10F3/7gz/RWvXFxupRTusefSeAMKc3CbQDtT2
	YjE45+slId7GLG
X-X-Sender: gene099@racer
In-Reply-To: <25058429.247441232510076471.JavaMail.root@scalix.vivisimo.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106575>

Hi,

On Tue, 20 Jan 2009, Jake Goulding wrote:

> I actually have 1 commit for the code change, one for documentation, and 
> one for the test case. Should I squash all these together?

In general, if the patches are not very large and logically belong 
together, it is a matter of taste if you squash together documentation and 
code changes.  Tests, however, belong with the code.

> Also, my test case is in a separate file (t7704-tag-contains.sh) as that 
> is how I read t/README. Was this incorrect?

Again, the size matters.  If it is a single test case, it is not worth a 
whole new file, especially when something like t7004-tag.sh already 
exists, whose name just asks for your test case to go in there.

Ciao,
Dscho
