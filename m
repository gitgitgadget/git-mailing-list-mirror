From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/22] pack bitmaps
Date: Sat, 21 Dec 2013 09:05:44 -0500
Message-ID: <20131221140544.GB21359@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:05:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuNBd-0001Mb-UL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab3LUOFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:05:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:48520 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUOFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:05:45 -0500
Received: (qmail 8144 invoked by uid 102); 21 Dec 2013 14:05:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:05:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:05:44 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239618>

On Sat, Dec 21, 2013 at 08:56:51AM -0500, Jeff King wrote:

> The changes from v3 are:
> 
>  - reworked add_object_entry refactoring (see patch 11, which is new,
>    and patch 12 which builds on it in a more natural way)
> 
>  - better error/die reporting from write_reused_pack
> 
>  - added Ramsay's PRIx64 compat fix
> 
>  - fixed a user-after-free in the warning message of open_pack_bitmap_1
> 
>  - minor typo/thinko fixes from Thomas in docs and tests

One thing explicitly _not_ here is ripping out khash in favor of
Karsten's hash system. That is still on the table, but I'd much rather
do it on top if we are going to.

-Peff
