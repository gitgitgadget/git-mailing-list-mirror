From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Limit filename for format-patch
Date: Sat, 24 Feb 2007 02:27:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240227150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702232239.19504.robin.rosenberg@dewire.com>
 <20070223222606.28660.46208.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKlhe-0001kQ-UU
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313AbXBXB14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933314AbXBXB14
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:27:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:33056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933313AbXBXB1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:27:55 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:27:54 -0000
X-Provags-ID: V01U2FsdGVkX19rolUJwVBrzrWnVInydJmzuOve8lJRnabjSXwezm
	fUgQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070223222606.28660.46208.stgit@lathund.dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40480>

Hi,

On Fri, 23 Feb 2007, Robin Rosenberg wrote:

> Badly formatted commits may have very long comments. This causes 
> git-format-patch to fail. To avoid that, truncate the filename to a 
> value we believe will always work.
> 
> Err out if the patch file cannot be created.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

In only read the patch, but it looks sane enough. Acked-by: me.

Ciao,
Dscho
