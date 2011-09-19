From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 16:44:48 -0400
Message-ID: <20110919204448.GA3562@sigill.intra.peff.net>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
 <20110919182049.GA26115@sigill.intra.peff.net>
 <7v62ko9scw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:45:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ki2-0004kU-1Z
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab1ISUow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:44:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37653
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756543Ab1ISUou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:44:50 -0400
Received: (qmail 9736 invoked by uid 107); 19 Sep 2011 20:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 16:49:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 16:44:48 -0400
Content-Disposition: inline
In-Reply-To: <7v62ko9scw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181706>

On Mon, Sep 19, 2011 at 01:42:23PM -0700, Junio C Hamano wrote:

> >> Yeah, I agree, and the dq around $browser_cmd is kind of important, too,
> >> for that to work and be readable.
> >
> > Oops, good catch. Probably the most readable version would be:
> >
> >   eval "\"$browser_cmd\"" '"$@"'
> 
> Actually I didn't mean that double dq.
> 
> In fact, if browser_cmd is meant to be split as a shell snippet, I do not
> think you want the string seen by eval to have dq around the expanded
> version of $browser_cmd.  And I tend to prefer feeding a single string to
> eval, so the version in your message I quoted originally looks good to me.
> 
> Unless I am missing something here...?

Oh right. Sorry, I read your comment, thought that's what you meant, and
that I had overlooked something. Forgetting that it was intentional to
leave off the quotes inside.

So yeah, my original is right. I just got turned around in all of the
discussion.

Sorry for the noise.

-Peff
