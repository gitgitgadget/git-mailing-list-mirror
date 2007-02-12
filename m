From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 13:06:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121304450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702121250270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070212115943.GA15526@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Feb 12 13:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZwo-0003TX-BN
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 13:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbXBLMGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 07:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbXBLMGI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 07:06:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:50945 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964888AbXBLMGG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 07:06:06 -0500
Received: (qmail invoked by alias); 12 Feb 2007 12:06:05 -0000
X-Provags-ID: V01U2FsdGVkX18MVhdGsIsMkpSNsd7ukCJEXCIGy5kuOST29VkjRu
	iu3g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070212115943.GA15526@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39399>

Hi,

On Mon, 12 Feb 2007, Michael S. Tsirkin wrote:

> > Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Subject: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
> > 
> > Hi,
> > 
> > On Mon, 12 Feb 2007, Michael S. Tsirkin wrote:
> > 
> > > Make git-am support "negative strip-level" patches by running it in a 
> > > subdirectory.
> > 
> > I'd rather hide this behind a command line switch to git-am, since it _is_ 
> > a feature that you do not have to cd to the repo root when git-am'ing 
> > correct patches.
> 
> Maybe it *could* be a nice feature, but it does *not* currently work,

yes, I read your email. My point was more to allow both use cases, and 
hide the more obscure one behind an option.

> And I think git-am is really similiar to git-apply functionally, so
> it should work in a similiar manner.

Except git-apply works without a repository, too.

Ciao,
Dscho
