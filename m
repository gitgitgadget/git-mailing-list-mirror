From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sun, 26 Oct 2008 00:52:00 -0400
Message-ID: <20081026045200.GA21178@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net> <20081025005256.GD23903@coredump.intra.peff.net> <7vhc71b5ai.fsf@gitster.siamese.dyndns.org> <20081025071912.GA24287@coredump.intra.peff.net> <7v3aika5l7.fsf@gitster.siamese.dyndns.org> <20081025193554.GA27457@coredump.intra.peff.net> <7vvdvg6xto.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:53:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktxcs-0006Tq-Ct
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbYJZEwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYJZEwE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:52:04 -0400
Received: from peff.net ([208.65.91.99]:4388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbYJZEwE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:52:04 -0400
Received: (qmail 5133 invoked by uid 111); 26 Oct 2008 04:52:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:52:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:52:00 -0400
Content-Disposition: inline
In-Reply-To: <7vvdvg6xto.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99149>

On Sat, Oct 25, 2008 at 04:48:19PM -0700, Junio C Hamano wrote:

> Another place that would benefit from ALLOW_TEXTCONV is the function
> wt_status_print_verbose() in wt-status.c, where we generate preview diff
> for "git commit -v".  The output from that function is purely for human
> consumption and does not have to be applicable.

I agree, but it turned out not to be as straightforward as I had hoped,
since status doesn't even parse diff.* config.  See patches 7 and 8 in
the series I just posted.

-Peff
