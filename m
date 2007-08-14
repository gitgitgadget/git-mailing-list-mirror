From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 15:08:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708141506260.25989@racer.site>
References: <11870975181798-git-send-email-bdowning@lavos.net>
 <20070814132209.GJ21692@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 16:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKx6B-0000P0-AN
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 16:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbXHNOJ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbXHNOJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 10:09:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:59041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754524AbXHNOJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 10:09:54 -0400
Received: (qmail invoked by alias); 14 Aug 2007 14:09:52 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 14 Aug 2007 16:09:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QwTwJT0fQoRpmgzLJzzXNdC1nfhSc6uTrq4Nh9l
	n1yfDh9aCR7zAz
X-X-Sender: gene099@racer.site
In-Reply-To: <20070814132209.GJ21692@lavos.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55833>

Hi,

On Tue, 14 Aug 2007, Brian Downing wrote:

> On Tue, Aug 14, 2007 at 08:18:38AM -0500, Brian Downing wrote:
> > We can now read .gitattributes files out of the index, but the index
> > must be loaded for this to work.
> 
> This was supposed to be In-Reply-To Junio's patch, "attr.c: read
> .gitattributes from index as well."  It's not much use without it.

Shouldn't read_cache() be _only_ called if

- it has not been read yet, and
- .gitattributes was not found in the work tree?

IOW check-attr is the wrong place for your patch IMHO.

Ciao,
Dscho
