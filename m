From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git config --get-colorbool
Date: Thu, 6 Dec 2007 01:17:11 -0500
Message-ID: <20071206061711.GD23309@coredump.intra.peff.net>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <20071206053059.GF5499@coredump.intra.peff.net> <7vve7cgxmw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0A3C-0004em-Hx
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbXLFGRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXLFGRO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:17:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbXLFGRO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:17:14 -0500
Received: (qmail 28285 invoked by uid 111); 6 Dec 2007 06:17:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 01:17:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 01:17:11 -0500
Content-Disposition: inline
In-Reply-To: <7vve7cgxmw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67252>

On Wed, Dec 05, 2007 at 10:12:07PM -0800, Junio C Hamano wrote:

> I thought about this a bit and thought that it would probably be a good
> workaround to teach "--get-colorbool that diff.color is a deprecated
> synonym to color.diff, like this.

Reasonable. Technically, one is required for status.color/color.status,
as well, though there are no users in git-core.

-Peff
