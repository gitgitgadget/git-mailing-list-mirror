From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998 characters
Date: Fri, 18 Jan 2008 03:01:10 -0800
Message-ID: <7v4pdbfle1.fsf@gitster.siamese.dyndns.org>
References: <20080117153252.GD2816@coredump.intra.peff.net>
	<1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>
	<47905F70.5090003@viscovery.net>
	<4790746D.1000502@users.sourceforge.net>
	<47907914.6000105@viscovery.net>
	<7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
	<47908150.9040201@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoyx-0001ps-TA
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbYARLB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 06:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbYARLB0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:01:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYARLBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:01:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 42EC96B80;
	Fri, 18 Jan 2008 06:01:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 83D056B7E;
	Fri, 18 Jan 2008 06:01:18 -0500 (EST)
In-Reply-To: <47908150.9040201@users.sourceforge.net> (Adam Piatyszek's
	message of "Fri, 18 Jan 2008 11:37:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70998>

Adam Piatyszek <ediap@users.sourceforge.net> writes:

> But what next? Still send the problematic patches not encoded?

I meant "warn and stop before sending anything".  The sender can
fix it up in any way he wants.

You _could_ give an option to send-email to allow it to QP and
wrap without failing (perhaps with warning), but that should be
explicitly asked for, as some people/list do not want MIME.  On
such a list, the sender may even have to go back to the tree and
fix the file contents before regenerating the patches.
