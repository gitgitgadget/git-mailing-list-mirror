From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Sun, 18 Feb 2007 18:35:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702181834340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45D88A14.4040400@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 18:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIpwz-0004Jx-SJ
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 18:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXBRRfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 12:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbXBRRfr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 12:35:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:47045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbXBRRfq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 12:35:46 -0500
Received: (qmail invoked by alias); 18 Feb 2007 17:35:45 -0000
X-Provags-ID: V01U2FsdGVkX1/oghNQxNnoHlgnp/WkXWJzStjxj12rfOSLz5/mVS
	C7lw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D88A14.4040400@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40081>

Hi,

On Sun, 18 Feb 2007, Simon 'corecode' Schubert wrote:

> This is necessary if using CVS in an asymmetric fashion, i.e. when the
> CVSROOT you are checking out from differs from the CVSROOT you have to
> commit to.

Does

	CVSROOT=bla git-cvsexportcommit...

not work?

Ciao,
Dscho
