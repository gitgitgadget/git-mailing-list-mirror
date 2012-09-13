From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Thu, 13 Sep 2012 14:04:45 -0400
Message-ID: <20120913180445.GB1696@sigill.intra.peff.net>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org>
 <20120913132847.GD4287@sigill.intra.peff.net>
 <7v4nn1akz7.fsf@alter.siamese.dyndns.org>
 <7vr4q595fb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:05:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDmc-000545-0E
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758704Ab2IMSEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:04:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758653Ab2IMSEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:04:48 -0400
Received: (qmail 5567 invoked by uid 107); 13 Sep 2012 18:05:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Sep 2012 14:05:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Sep 2012 14:04:45 -0400
Content-Disposition: inline
In-Reply-To: <7vr4q595fb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205400>

On Thu, Sep 13, 2012 at 10:52:08AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>      But it should not be per-command, but per-message, and
> >>      should include all output that is not diagnostic and is not
> >>      machine-parseable (e.g., what I mentioned above, request-pull
> >>      output, etc). If it is the project's language, then the team
> >>      members will need to know it anyway, so it should not be too big a
> >>      burden to have a potentially different language there than in the
> >>      diagnostic messages.
> >
> > No matter what the project languages is, machine parseable part will
> > not be localized but fixed to "C" anyway, so I do not think it comes
> > into the picture.
> >
> > My take on this is, if there is the project language, it should
> > apply to _everything_.  Please do not introduce any per-command,
> > per-message, per-anything mess.  Just set LANG/LC_ALL up and be done
> > with it.
> >
> > And I think you justified why that is the right thing to do very
> > well in the second sentence in the above paragraph I quoted from
> > you.
> 
> You seem to be saying that diagnostic does not have to be in project
> language, but I do not think it is the right thing to do.  The first
> response to "Frotz does not work" is often "What do you exactly
> mean?  How did you run Frotz?  What error message are you getting
> from it?", and you do not want to get back the diagnostics in
> Klingon.

By that line of reasoning, wouldn't all git developers be required to
set LANG=C? Fine by me as an English speaker, but I get the impression
that other developers are using the localization. I don't think there is
anything wrong with primarily working in your native language, but
making the effort to switch for communicating with teammates (either
when writing them emails, or using LANG=C when showing them output from
your terminal).

If the "switch to LANG=C" thing is a relatively rare thing, I don't see
a problem. The issue with the diffstat is that it is too easy to
accidentally send out a localized one.

-Peff
