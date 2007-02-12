From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 13:59:43 +0200
Message-ID: <20070212115943.GA15526@mellanox.co.il>
References: <Pine.LNX.4.63.0702121250270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZqF-0000Gs-TY
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbXBLL73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbXBLL73
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:59:29 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33500 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964889AbXBLL72 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:59:28 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l1CBx7N0006541;
	Mon, 12 Feb 2007 13:59:08 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 12 Feb 2007 13:59:43 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702121250270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39397>

> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Subject: add negative -p to git-am, Re: Merge git-gui into 1.5.0 ?
> 
> Hi,
> 
> On Mon, 12 Feb 2007, Michael S. Tsirkin wrote:
> 
> > Make git-am support "negative strip-level" patches by running it in a 
> > subdirectory.
> 
> I'd rather hide this behind a command line switch to git-am, since it _is_ 
> a feature that you do not have to cd to the repo root when git-am'ing 
> correct patches.

Maybe it *could* be a nice feature, but it does *not* currently work,
so this patch is not breaking anything:

$git-am mbox
fatal: Not a git repository: '.git'
You need to run this command from the toplevel of the working tree.

And I think git-am is really similiar to git-apply functionally, so
it should work in a similiar manner.

-- 
MST
