From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Adding colors to git-add--interactive
Date: Sun, 11 Nov 2007 00:23:46 -0800
Message-ID: <7vzlxlgpgt.fsf@gitster.siamese.dyndns.org>
References: <20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110180109.34febc3f@paradox.zwell.net>
	<20071111075446.GA26985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir87N-00031Q-Jn
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbXKKIYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXKKIYE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:24:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41316 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbXKKIYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:24:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BACDF2F2;
	Sun, 11 Nov 2007 03:24:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 318679371E;
	Sun, 11 Nov 2007 03:24:09 -0500 (EST)
In-Reply-To: <20071111075446.GA26985@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 11 Nov 2007 02:54:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64424>

Jeff King <peff@peff.net> writes:

>> -	system(qw(git diff-index -p --cached HEAD --),
>> -	       map { $_->{VALUE} } @them);
>> +	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
>
> Now this was a surprise after reading the commit message.

This hunk makes the "show diff" subcommand honor user's external
diff viewer if specified, which is a good change.  But it does
not belong to the "colored add -i" series.

I mildly suspect that this change might have been my fault, but
I think it should be treated in an independent patch anyway.
