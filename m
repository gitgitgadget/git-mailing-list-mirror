From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Tue, 1 May 2012 23:43:20 +0200
Message-ID: <87ipgfd1c7.fsf@thomas.inf.ethz.ch>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
	<xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
	<xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
	<87vckhuofj.fsf@thomas.inf.ethz.ch>
	<7vlilcczzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	"Thomas Gummerer" <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKr3-0001kz-IP
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2EAVnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 17:43:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57708 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2EAVnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 17:43:24 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Tue, 1 May
 2012 23:43:22 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.237) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 1 May
 2012 23:43:21 +0200
In-Reply-To: <7vlilcczzb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Apr 2012 21:00:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196758>

Junio C Hamano <gitster@pobox.com> writes:

> I am planning to merge this series early to 'master', before the GSoC
> student really starts working on the code, perhaps by this Wednesday. The
> earlier parts of this series refactor code to make things easier to
> modify, and the later parts of it demonstrate by example both:
>
>  (1) how the backward compatibility must be handled at the design level
>      [*1*]; and
>
>  (2) how such a design can be coded cleanly at the implementation level.
>
> The hope is that this will give a solidified base to build whatever new
> work on top of (perhaps call it v5).
[...]
> How do you want to proceed?

I was initially a bit reluctant to add this complexity so shortly before
the GSoC starts in earnest.  But the cleanups are really worth it, and
then it's not *that* much code for a quite substantial speedup for
webkit.

So go ahead and merge it.  Thomas can build on top, though I'm still
hoping he'll start before you complete the merge, and learn a bit about
basing work on top of unmerged topics ;-)

> I do not mind David's further work built on top of this series, but I
> think the entry-shrinkage design for v4 is good enough as-is.

My impression was that David just tossed around ideas (very
well-researched and tested ones, but still ideas) to help Thomas.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
