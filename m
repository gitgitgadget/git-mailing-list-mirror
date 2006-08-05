From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 22:27:59 +0200
Message-ID: <20060805202759.GA16186@moooo.ath.cx>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <20060805194513.GA4836@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 22:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Skh-00039V-OL
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 22:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWHEU2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHEU2D
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 16:28:03 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4994 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751488AbWHEU2B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 16:28:01 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060805194513.GA4836@sigio.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24932>

Jeff King <peff@peff.net> wrote:
> > Is there any way to do isatty() from shell scripts?
> 
> As Junio said, test -t. :) Is there interest in me adding that feature?
I would suggest that all scripts that use colors have a
always/auto/never (with boolean fallback) option and also honor
pager.color if the pager is in use.
