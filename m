From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 17:40:36 -0400
Message-ID: <20130726214036.GB1388@sigill.intra.peff.net>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2plO-0002Kj-F5
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab3GZVlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:41:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:60899 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933810Ab3GZVkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 17:40:39 -0400
Received: (qmail 9970 invoked by uid 102); 26 Jul 2013 21:40:39 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 16:40:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 17:40:36 -0400
Content-Disposition: inline
In-Reply-To: <20130726213705.GJ14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231208>

On Fri, Jul 26, 2013 at 02:37:05PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Your patch is just swapping out "git reset" for "cherry-pick --abort",
> > so I think that is a good improvement in the meantime.
> 
> Um, wasn't the idea of the original message that you can run "git
> reset" and then "git cherry-pick --continue"?

Maybe. :)

I missed that subtlety. Of my "three things you would want to do", that
means it was _trying_ say number 2, how to skip, rather than 3, how to
abort. If that is the case, then it should probably explain the sequence
of steps as "reset and then --continue" to make it more clear.

I.e., a patch is needed, but Ram's is going in the opposite direction.

-Peff
