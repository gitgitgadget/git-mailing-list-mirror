From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 13:48:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181344520.14781@racer.site>
References: <86bqe9lwy8.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:48:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB8xU-0004wc-Qo
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 14:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXGRMsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 08:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbXGRMsq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 08:48:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:46514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752614AbXGRMsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 08:48:45 -0400
Received: (qmail invoked by alias); 18 Jul 2007 12:48:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 18 Jul 2007 14:48:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+x2ixURlaxFmasbVxlSbl8K7egy8KKv78wfjGpvj
	nlmcbtki94Ughb
X-X-Sender: gene099@racer.site
In-Reply-To: <86bqe9lwy8.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52858>

Hi,

On Wed, 18 Jul 2007, David Kastrup wrote:

> Use this, for example, to do
> rm -rf /opt/git
> make prefix=/opt/git install
> make symlinkprefix=/usr/local prefix=/opt/git install-symlinks

You mean

	This target allows you to have git installed in one location,
	and have symbolic links to all of the programs installed in 
	another	location.  For example, if git was installed to /opt/git
	with

		make prefix=/opt/git install

	you can install symbolic links in /usr/local/bin with

		make symlinkprefix=/usr/local prefix=/opt/git \
			install-symlinks

Hmm.  Why not install it with a proper package manager in the correct 
place to begin with?  Somehow I find so many symbolic links ugly.

Ciao,
Dscho
