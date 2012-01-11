From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Wed, 11 Jan 2012 21:05:26 +0100
Message-ID: <87lipexawp.fsf@thomas.inf.ethz.ch>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:05:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4QV-0003WS-Cl
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 21:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab2AKUFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 15:05:34 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50952 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083Ab2AKUFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 15:05:33 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:05:28 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.223) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 11 Jan
 2012 21:05:30 +0100
In-Reply-To: <1326302702-4536-2-git-send-email-rctay89@gmail.com> (Tay Ray
	Chuan's message of "Thu, 12 Jan 2012 01:25:02 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.223]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188390>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Factor out the comprehensive non-whitespace regex in use by PATTERNS and
> IPATTERN and use it as the word-diff regex for the default diff driver.

Why?

I seem to recall that the motivation for keeping the original code as-is
instead of just emulating its behavior with a default regex was that it
is faster.  So disabling the default mode should at least have an
advantage?

</devils-advocate>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
