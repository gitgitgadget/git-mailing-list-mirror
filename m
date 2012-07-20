From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 10:26:43 -0400
Message-ID: <20120720142630.GA31791@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <7515FF5F-2B4F-4CD0-B4A3-D2B1328AE313@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 16:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsEAO-00085g-An
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 16:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab2GTO0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 10:26:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab2GTO0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 10:26:46 -0400
Received: (qmail 10389 invoked by uid 107); 20 Jul 2012 14:26:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 10:26:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 10:26:43 -0400
Content-Disposition: inline
In-Reply-To: <7515FF5F-2B4F-4CD0-B4A3-D2B1328AE313@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201768>

On Fri, Jul 20, 2012 at 12:23:12AM +0200, Alexey Muranov wrote:

> i have no idea about Git source and little idea of how it is working
> internally, but reading through your message i wonder: wouldn't it be
> a good idea to timestamp the dead reflogs ?

Each individual entry in the reflog has its own timestamp, and the
entries are expired individually over time as "git gc" is run. Or did
you mean something else?

-Peff
