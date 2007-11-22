From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Colors for git-add--interactive
Date: Thu, 22 Nov 2007 11:20:47 -0800
Message-ID: <7vve7u3x4g.fsf@gitster.siamese.dyndns.org>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071122045437.46ee4638@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvHby-0004CU-S8
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbXKVTVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 14:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbXKVTVA
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:21:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38575 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbXKVTU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 14:20:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EFFB02F0;
	Thu, 22 Nov 2007 14:21:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 515C498936;
	Thu, 22 Nov 2007 14:21:11 -0500 (EST)
In-Reply-To: <20071122045437.46ee4638@paradox.zwell.net> (Dan Zwell's message
	of "Thu, 22 Nov 2007 04:54:37 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65837>

Dan Zwell <dzwell@zwell.net> writes:

> My impression is that diff --cc is called any time
> that HEAD has two parents. Is this correct?

You get combined output when your index is unmerged.

Showing combined output to the user to examine may make sense,
but I think you would want to have the user pick from diff
between stage#2 and the work tree for an unmerged entry, if you
allow to pick hunks during a conflicted merge.
