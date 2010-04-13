From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] pretty: Initialize notes if %N is used
Date: Tue, 13 Apr 2010 06:03:04 -0400
Message-ID: <20100413100304.GA29101@coredump.intra.peff.net>
References: <20100412085647.GA26840@coredump.intra.peff.net>
 <1271149186-30156-1-git-send-email-heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Tue Apr 13 12:03:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cy4-0006Th-J5
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 12:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab0DMKDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 06:03:36 -0400
Received: from peff.net ([208.65.91.99]:47370 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab0DMKDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 06:03:35 -0400
Received: (qmail 2688 invoked by uid 107); 13 Apr 2010 10:03:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 13 Apr 2010 06:03:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Apr 2010 06:03:04 -0400
Content-Disposition: inline
In-Reply-To: <1271149186-30156-1-git-send-email-heipei@hackvalue.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144804>

On Tue, Apr 13, 2010 at 10:59:46AM +0200, Johannes Gilger wrote:

> Thanks for the feedback Jeff. I've put your suggestions into my patch
> and tried to come up with a sensible name for 'userformat_fill_want'.
> As you can see I called it 'userformat_find_requirements', but am not
> really satisfied with it since it's too long and not quite to the
> point.
> 
> Anything else missing?

This version looks good to me.

Two minor comments:

> -	if (!rev->show_notes_given && !rev->pretty_given)
> +	userformat_find_requirements(NULL,&w);

 1. Style, no whitespace between arguments.

 2. That function name also sucks. I doubt it is worth spending more
    time on, though.

-Peff
