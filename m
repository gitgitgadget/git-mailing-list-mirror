From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git push writes to stderr instead of stdout on success
Date: Mon, 19 May 2014 11:49:09 -0400
Message-ID: <20140519154909.GD20289@sigill.intra.peff.net>
References: <20140519150358.GA3099@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon May 19 17:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPoW-0001Rg-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbaESPtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:49:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:55072 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753303AbaESPtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 11:49:11 -0400
Received: (qmail 24691 invoked by uid 102); 19 May 2014 15:49:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 10:49:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 11:49:09 -0400
Content-Disposition: inline
In-Reply-To: <20140519150358.GA3099@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249591>

On Mon, May 19, 2014 at 07:03:58PM +0400, Marat Radchenko wrote:

> `git push` writes to stderr instead of stdout

That's by design.

Which one is correct is largely a matter of philosophy / mental model.
This case has been discussed before:

  http://thread.gmane.org/gmane.comp.version-control.git/180673

Keep in mind also that "git push --porcelain" does go to stdout and is
machine-parsed, so no other messages can go to stdout when that option
is enabled.

-Peff
