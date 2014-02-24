From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore.h: be explicit about the signedness of is_binary
Date: Sun, 23 Feb 2014 21:09:40 -0500
Message-ID: <20140224020940.GB7959@sigill.intra.peff.net>
References: <m2ob1xba94.fsf@richlowe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Lowe <richlowe@richlowe.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 03:10:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHl0S-0002lT-2m
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 03:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbaBXCKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 21:10:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:55732 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751893AbaBXCJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 21:09:43 -0500
Received: (qmail 31298 invoked by uid 102); 24 Feb 2014 02:09:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 23 Feb 2014 20:09:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Feb 2014 21:09:40 -0500
Content-Disposition: inline
In-Reply-To: <m2ob1xba94.fsf@richlowe.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242554>

On Sun, Feb 23, 2014 at 07:54:47PM -0500, Richard Lowe wrote:

> Bitfields need to specify their signedness explicitly or the compiler is
> free to default as it sees fit.  With compilers that default 'unsigned'
> (SUNWspro 12 seems to do this) the tri-state nature of is_binary
> vanishes and all files are treated as binary.
> 
> Signed-off-by: Richard Lowe <richlowe@richlowe.net>

Thanks, I wasn't aware of this corner of the standard when I wrote it.
Your fix is obviously correct.

-Peff
