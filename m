From: Jeff King <peff@peff.net>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 14:55:19 -0400
Message-ID: <20100418185519.GA14331@coredump.intra.peff.net>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu>
 <F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
 <20100418183759.GA11366@coredump.intra.peff.net>
 <r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Michalske <smichalske@gmail.com>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:56:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Zf4-0003cx-OC
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab0DRSzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:55:55 -0400
Received: from peff.net ([208.65.91.99]:35021 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab0DRSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:55:54 -0400
Received: (qmail 5740 invoked by uid 107); 18 Apr 2010 18:55:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Apr 2010 14:55:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Apr 2010 14:55:19 -0400
Content-Disposition: inline
In-Reply-To: <r2wfabb9a1e1004181143o7ebe2cf1t883ee4a12ba29a24@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145237>

On Sun, Apr 18, 2010 at 08:43:11PM +0200, Sverre Rabbelier wrote:

> On Sun, Apr 18, 2010 at 20:37, Jeff King <peff@peff.net> wrote:
> > So I expect that will serve Eli's purpose.
> 
> If it does not, would a pre-commit hook work? If he sets some
> recognizable string (such as not setting it) as email and install a
> hook that barfs if it sees that?

Yeah, that could work. It would do what he wants, but he would have to
have the hook set up. Which means he either needs to remember to
configure it in each repository (at which point he could just remember
to configure his identity), or he needs to point to a special init
template directory with the hook.

I think setting init.templatedir or GIT_TEMPLATE_DIR in the environment
would accomplish the latter.

-Peff
