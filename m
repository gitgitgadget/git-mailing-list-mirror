From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] handle color.ui at a central place
Date: Sat, 24 Jan 2009 15:23:24 +0100
Message-ID: <200901241523.24845.markus.heidelberg@web.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <200901241228.33690.markus.heidelberg@web.de> <alpine.DEB.1.00.0901241513460.13232@racer>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 15:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQjRJ-0005oS-75
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 15:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729AbZAXOXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 09:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759389AbZAXOXH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 09:23:07 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:50757 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbZAXOXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 09:23:05 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9F792F6FE19F;
	Sat, 24 Jan 2009 15:23:01 +0100 (CET)
Received: from [89.59.96.236] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LQjPY-0005Mo-00; Sat, 24 Jan 2009 15:23:00 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901241513460.13232@racer>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18TNGnzlddK9oBvPXXSGczH1xaeNuiDy2qF4M6R
	78tqHBMPRGsxis0yyKp5nRku3OvlgMM7jNwa0RL9u4sZqAkpRV
	ZaWNV4MPY2pC9RwRAgdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106970>

Johannes Schindelin, 24.01.2009:
> Hi,
> 
> On Sat, 24 Jan 2009, Markus Heidelberg wrote:
> 
> > format-patch is perhaps the only place where the commit has broken 
> > things, because I didn't find other places, where color config options 
> > were set
(and evaluated)
> > , but not the corresponding variables. So it seems as if only 
> > format-patch needed code like this to turn off the colors.
> 
> So you want to add a test case when you resubmit your patch...

I'm not sure, whether it should be resubmitted at all. As Jeff pointed
out, there should be a better way to clean up the color (and color.ui)
handling.

Markus
