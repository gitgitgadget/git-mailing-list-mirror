From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Sat, 7 Apr 2007 17:32:33 -0400
Message-ID: <20070407213233.GA23234@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com> <20070405134954.GA18402@coredump.intra.peff.net> <17941.655.192938.792088@lisa.zopyra.com> <20070405204604.GA24779@coredump.intra.peff.net> <7vodm2o6yl.fsf@assigned-by-dhcp.cox.net> <20070406025255.GA31909@coredump.intra.peff.net> <7vbqi1jhzx.fsf@assigned-by-dhcp.cox.net> <20070407170702.GC18972@coredump.intra.peff.net> <7vy7l3c1uz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 23:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIWY-0002B3-86
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966353AbXDGVch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966356AbXDGVch
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:32:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966353AbXDGVcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:32:36 -0400
Received: (qmail 17115 invoked from network); 7 Apr 2007 21:33:11 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Apr 2007 21:33:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2007 17:32:33 -0400
Content-Disposition: inline
In-Reply-To: <7vy7l3c1uz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43983>

On Sat, Apr 07, 2007 at 02:26:44PM -0700, Junio C Hamano wrote:

> Yes, that is exactly why I suggested "git push" without explicit
> refspecs to drive the plumbings to push only matching branches.
> So if you are worried about breaking backward compatibility for
> real men (iow people who use git-send-pack directly), it would
> be a less impact change to (1) add --matching-heads option to
> send-pack and perhaps http-push, and change their behaviour only
> in that case, and (2) pass that option when git-push did not get
> explicit refspecs to send from the user, either from the command
> line nor from the config.

Ah, I (obviously) didn't pick that up from your original message. Let me
rework my patch and see if I can get something more reasonable.

-Peff
