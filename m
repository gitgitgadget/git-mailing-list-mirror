From: Jeff King <peff@peff.net>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Tue, 27 Mar 2012 01:41:21 -0400
Message-ID: <20120327054120.GA24170@sigill.intra.peff.net>
References: <201203241711.30270.jnareb@gmail.com>
 <CALUzUxrZibRf5ERgM7QAxsP4QDNZj-RvuLLh0bW5mqMWQnDcig@mail.gmail.com>
 <4F6F3286.5040803@andrewalker.net>
 <201203251745.48858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QW5kcsOp?= Walker <andre@andrewalker.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:41:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCPA5-0002ks-36
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab2C0Fl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:41:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33563
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab2C0FlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:41:25 -0400
Received: (qmail 31198 invoked by uid 107); 27 Mar 2012 05:41:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 01:41:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 01:41:21 -0400
Content-Disposition: inline
In-Reply-To: <201203251745.48858.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194012>

On Sun, Mar 25, 2012 at 04:45:47PM +0100, Jakub Narebski wrote:

> > Right. But would there be room for every student anyhow? Or, at least, 
> > would there be room for more students if there were more ideas / projects?
> 
> I don't know the details of how decision is made on how many project
> slots a GSoC organization will get, but in earlier GSoC (see Git Wiki)
> we get 2 to 6 projects (IIRC).
> 
> One limitation is number of possible mentors.

The decision is made by Google, taking into account how many slots we
ask for and how many slots other organizations ask for. The number of
slots we ask for depends on how many projects we have a good candidate
for. And also taking into account that mentor time is limited, so a
mentor who volunteers for two projects will probably only get one
selected.

Students should keep in mind, too, that items on the "ideas" page are
not the only potential projects. We have considered and sometimes
accepted projects that were totally of students' creation. Obviously
it's a bit harder to make such a proposal, since the student really
needs to be familiar with git.

> BTW. according to Google Summer of Code FAQ there can be more than one
> student working on the same project.  Though IIRC it never happened in
> history of Git participation in GSoC, isn't it?

Sort of. Students cannot work together, and are evaluated independently.
This being open source, of course, we expect people to communicate and
collaborate. But each student does his or her own project, and the goals
of that project are to be met by the student. So you can have two
students work in the same area, but you must do one of:

  1. Break the project into two independent pieces, and assign a student
     to each piece.

  2. Have the students compete, and pick the best implementation or
     approach at the end.

We haven't done either in the past, for a few reasons.  In the first
case, it can be very difficult to evaluate the students independently,
because even if one student completes their half, it may be hard to see
how good it is without the other student's half. In the second case,
evaluations can also be hard. We usually try to have a concrete
goal for success, like getting code accepted upstream; but with
competing students, that is unnecessarily harsh, since even good work
may not be taken. And in both cases, it is creating extra load on the
mentor, who has to spend twice as much time.

So while nothing is definite at this point, I would generally expect to
see at most one student per project area. And many projects will
probably not get picked at all, either because there isn't a strong
proposal, or because the proposed mentor ends up with another student.

-Peff
