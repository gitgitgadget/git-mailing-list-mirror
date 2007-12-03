From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reorder msgfmt command-line arguments.
Date: Mon, 3 Dec 2007 18:05:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031805310.27959@racer.site>
References: <20071203012631.GA22450@crustytoothpaste.ath.cx>
 <Pine.LNX.4.64.0712031034200.27959@racer.site> <20071203170402.GA13712@crustytoothpaste.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFgh-0003FX-47
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbXLCSGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXLCSGO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:06:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:49205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751338AbXLCSGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:06:14 -0500
Received: (qmail invoked by alias); 03 Dec 2007 18:06:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 03 Dec 2007 19:06:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194NWFszkx4cVjHLFeAaDtFvE+/oWGTbZeVRBjwwS
	yDk5S9Kx4citO5
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203170402.GA13712@crustytoothpaste.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66933>

Hi,

On Mon, 3 Dec 2007, brian m. carlson wrote:

> On Mon, Dec 03, 2007 at 10:35:33AM +0000, Johannes Schindelin wrote:
> > On Mon, 3 Dec 2007, brian m. carlson wrote:
> > 
> > > Any program using getopt or getopt_long will stop processing options 
> > > once a non-option argument has been encountered, if POSIXLY_CORRECT 
> > > is set.
> > 
> > So have you tested that msgfmt indeed does not work with the present 
> > command line?
> 
> Yes.  I run with POSIXLY_CORRECT set to 1, and it does indeed break.  I 
> wouldn't have fixed it if it had worked.

Ah, so it is a not-so-common breakage.

Thanks for clarifying,
Dscho
