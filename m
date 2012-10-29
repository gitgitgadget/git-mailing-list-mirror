From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Mon, 29 Oct 2012 18:02:08 -0400
Message-ID: <20121029220208.GH20513@sigill.intra.peff.net>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
 <20121025095202.GK8390@sigill.intra.peff.net>
 <20121026094602.GA7887@dcvr.yhbt.net>
 <20121026133250.GI1455@sigill.intra.peff.net>
 <20121029201847.GA22021@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gunnlaugur =?utf-8?B?w57Ds3I=?= Briem <gunnlaugur@gmail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxPf-0000K8-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab2J2WCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:02:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933345Ab2J2WCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:02:11 -0400
Received: (qmail 24208 invoked by uid 107); 29 Oct 2012 22:02:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 18:02:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 18:02:08 -0400
Content-Disposition: inline
In-Reply-To: <20121029201847.GA22021@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208646>

On Mon, Oct 29, 2012 at 08:18:47PM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > On Fri, Oct 26, 2012 at 09:46:02AM +0000, Eric Wong wrote:
> > > Overly large values also lead to excessive memory usage.  I may have
> > > only had 256M in my dev machine at the time I added this parameter:
> > 
> > That's probably worth mentioning. Gunnlaugur, any objection to me
> > amending your commit with:
> 
> Thanks both, I've amended and S-o-b on my end.  Shall I add:
> Signed-off-by: Jeff King <peff@peff.net>

Since it was such a small topic, I just went ahead and queued bc22b27 in
my repo. If that's not OK, I can revert it from 'next' and wait to get
it by pulling from you.

-Peff
