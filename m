From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Sat, 17 Nov 2007 17:06:51 -0800
Message-ID: <7vejeoz7is.fsf@gitster.siamese.dyndns.org>
References: <18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru>
	<7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
	<20071118002514.GA4458@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYd7-0001gu-Bb
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbXKRBHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXKRBHD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:07:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53054 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbXKRBHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:07:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 791042F0;
	Sat, 17 Nov 2007 20:07:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EC7E396EFD;
	Sat, 17 Nov 2007 20:07:14 -0500 (EST)
In-Reply-To: <20071118002514.GA4458@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 17 Nov 2007 19:25:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65330>

Jeff King <peff@peff.net> writes:

> Junio, can I get an ACK or NAK on the patch below?

I do not think it would hurt.  Is the "local" case the only
codepath that needs this (iow, we would not need this message if
other transports die more loudly and/or we cannot tell if the
failure is wrong URL or empty remote repository)?
