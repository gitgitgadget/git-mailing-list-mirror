From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 03:05:53 -0500
Message-ID: <20091130080553.GA8155@coredump.intra.peff.net>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com>
 <20091130075927.GA5767@coredump.intra.peff.net>
 <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1Gf-0003UE-AM
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZK3IFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbZK3IFq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:05:46 -0500
Received: from peff.net ([208.65.91.99]:35213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbZK3IFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:05:45 -0500
Received: (qmail 10576 invoked by uid 107); 30 Nov 2009 08:10:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 03:10:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 03:05:53 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134077>

On Mon, Nov 30, 2009 at 09:04:25AM +0100, Sverre Rabbelier wrote:

> On Mon, Nov 30, 2009 at 08:59, Jeff King <peff@peff.net> wrote:
> > I mean, I would think that the "git_remote_helpers" directory contained
> > remote helpers of all sorts, not just the python ones.
> 
> I don't think that's true, git.git currently does not have such a
> structure (everything is just dumped in the root directory). The only
> reason git_remote_helpers exists is to make it easier to create a
> python egg out of it and install that. At least, that's what I think
> is going on, Johan and Daniel might have comments to the contrary.

OK. It is just my confusion, then. Don't worry about it.

-Peff
