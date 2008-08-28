From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Thu, 28 Aug 2008 17:36:43 -0400
Message-ID: <20080828213643.GC27867@coredump.intra.peff.net>
References: <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org> <48B52037.7030405@fastmail.fm> <7vr68aqt3h.fsf@gitster.siamese.dyndns.org> <48B65922.4050005@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpBf-0006CA-Ev
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbYH1Vgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYH1Vgq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:36:46 -0400
Received: from peff.net ([208.65.91.99]:3978 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbYH1Vgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:36:45 -0400
Received: (qmail 7954 invoked by uid 111); 28 Aug 2008 21:36:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 17:36:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 17:36:43 -0400
Content-Disposition: inline
In-Reply-To: <48B65922.4050005@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94183>

On Thu, Aug 28, 2008 at 09:52:02AM +0200, Michael J Gruber wrote:

> Junio C Hamano venit, vidit, dixit 27.08.2008 19:13:
> > Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:
> > 
> >> People who don't use this feature don't have any entries and don't pay
> >> anything.  People who use this feature and have a moderate number of
> >> entries don't pay a recognizable price.  People who use this feature and
> >> have a vast amount of entries should be told to implement an alias file
> >> parser ;)
> > 
> > That attitude is Ok for an experimental piece of software.  Perhaps it was
> > Ok for git 18 months ago as well, but not anymore.
> 
> I probably should have put the ;) in emphasis. This is not my attitude.

Hmm. It sounds like we your interest is moving towards Junio's approach,
so maybe this doesn't matter. But I actually think your statement above
made some sense. I think we will be providing multiple sources of alias
information in the long run anyway, so this becomes just another source.
As a source, it has some advantages (it is simple to setup in your
existing git config, and does not require an extra file), and some
disadvantages (it does not scale as well as some other solutions).

> P.S.: This is "reply all" to a mail sent off-list probably meant for the
> list, but I didn't want to cc: the list without your consent (since I'm
> quoting you). I'm sorry for this confusion. I'm sure it's not your MUAs
> and confident it's not mine, which leaves gmane..

I am putting it back on-list. :)

-Peff
