From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 21/40] Windows: Disambiguate DOS style paths from SSH URLs.
Date: Thu, 28 Feb 2008 21:51:29 +0100
Message-ID: <200802282151.29272.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-22-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281522190.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 21:52:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpjb-0002yE-Uf
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759802AbYB1Uvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757111AbYB1Uvb
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:51:31 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:50501 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbYB1Uva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:51:30 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id CDE7033BDF;
	Thu, 28 Feb 2008 21:51:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9B9875B9E3;
	Thu, 28 Feb 2008 21:51:29 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281522190.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75453>

On Thursday 28 February 2008 16:22, Johannes Schindelin wrote:
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > +#ifdef __MINGW32__
> > +	/* host must have at least 2 chars to catch DOS C:/path */
> > +	if (path && path - end > 1)
> > +#else
> > +	if (path)
> > +#endif
> > +	{
>
> This could be un-#ifdef'ed by using the has_dos_drive_prefix() function I
> suggested earlier.

Ah, great! I'm convinced.

-- Hannes
