From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2012, #02; Fri, 4)
Date: Thu, 10 May 2012 11:13:29 -0400
Message-ID: <20120510151328.GA20639@sigill.intra.peff.net>
References: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
 <20120510131255.GA2950@sigill.intra.peff.net>
 <7vd36cozsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:13:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSV3t-0003uK-OL
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759995Ab2EJPNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:13:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757749Ab2EJPNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:13:31 -0400
Received: (qmail 29386 invoked by uid 107); 10 May 2012 15:13:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 11:13:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 11:13:29 -0400
Content-Disposition: inline
In-Reply-To: <7vd36cozsi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197578>

On Thu, May 10, 2012 at 07:50:53AM -0700, Junio C Hamano wrote:

> >> "git push" over smart-http lost progress output and this resurrects it.
> >> 
> >> Will merge to 'master'.
> >
> > I noticed that this graduated to master, but not to maint. Any reason?
> 
> Nobody goes direct to 'maint' if it is complex enough to go through
> next/pu cycle these days.
> 
>   $ git log -p Documentation/RelNotes/1.7.11.txt
> 
> will show, for example, jk/maint-config-bogus-section was merged as part
> of the eighth batch (May 2) to 'master', but merged to 'maint' only after
> we had it in 'master' for a bit without hearing any breakage caused by it.

Ah, OK. I thought the progression you used was topic->pu->next->maint.
Did that used to be the case, or am I just crazy? I also don't remember
seeing incremental updates to the release notes in this way. But then I
don't pay too much attention to them during the actual cycle.

Not a criticism (in fact, it makes a lot more sense to me). Just natural
curiosity.

> Just like all the other features listed below the "Fixes since v1.7.10"
> fold, the 'push progress' went into 'master' very recently with a note to
> merge it later to 'maint', and we haven't seen 'later' yet.

Right. I saw only that it was dropped from "What's cooking" and didn't
realize you were keeping state in the release notes.

Thanks for the explanation.

-Peff
