From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/22] pack bitmaps
Date: Sat, 21 Dec 2013 09:03:47 -0500
Message-ID: <20131221140346.GA21359@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:04:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN9k-0008Mf-De
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3LUODs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:03:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:48517 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753998Ab3LUODs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:03:48 -0500
Received: (qmail 8040 invoked by uid 102); 21 Dec 2013 14:03:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:03:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:03:47 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239617>

On Sat, Dec 21, 2013 at 08:56:51AM -0500, Jeff King wrote:

> Interdiff is below.
> 
>   [01/23]: sha1write: make buffer const-correct
>   [02/23]: revindex: Export new APIs
>   [03/23]: pack-objects: Refactor the packing list
>   [04/23]: pack-objects: factor out name_hash
>   [05/23]: revision: allow setting custom limiter function
>   [06/23]: sha1_file: export `git_open_noatime`
>   [07/23]: compat: add endianness helpers
>   [08/23]: ewah: compressed bitmap implementation
>   [09/23]: documentation: add documentation for the bitmap format

By the way, the patches are identical up through 09/23. I think the
first one is already merged into another topic, too, so it may be worth
building on that instead of re-applying.

-Peff
