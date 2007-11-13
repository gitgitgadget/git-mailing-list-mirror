From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from .gitconfig
Date: Mon, 12 Nov 2007 23:29:24 -0800
Message-ID: <7v4pfqwqln.fsf@gitster.siamese.dyndns.org>
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
	<20071110202351.7b4544aa@paradox.zwell.net>
	<7vve89f6qy.fsf@gitster.siamese.dyndns.org>
	<47390050.1020907@zwell.net>
	<7v4pfq27tx.fsf@gitster.siamese.dyndns.org>
	<47391211.5000606@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 08:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrqDi-0000UQ-MT
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 08:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXKMH3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 02:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXKMH3g
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 02:29:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48261 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbXKMH3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 02:29:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6724E2F9;
	Tue, 13 Nov 2007 02:29:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 824E6921F3;
	Tue, 13 Nov 2007 02:29:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64760>

Dan Zwell <dzwell@gmail.com> writes:

> ... I wrote this with the intent
> that it should ignore invalid color names, but it would probably be
> more useful to print a warning.

But the point is, that you are not ignoring invalid color names
but instead giving back a random match aren't you?
