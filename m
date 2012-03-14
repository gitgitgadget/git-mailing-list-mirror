From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git svn dcommit: avoid self-referential mergeinfo lines when svn.pushmergeinfo is configured
Date: Wed, 14 Mar 2012 17:23:20 +0100
Message-ID: <87r4wvcft3.fsf@thomas.inf.ethz.ch>
References: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Bryan Jacobs <bjacobs@woti.com>
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7qz2-0007KT-D4
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab2CNQXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:23:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26177 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753094Ab2CNQXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:23:23 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 17:23:20 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 17:23:20 +0100
In-Reply-To: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
	(Avishay Lavie's message of "Wed, 14 Mar 2012 18:09:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193124>

Avishay Lavie <avishay.lavie@gmail.com> writes:

> For more details, see my original report on the issue at [1].
> [1] http://thread.gmane.org/gmane.comp.version-control.git/191932

You could replace this, which is annoying to look up and tedious to
verify, with a test (perhaps in t/t9151-svn-mergeinfo.sh) that checks
that your reported scenario acts correctly.

(I'm afraid I can't say anything about the problem itself, as I do not
have a use for the mergeinfo feature...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
