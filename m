From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Add core.symlinks to mark filesystems that do not support symbolic links.
Date: Fri, 2 Mar 2007 23:05:13 +0100
Message-ID: <200703022305.14058.johannes.sixt@telecom.at>
References: <200703022211.30322.johannes.sixt@telecom.at> <Pine.LNX.4.63.0703022219360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 23:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNFse-0002pY-RZ
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbXCBWFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbXCBWFT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:05:19 -0500
Received: from smtp4.noc.eunet-ag.at ([193.154.160.226]:34595 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1030506AbXCBWFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:05:18 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id BE8119787E;
	Fri,  2 Mar 2007 23:05:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 479B03AA6C;
	Fri,  2 Mar 2007 23:05:14 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0703022219360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41251>

On Friday 02 March 2007 22:35, Johannes Schindelin wrote:
> On Fri, 2 Mar 2007, Johannes Sixt wrote:
> > diff --git a/cache.h b/cache.h
> > index 04f8e63..6f932fe 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -108,7 +108,10 @@ static inline unsigned int create_ce_mode(unsigned
> > int mode) }
> >  static inline unsigned int ce_mode_from_stat(struct cache_entry *ce,
> > unsigned int mode) {
> > -	extern int trust_executable_bit;
> > +	extern int trust_executable_bit, has_symlinks;
>
> Would it not be better to move the global variables before this function?

I'd move the whole function out-of-line, I just wouldn't know whereto...

-- Hannes
