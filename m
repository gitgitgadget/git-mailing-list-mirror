From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Tue, 21 Oct 2008 07:12:02 -0400
Message-ID: <20081021111201.GA17363@coredump.intra.peff.net>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <1224583999-26279-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Theodore Ts'o <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:13:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFAx-0000Cd-9g
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbYJULMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752259AbYJULMG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:12:06 -0400
Received: from peff.net ([208.65.91.99]:2313 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbYJULMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:12:05 -0400
Received: (qmail 19506 invoked by uid 111); 21 Oct 2008 11:12:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 07:12:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 07:12:02 -0400
Content-Disposition: inline
In-Reply-To: <1224583999-26279-3-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98773>

On Tue, Oct 21, 2008 at 11:13:19AM +0100, Charles Bailey wrote:

> This option stops git mergetool from aborting at the first failed merge.
> This allows some additional use patterns. Merge conflicts can now be
> previewed one at time and merges can also be skipped so that they can be
> performed in a later pass.

All 3 patches look good to me, and match what I expected from our
earlier discussion. But I am not too familiar with mergetool, so take my
approval with a grain of salt. :)

-Peff
