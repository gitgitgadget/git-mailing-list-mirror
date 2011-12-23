From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 23 Dec 2011 00:47:03 -0500
Message-ID: <20111223054703.GA17540@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <A8E08CC616E248EC8F9000DD86F228E0@PhilipOakley>
 <20111216193253.GD19924@sigill.intra.peff.net>
 <22866D05066E43DEA0A0EBDF9B7686ED@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 23 06:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdxyN-0007AB-Ko
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 06:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab1LWFrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 00:47:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51565
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab1LWFrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 00:47:08 -0500
Received: (qmail 30604 invoked by uid 107); 23 Dec 2011 05:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 00:53:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 00:47:03 -0500
Content-Disposition: inline
In-Reply-To: <22866D05066E43DEA0A0EBDF9B7686ED@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187620>

On Thu, Dec 22, 2011 at 12:05:39AM -0000, Philip Oakley wrote:

> The "*.m=matlab" does give better (proper) hunk headers as it picks
> out the "^%%" comment line which starts a code block . For option 3
> (ObjC) they are empty (which is poor). The plain vanila (default)
> hunk headers are so-so.

Thanks for all of the detail. I think it comes down to the part I
quoted, though: it is indeed a disservice to matlab people to map "*.m"
to objc. So let's be conservative and not do that (projects can always
add their own gitattributes).

(Even before seeing your answer, I dropped it from the re-roll of my
patch that I sent, but this confirms to me that it was the right thing
to do).

-Peff
