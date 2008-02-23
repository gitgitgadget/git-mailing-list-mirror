From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 15:40:06 -0500
Message-ID: <20080223204005.GA12502@coredump.intra.peff.net>
References: <20080220235944.GA6278@coredump.intra.peff.net> <20080221000044.GB6429@coredump.intra.peff.net> <200802232113.40100.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:40:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1At-0006S6-E2
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 21:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYBWUkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYBWUkL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 15:40:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3844 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbYBWUkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 15:40:10 -0500
Received: (qmail 10488 invoked by uid 111); 23 Feb 2008 20:40:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 23 Feb 2008 15:40:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Feb 2008 15:40:06 -0500
Content-Disposition: inline
In-Reply-To: <200802232113.40100.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74849>

On Sat, Feb 23, 2008 at 09:13:39PM +0100, Johannes Sixt wrote:

> > -cat > fake-editor.sh <<\EOF
> > -#!/bin/sh
> > +echo "#!$SHELL" >fake-editor
> 
> Did you mean fake-editor.sh here?

Gah, yes. Not sure how I was even able to run the test with that error.

Junio, your $SHELL_PATH fix looks sensible, too.

-Peff
