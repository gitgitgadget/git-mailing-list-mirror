From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Does content provenance matter?
Date: Mon, 7 May 2012 10:23:38 +0200
Message-ID: <878vh4flh1.fsf@thomas.inf.ethz.ch>
References: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Kelly Dean <kellydeanch@yahoo.com>
X-From: git-owner@vger.kernel.org Mon May 07 10:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRJEZ-0002QR-9V
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 10:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab2EGIXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 04:23:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:30951 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab2EGIXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 04:23:49 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 7 May
 2012 10:23:46 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (78.110.190.183) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 10:23:45 +0200
In-Reply-To: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
	(Kelly Dean's message of "Sat, 5 May 2012 13:49:16 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [78.110.190.183]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197242>

Kelly Dean <kellydeanch@yahoo.com> writes:

> [copying B/X over to C/X is not recorded as such], on the theory that
> just content, not provenance, is what matters.

> [merging branches *is* recorded], on the theory that not only content,
> but also provenance, matters.

> The basic question is, if provenance doesn't matter, then why does a
> git commit record its parent(s)? Why not omit this information, and
> figure it out at search time (by looking at all commits with older
> timestamps), the same as you're supposed to figure out renames at
> search time and figure out the movement of lines within/among files at
> search time (by looking at all files in the parent commit(s))?

What's the difference between the following series of commits?

  Foo
  Bar
  Revert Bar

and

  Foo

You claim that they're the same, because the tree state after each is
the same.  But I learned that Bar was broken, and recorded it for all to
see.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
