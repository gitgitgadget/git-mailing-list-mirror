From: Jeff King <peff@peff.net>
Subject: Re: git-branch man page contains rendered nroff
Date: Tue, 6 Jan 2009 00:35:45 -0500
Message-ID: <20090106053545.GA2632@coredump.intra.peff.net>
References: <87hc4dnner.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 06 06:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK4cp-00020M-Ai
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 06:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbZAFFft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 00:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbZAFFfs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 00:35:48 -0500
Received: from peff.net ([208.65.91.99]:39711 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbZAFFfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 00:35:47 -0500
Received: (qmail 31861 invoked by uid 107); 6 Jan 2009 05:36:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Jan 2009 00:36:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2009 00:35:45 -0500
Content-Disposition: inline
In-Reply-To: <87hc4dnner.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 06, 2009 at 11:06:36AM +0800, jidanni@jidanni.org wrote:

> $ make git-branch.1 && man -l git-branch.1|col -b|fgrep .ft|sort|uniq -c
>       2 	       .ft
>       2 	       .ft C

It's a toolchain issue. See:

  http://thread.gmane.org/gmane.comp.version-control.git/99392

or

  http://thread.gmane.org/gmane.comp.version-control.git/72290

-Peff
