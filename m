From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Fri, 11 Jul 2014 14:29:02 -0400
Message-ID: <20140711182902.GH7856@sigill.intra.peff.net>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
 <20140707063540.3708.51047.chriscool@tuxfamily.org>
 <xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
 <xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
 <xmqqegxt86ba.fsf@gitster.dls.corp.google.com>
 <CAP8UFD0_m5aFVcBQr3d9pXR=9rLjAVPGrj=UsBYFcnTQFwNKGA@mail.gmail.com>
 <xmqqmwcg561j.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2db=ZMFSvzW6be3gBv7DP93C7Z5yfOEhs9QLNOkX0fGQ@mail.gmail.com>
 <xmqq4myn4us8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:29:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fZH-0002qb-KK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbaGKS3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:29:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:60310 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751424AbaGKS3F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:29:05 -0400
Received: (qmail 16410 invoked by uid 102); 11 Jul 2014 18:29:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 13:29:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 14:29:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4myn4us8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253312>

On Fri, Jul 11, 2014 at 11:25:43AM -0700, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > On Fri, Jul 11, 2014 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>
> >>> On Thu, Jul 10, 2014 at 7:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>>>> "Making sure A's parent is B" would be an
> >>>>> idempotent operation, no?  Why not just make sure A's parent is
> >>>>> already B and report "Your wish has been granted" to the user?
> >>>
> >>> ... and here you say we should report "your wish has been granted"...
> >>
> >> Normal way for "git replace" to report that is to exit with status 0
> >> and without any noise, I would think.
> >
> > In a similar case "git replace --edit" we error out instead of just
> > exiting (with status 0), see:
> >
> > f22166b5fee7dc (replace: make sure --edit results in a different object)
> 
> I do not care *too* deeply, but if you ask me, that may be a mistake
> we may want to fix before the next release.

Yeah, I also do not care too deeply, but I mentioned in the earlier
review that I would expect it to just remove the replacement if it ends
up generating the same object.

-Peff
