From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Add I18N-wrappers for low-level IO-routines
Date: Tue, 27 Oct 2009 17:08:17 -0400
Message-ID: <20091027210817.GA1577@sigill.intra.peff.net>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
 <1256651643-18382-2-git-send-email-timur@iris-comp.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Timur Sufiev <timur@iris-comp.ru>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:08:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2tHF-0000l1-MA
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 22:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbZJ0VIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 17:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbZJ0VIP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 17:08:15 -0400
Received: from peff.net ([208.65.91.99]:55393 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303AbZJ0VIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 17:08:14 -0400
Received: (qmail 4050 invoked by uid 107); 27 Oct 2009 21:11:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 17:11:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 17:08:17 -0400
Content-Disposition: inline
In-Reply-To: <1256651643-18382-2-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131380>

On Tue, Oct 27, 2009 at 04:54:01PM +0300, Timur Sufiev wrote:

> Signed-off-by: Timur Sufiev <timur@iris-comp.ru>

Hmm. Two questions about this series:

  1. Patch 3/4 didn't seem to make it to the list. Presumably that is
     where you actually use these routines in git? Or are they just for
     mingw?

  2. I seem to recall that Linus added a filename translation layer for
     doing much more, like handling unicode normalizations (but I
     confess I haven't looked closely at that code). Should this be part
     of that system?

-Peff
