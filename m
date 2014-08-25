From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] fix pack-refs pruning of refs/foo
Date: Mon, 25 Aug 2014 14:56:20 -0400
Message-ID: <20140825185620.GB30953@peff.net>
References: <20140823052334.GA17813@peff.net>
 <CAL=YDWkFpjnsr+eqcOdrYQAPaPMfCdg17+yKvN=CwELbsOi-VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLzRK-0006mP-BU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbaHYS4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:56:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:58588 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932256AbaHYS4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:56:22 -0400
Received: (qmail 29294 invoked by uid 102); 25 Aug 2014 18:56:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 13:56:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 14:56:20 -0400
Content-Disposition: inline
In-Reply-To: <CAL=YDWkFpjnsr+eqcOdrYQAPaPMfCdg17+yKvN=CwELbsOi-VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255852>

On Mon, Aug 25, 2014 at 10:38:56AM -0700, Ronnie Sahlberg wrote:

> >   [1/5]: git-prompt: do not look for refs/stash in $GIT_DIR
> >   [2/5]: pack-refs: prune top-level refs like "refs/foo"
> >   [3/5]: fast-import: clean up pack_data pointer in end_packfile
> >   [4/5]: fast-import: fix buffer overflow in dump_tags
> >   [5/5]: fast-import: stop using lock_ref_sha1
> >
> 
> +1 on 1-3
> +1 on 4. While I have a similar fix in the transaction series, you
> should not need to wait for that series to address a security concern.
> 5: I think this one is not as urgent as the others so would prefer if
> it is dropped, just so it doesn't cause more merge conflicts than is
> already present in the transaction series.

OK, I think we're in agreement then. Thanks for looking them over.

-Peff
