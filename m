From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Thu, 2 Feb 2012 12:00:47 +0100
Message-ID: <87vcnp5wkg.fsf@thomas.inf.ethz.ch>
References: <20120201221437.GA19044@sigill.intra.peff.net>
	<20120201232109.GA2652@sigill.intra.peff.net>
	<7vhaza12ol.fsf@alter.siamese.dyndns.org>
	<20120202005209.GA6883@sigill.intra.peff.net>
	<20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:01:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuPR-0000MU-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab2BBLAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:00:52 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:19985 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab2BBLAv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:00:51 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 12:00:46 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 2 Feb
 2012 12:00:48 +0100
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 2 Feb 2012 03:17:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189623>

Jeff King <peff@peff.net> writes:

> [+cc Thomas, as I am mangling some of his recent work with my
>      refactoring]

Mangling?  I think it all looks very good.

My original plan was to make use_threads git-global, instead of
grep-global (and shift responsibility to the subsystems instead of their
users), but that's just me and the patches aren't ready yet.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
