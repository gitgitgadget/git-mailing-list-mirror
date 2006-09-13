From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach runstatus about --untracked
Date: Wed, 13 Sep 2006 09:21:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609130920430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609122243360.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060913061040.GA3590@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 13 09:21:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNP3X-0001G4-C5
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 09:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWIMHVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 03:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWIMHVH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 03:21:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:48020 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751659AbWIMHVE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 03:21:04 -0400
Received: (qmail invoked by alias); 13 Sep 2006 07:21:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 13 Sep 2006 09:21:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jeff King <peff@peff.net>
In-Reply-To: <20060913061040.GA3590@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26906>

Hi,

On Wed, 13 Sep 2006, Jeff King wrote:

> On Tue, Sep 12, 2006 at 10:45:12PM +0200, Johannes Schindelin wrote:
> 
> > +	if (!s->untracked)
> > +		dir.show_other_directories = 1;
> 
> This should also set dir.hide_empty_directories to match the original
> behavior.

But of course! Completely forgot that. Thanks.
