From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 00/11] blame/log -L: additional tests and bug fixes
Date: Sat, 3 Aug 2013 16:41:19 +0200
Message-ID: <87ob9e25ww.fsf@hexa.v.cablecom.net>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 16:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5d1K-0005mD-3p
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 16:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab3HCOlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 10:41:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9034 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab3HCOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 10:41:21 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 16:41:15 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 3 Aug
 2013 16:41:19 +0200
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Wed, 31 Jul 2013 04:15:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231597>

Eric Sunshine <sunshine@sunshineco.com> writes:

> While working on multiple -L support for git-blame, I encountered more
> issues with the existing -L facility in git-blame and git-log. This
> series fixes these problems and adds a slew of new tests.
>
> Patch 6/11 (t4211: retire soon-to-be unimplementable tests) may be
> controversial. Removal of these tests was effectively a decision made in
> isolation since my request for input [1] regarding the issue generated
> only a single response (from j6t).

I agree with that decision.  It's better to not leave any user-facing
quirks just for internal's sake.

The right thing would be to either expose enough of the range_set api
through a test-range-set command, or just write all the tests in C.
Both seem a bit excessive since the API doesn't have any users outside
of log -L, which probably approaches "reasonable quality" now that you
shaked it down quite a bit.

As for the series, my tuits don't go further than a cursory read today,
but from that it seems good.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
