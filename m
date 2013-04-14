From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Sun, 14 Apr 2013 15:00:50 -0400
Message-ID: <20130414190050.GA4599@sigill.intra.peff.net>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
 <20130411043346.GE14551@sigill.intra.peff.net>
 <CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
 <20130411050509.GC27795@sigill.intra.peff.net>
 <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
 <CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
 <7v8v4l7ils.fsf@alter.siamese.dyndns.org>
 <CAMP44s22N9_E4oBG0UztXE0yAkX8TmQaE9-x1_wDHqv3bvZ0EQ@mail.gmail.com>
 <7vobdh54uh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:01:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSAd-00068k-Td
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3DNTA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:00:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45513 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106Ab3DNTAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:00:55 -0400
Received: (qmail 15814 invoked by uid 107); 14 Apr 2013 19:02:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 15:02:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 15:00:50 -0400
Content-Disposition: inline
In-Reply-To: <7vobdh54uh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221151>

On Sun, Apr 14, 2013 at 11:45:10AM -0700, Junio C Hamano wrote:

> Just rerolling with what _you_ think is an appropriate level of
> explanation (either or both in log and in-code) and see what happens
> would probably be the best way to proceed, I think, at this
> point. Either you hear "It still is wrong and too sketchy", "Yeah,
> thinking about it again, this is sufficient" from others.  Or a
> silent, which I am inclined to take as much closer to the latter
> after all the discussion.

FWIW, the last email I wrote on this patch said:

  So I can buy the argument that bumping it forward ourselves will not
  matter for any well-implemented helper.

and I was the only reviewer, so I think the code is probably OK. I also
said:

  That is the sort of thing that might be helpful to include in the
  commit message[...]

Felipe of course did not agree, but I have no interest in trying to
persuade him on that front, as it seems to just waste everyone's time.

-Peff
