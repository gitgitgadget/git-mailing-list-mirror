From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Tue, 27 Feb 2007 15:11:00 -0800
Message-ID: <20070227231100.GA25782@localdomain>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de> <alpine.LRH.0.82.0702271036010.29426@xanadu.home> <Pine.LNX.4.63.0702271656540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Simon Josefsson <simon@josefsson.org>, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBTU-0008IW-Td
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbXB0XLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbXB0XLF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:11:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33966 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbXB0XLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:11:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5F3167DC091;
	Tue, 27 Feb 2007 15:11:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Feb 2007 15:11:00 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702271656540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40838>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 27 Feb 2007, Nicolas Pitre wrote:
> 
> > On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> > 
> > > 
> > > This outputs the log in GNU ChangeLog format.
> > 
> > Please don't call it "changelog".  I personally find this format horrid 
> > and "changelog" is too generic for such a specific format.  
> > "gnu_changelog" maybe...
> 
> Fair enough. Maybe with a dash, so it is easier to type?

> --- a/commit.c
> +++ b/commit.c
> @@ -38,6 +38,7 @@ struct cmt_fmt_map {
>  	{ "fuller",	5,	CMIT_FMT_FULLER },
>  	{ "oneline",	1,	CMIT_FMT_ONELINE },
>  	{ "format:",	7,	CMIT_FMT_USERFORMAT},
> +	{ "changelog",	9,	CMIT_FMT_CHANGELOG}
                        ^- that should be a 1

'gnu[_-]changelog' or 'changelog' would all uniquely abbreviate to a
single character.

--pretty=gnu sounds nice, however :)

-- 
Eric Wong
