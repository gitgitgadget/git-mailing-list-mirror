From: Jeff King <peff@peff.net>
Subject: Re: GSoC 2012 application process
Date: Fri, 2 Mar 2012 19:09:30 -0500
Message-ID: <20120303000930.GA32585@sigill.intra.peff.net>
References: <20120302091114.GA3984@sigill.intra.peff.net>
 <7vipimbro0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 01:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3cXh-0002oB-Vz
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 01:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965701Ab2CCAJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 19:09:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35677
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965489Ab2CCAJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 19:09:32 -0500
Received: (qmail 32453 invoked by uid 107); 3 Mar 2012 00:09:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Mar 2012 19:09:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2012 19:09:30 -0500
Content-Disposition: inline
In-Reply-To: <7vipimbro0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192076>

On Fri, Mar 02, 2012 at 01:48:31PM -0800, Junio C Hamano wrote:

> One thing unrelated to the proposal I have been wondering about was how
> well our release cycles mesh with the GSoC timeline.
> [...]
> In any case, it seems that they coincide fairly well for this year's
> students.

Thanks for a thorough analysis. This isn't something we really thought
too much about in years past (and it seems like you have been paying
more attention to the scheduling in general this past year, or at least
communicating more openly about). So given that the schedule coincides
reasonably well, I think it make sense to consider this a "pilot" year,
and to make a mental note to talk post-GSoC about how the schedule
worked (or didn't work).

Part of me thinks that no matter how much schedule planning we do,
students will always go their own and deliver work in fits and starts.
It's their nature (and I say that as somebody who managed to be a
student for 24 consecutive years :) ).

> By the way, I also considered splitting the 20-week period into two and a
> half cycles, coinciding -rc1 of the third cycle after the upcoming 1.7.10
> release and GSoC pencils down date. It would make the student success
> criteria "Is it in 'master'?" instead of "Is it in a release?", but the
> overall schedule did not work as well as the above.

Actually, we have been pretty lenient with student success in the past.
Many projects have been marked successful even if their code as not yet
in master, and in many cases never made it.

I think part of that is because we are often over-ambitious with our
projects, and the mentors and students realize near the end that the
project is much large or more difficult than originally realized. To
some degree that is a good thing, as it means students are working on
cool, interesting things that haven't been done before. But it may also
be worth making an effort to split ambitious projects into bite-sized
chunks. Even if step 3 doesn't make it in, steps 1 and 2 might end up as
a good project in themselves, and that is much better than the student
contributing nothing.

In some cases, too, the student pushes forward thinking on a subject
among the project members. The rev-cache code did not end up getting
merged. But I'm not sure I would consider it a failure. It was an
interesting experiment, and I think ultimately the complexity tradeoff
was a bit distasteful. However, the negative result and the experience
gained by the community were still worthwhile.

-Peff
