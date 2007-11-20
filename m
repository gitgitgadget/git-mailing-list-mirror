From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] send-pack: print "maybe you need to pull" hint
Date: Tue, 20 Nov 2007 19:24:39 +0100
Message-ID: <20071120182439.GB3461@steel.home>
References: <20071120111317.GA4120@sigill.intra.peff.net> <20071120112146.GB7814@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:25:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXmP-0000lV-2o
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223AbXKTSYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbXKTSYn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:24:43 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:57982 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173AbXKTSYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:24:42 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ8+A==
Received: from tigra.home (Fad1d.f.strato-dslnet.de [195.4.173.29])
	by post.webmailer.de (mrclete mo28) (RZmta 14.3)
	with ESMTP id 304d1cjAKHj4fK ; Tue, 20 Nov 2007 19:24:40 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 41E6A277AE;
	Tue, 20 Nov 2007 19:24:40 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id ECAFE56D22; Tue, 20 Nov 2007 19:24:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071120112146.GB7814@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65558>

Jeff King, Tue, Nov 20, 2007 12:21:46 +0100:
> If there were refs rejected for not being fastforwards, then
> we used to print a "maybe you are not up-to-date" hint. This
> was lost in the recent terse-output patches.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I am slightly negative on this patch, just because I always found that
> particular warning a bit ugly (and the new output is so nice and
> compact). But for new users, perhaps the extra hint is helpful?

Dunno. It's kind of dumb hint and it takes lots of space. I was even
thinking about hint(const char *,...), which can be configured to
compile out in Makefile.
