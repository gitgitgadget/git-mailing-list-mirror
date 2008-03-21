From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] "git push": tellme-more protocol extension
Date: Fri, 21 Mar 2008 00:28:21 -0400
Message-ID: <20080321042821.GA5453@coredump.intra.peff.net>
References: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org> <20080321023303.GE1613@coredump.intra.peff.net> <7vy78cu2kt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcYsl-0005jy-86
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYCUE2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbYCUE2Y
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:28:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbYCUE2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:28:24 -0400
Received: (qmail 23525 invoked by uid 111); 21 Mar 2008 04:28:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 21 Mar 2008 00:28:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2008 00:28:21 -0400
Content-Disposition: inline
In-Reply-To: <7vy78cu2kt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77706>

On Thu, Mar 20, 2008 at 09:24:18PM -0700, Junio C Hamano wrote:

> So a potential improvement might be to ask for "tellme-more" only if we do
> not know any of the refs the receiver showed us; my patch does it if there
> is at least one unknown instead.

You can still get cases where doing this is more expensive than your
patch, because A..B is very small but shared_tag..A is very large. I'm
not sure which is more likely in practice.

-Peff
