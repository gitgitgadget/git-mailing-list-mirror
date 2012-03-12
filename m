From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 00/11] perf improvements past v1.7.10
Date: Mon, 12 Mar 2012 17:30:46 +0100
Message-ID: <87sjhd6atl.fsf@thomas.inf.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
	<m3d38hztqt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7898-0008Kw-4A
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab2CLQau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:30:50 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:45788 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab2CLQat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:30:49 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:30:48 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:30:47 +0100
In-Reply-To: <m3d38hztqt.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Mon, 12 Mar 2012 09:09:19 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192898>

Jakub Narebski <jnareb@gmail.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   perf/aggregate: optionally include a t-test score
>
> By the way, have you heard about Dumbbench module on CPAN?  It is a
> module that attempts to implement reasonably robust benchmarking,
> trying to find and discard bad runs (outliers):
>
>   http://search.cpan.org/perldoc?Dumbbench
>
> It might be an easier solution (thanks to wonders of local::lib) than
> GNU R statistical package.

Thanks for that pointer, I'll look into it.  I'm less worried about
which particular package to use for the t-test (after all it's a pretty
well-known method and could also be hacked in directly), but from a
quick glance at the TOC they seem to have put a lot of thought into the
post-processing.

>>   perf: implement a test-selection feature
>>   perf: add a bisection tool
>
> It looks like those last two (10/11, 11/11) didn't made it to git
> mailing list, probably because of anti-spam size limits of email
> message on vger.

Oops, my bad.  It's not the filter but a 0 too many in my send-email
globs.  I sent them out, but for your merging convenience it's also at

  git://github.com/trast/git.git t/perf-gather-post-1.7.10

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
