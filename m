From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/apply.c: fuzzy_matchlines:trying to fix some
 inefficiencies
Date: Fri, 21 Mar 2014 02:32:15 -0400
Message-ID: <20140321063215.GA744@sigill.intra.peff.net>
References: <1395308103-16018-1-git-send-email-g3orge.app@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQt0A-0007lI-90
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 07:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbaCUGcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 02:32:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:43824 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752498AbaCUGcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 02:32:17 -0400
Received: (qmail 18721 invoked by uid 102); 21 Mar 2014 06:32:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 01:32:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 02:32:15 -0400
Content-Disposition: inline
In-Reply-To: <1395308103-16018-1-git-send-email-g3orge.app@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244644>

On Thu, Mar 20, 2014 at 11:35:03AM +0200, George Papanikolaou wrote:

> Hi again guys,
> I forgot to add the signed-of line to the tiny patch I sent earlier for GSOC.
> Any ideas about the changes?
> Thanks...

You don't give any detail on the inefficiencies, or what specific
benchmark is made faster. Have you done any timings to show that there
is a measurable improvement? If so, can you share them in the commit
message?

-Peff
