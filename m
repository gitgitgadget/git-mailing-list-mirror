From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 01:09:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703190107410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1174223784.5987.6.camel@localhost> <200703181606.20678.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703190051.46954.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-107539902-1174262998=:22628"
Cc: Raimund Bauer <ray007@gmx.net>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT5SC-0001L4-Uv
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 01:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbXCSAKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 20:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbXCSAKA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 20:10:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:46097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933510AbXCSAKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 20:10:00 -0400
Received: (qmail invoked by alias); 19 Mar 2007 00:09:58 -0000
X-Provags-ID: V01U2FsdGVkX19GtBl3LctGeOUTvqzs+XnFQXV7JCBCGmzhQ6Lz4U
	ybsV77VPcUv89F
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703190051.46954.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42546>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-107539902-1174262998=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 19 Mar 2007, Robin Rosenberg wrote:

> måndag 19 mars 2007 00:09 skrev Johannes Schindelin:
> 
> > At any rate, have you tried something like "GIT_PAGER='kompare -' git 
> > diff HEAD^..HEAD"?
>
> Doesn't work here. Shows empty diff...
> 
> but AH, that's because of the colored-diff settings. I you have 
> color.diff or color.status set to true neither version will work.

I wonder why we still have "color.diff=true", which is wrong in almost 
_all_ cases (instead it should be auto).

> With auto the first one will, but not the second.

That is to be expected... Git actually expects the pager to be just that, 
a pager. So you have to say

$ GIT_PAGER='kompare -' git diff --no-color HEAD^..HEAD

Hth,
Dscho

---1148973799-107539902-1174262998=:22628--
