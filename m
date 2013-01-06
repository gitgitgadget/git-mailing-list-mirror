From: Adam Spiers <git@adamspiers.org>
Subject: Re: as/check-ignore (was Re: What's cooking in git.git (Jan 2013,
 #02; Thu, 3))
Date: Sun, 6 Jan 2013 16:17:58 +0000
Message-ID: <20130106161758.GC2396@pacific.linksys.moosehall>
References: <7vmwwqvzy4.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-f-8XZAzWrQgh_DG=fZctqBFXqpog-FSDU_yeXfwWTwA@mail.gmail.com>
 <7vobh4tzx3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 17:18:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trsw1-0007FP-6Q
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab3AFQSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:18:03 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45529 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009Ab3AFQSC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:18:02 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 680492E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:17:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vobh4tzx3.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212811>

On Fri, Jan 04, 2013 at 01:13:12PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> > On Thu, Jan 3, 2013 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> * as/check-ignore (2012-12-28) 19 commits
> >>  - Add git-check-ignore sub-command
> >>  - setup.c: document get_pathspec()
> >>  - pathspec.c: extract new validate_path() for reuse
> >>  - pathspec.c: move reusable code from builtin/add.c
> >>  - add.c: remove unused argument from validate_pathspec()
> >>  - add.c: refactor treat_gitlinks()
> >>  - dir.c: provide clear_directory() for reclaiming dir_struct memory
> >>  - dir.c: keep track of where patterns came from
> >>  - dir.c: use a single struct exclude_list per source of excludes
> >>  - dir.c: rename free_excludes() to clear_exclude_list()
> >>  - dir.c: refactor is_path_excluded()
> >>  - dir.c: refactor is_excluded()
> >>  - dir.c: refactor is_excluded_from_list()
> >>  - dir.c: rename excluded() to is_excluded()
> >>  - dir.c: rename excluded_from_list() to is_excluded_from_list()
> >>  - dir.c: rename path_excluded() to is_path_excluded()
> >>  - dir.c: rename cryptic 'which' variable to more consistent name
> >>  - Improve documentation and comments regarding directory traversal API
> >>  - api-directory-listing.txt: update to match code
> >>
> >>  Rerolled.  The early parts looked mostly fine; we may want to split
> >>  this into two topics and have the early half graduate sooner.
> >
> > Sounds good to me.  As already mentioned, I have the v4 series ready
> > and it addresses all issues already voiced in v3, but I have postponed
> > submitting it as per your request.  Please let me know when and how to
> > proceed, thanks!
> 
> I was planning to add a new "as/dir-c-cleanup" topic that leads to
> f619881 (dir.c: rename free_excludes() to clear_exclude_list(),
> 2012-12-27), and leave the remainder in this series.  I think the
> earlier parts of this series up to that point should go 'next' now.

That sounds perfect; thanks.  I'll rebase v4 on top of this and submit.
