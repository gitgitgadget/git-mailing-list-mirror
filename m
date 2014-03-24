From: Jeff King <peff@peff.net>
Subject: Re: git log omits deleting merges
Date: Mon, 24 Mar 2014 10:19:34 -0400
Message-ID: <20140324141934.GA651@sigill.intra.peff.net>
References: <5305B045.2060503@gmail.com>
 <20140320195404.GA19252@sigill.intra.peff.net>
 <5330081C.3090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:19:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS5j3-0003Ac-NY
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 15:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbaCXOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 10:19:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:45736 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750984AbaCXOTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 10:19:36 -0400
Received: (qmail 16697 invoked by uid 102); 24 Mar 2014 14:19:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 09:19:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 10:19:34 -0400
Content-Disposition: inline
In-Reply-To: <5330081C.3090403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244821>

On Mon, Mar 24, 2014 at 11:25:32AM +0100, Ephrim Khong wrote:

> Thank you for the explanation, I now understand why this is happening from a
> technical point of view. From a usability perspective, it is a bit confusing
> that a flag that should intuitively increase the number of shown commits
> (--follow) removes a commit from the output. Though this is just a minor
> annoyance, so no strong opinion here.

Sorry, I focused on the --diff-filter aspect of your question. As for
--follow, I think that is less "by design" and more "what happens to
occur, because --follow is a bit of a hack".

So there may be a bug, or room for improvement in the code there, though
if the solution involves turning on diffs for all merges, that may be
prohibitively expensive.

-Peff
