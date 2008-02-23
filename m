From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 16:12:19 -0500
Message-ID: <20080223211219.GA13178@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <20080221000044.GB6429@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at> <20080223204005.GA12502@coredump.intra.peff.net> <7v1w732y97.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 22:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1g1-0006jo-N1
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757614AbYBWVMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 16:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756294AbYBWVMW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:12:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4702 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbYBWVMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 16:12:21 -0500
Received: (qmail 10701 invoked by uid 111); 23 Feb 2008 21:12:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 16:12:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 16:12:19 -0500
Content-Disposition: inline
In-Reply-To: <7v1w732y97.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74853>

On Sat, Feb 23, 2008 at 12:50:28PM -0800, Junio C Hamano wrote:

> > Gah, yes. Not sure how I was even able to run the test with that error.
> 
> Simple.  fake-editor.sh does not begin with #! anymore and exec
> causes /bin/sh to run, and your system happens to have a sane

I thought I tested it on the Solaris box with the broken shell, but
perhaps not.

> shell there.  If you used $SHELL not $SHELL_PATH and wrote to
> fake-editor.sh, you would have noticed that using $SHELL there
> was wrong as it would have said "#!bash" for you ;-)

Actually, my $SHELL is "/usr/local/bin/bash" on the box in question.

-Peff
