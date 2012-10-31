From: Jeff King <peff@peff.net>
Subject: Re: [OT] How to get the discussion details via notes
Date: Wed, 31 Oct 2012 10:10:24 -0400
Message-ID: <20121031141024.GB24291@sigill.intra.peff.net>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
 <20121031060529.GA30432@elie.Belkin>
 <20121031095327.GB18557@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:10:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTZ0E-0000RI-SO
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847Ab2JaOK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 10:10:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45136 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422799Ab2JaOK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 10:10:28 -0400
Received: (qmail 14608 invoked by uid 107); 31 Oct 2012 14:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 10:11:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 10:10:24 -0400
Content-Disposition: inline
In-Reply-To: <20121031095327.GB18557@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208821>

On Wed, Oct 31, 2012 at 10:53:27AM +0100, Peter Baumann wrote:

> > covers the basics (current behavior and intent of the change) in its
> > first two paragraphs and anyone wanting more detail can use
> > 
> > 	GIT_NOTES_REF=refs/remotes/charon/notes/full \
> > 	git show --show-notes <commit>
> > 
> > to find more details.
> 
> I seem to miss something here, but I don't get it how the notes ref
> becomes magically filled with the details of this discussion.

Thomas Rast (aka charon) keeps a mapping of commits to the email threads
that led to them. You can fetch it from:

   git://repo.or.cz/git/trast.git

(try the notes/full and notes/terse refs).

-Peff
