From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] configure: fix some output message
Date: Thu, 25 Oct 2012 05:11:45 -0400
Message-ID: <20121025091145.GF8390@sigill.intra.peff.net>
References: <b67d9e47dc92c2c316495ac4bd8e7ba93d339781.1351091006.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:12:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJTt-00011z-Py
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934877Ab2JYJLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:11:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55987 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934834Ab2JYJLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:11:48 -0400
Received: (qmail 6655 invoked by uid 107); 25 Oct 2012 09:12:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:12:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:11:45 -0400
Content-Disposition: inline
In-Reply-To: <b67d9e47dc92c2c316495ac4bd8e7ba93d339781.1351091006.git.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208371>

On Wed, Oct 24, 2012 at 05:34:27PM +0200, Stefano Lattarini wrote:

> Before this change, output from ./configure could contain
> botched wording like this:
> 
>     checking Checking for POSIX Threads with '-pthread'... yes
> 
> instead of the intended:
> 
>     checking for POSIX Threads with '-pthread'... yes
> 
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>

Thanks, looks obviously correct.

-Peff
