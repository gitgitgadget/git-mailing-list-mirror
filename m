From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Mon, 8 Feb 2016 23:07:26 +0000
Message-ID: <20160208230726.GB3487@dcvr.yhbt.net>
References: <20160208222155.GA17395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuu3-0005sm-T8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbcBHXH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 18:07:27 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46327 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbcBHXH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 18:07:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634931FA1B;
	Mon,  8 Feb 2016 23:07:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160208222155.GA17395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285823>

Jeff King <peff@peff.net> wrote:
> Repost of <20160114202608.GA8806@sigill.intra.peff.net> from a few weeks
> ago (sorry, gmane is down so I can't generate a link).

I prefer we use links derived from Message-IDs anyways.  This
prevents reliance on gmane article numbers being a central point
of failure:

http://marc.info/?i=$MESSAGE_ID
http://mid.gmane.org/$MESSAGE_ID
http://mid.mail-archive.com/$MESSAGE_ID

But the MESSAGE_ID above seems missing from mail-archive.com, in this case.

Maybe there's more lookup-by-Message-ID services out there...
