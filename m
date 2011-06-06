From: Jeff King <peff@peff.net>
Subject: Re: GIT_TRACE_PACKET is not documented
Date: Mon, 6 Jun 2011 12:13:04 -0400
Message-ID: <20110606161304.GD11485@sigill.intra.peff.net>
References: <201106041617.27944.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcQY-0008Rm-1G
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab1FFQNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:13:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50269
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497Ab1FFQNM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:13:12 -0400
Received: (qmail 7149 invoked by uid 107); 6 Jun 2011 16:13:18 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 12:13:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 12:13:04 -0400
Content-Disposition: inline
In-Reply-To: <201106041617.27944.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175133>

On Sat, Jun 04, 2011 at 04:17:27PM +0200, Jakub Narebski wrote:

> While GIT_TRACE is documented on git manpage, and mentioned in RelNotes,
> GIT_MERGE_VERBOSITY is documented on git manpage and mentioned on 
> git-merge manpage and other...  GIT_TRACE_PACKET isn't documented 
> _anywhere_:
> 
>   $ git grep GIT_TRACE_PACKET
>   pkt-line.c:static const char trace_key[] = "GIT_TRACE_PACKET";

Yeah, it's still on my todo list to revisit that topic. There were a few
cleanups and improvements that people mentioned in the original thread,
and I'll try to document it then.

-Peff
