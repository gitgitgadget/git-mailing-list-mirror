From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 20:49:03 -0400
Message-ID: <20070514004903.GC6689@coredump.intra.peff.net>
References: <20070512064159.GA7471@coredump.intra.peff.net> <200705131235.25281.jnareb@gmail.com> <20070514003910.GA6689@coredump.intra.peff.net> <200705140250.22478.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 02:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOkR-0003YE-K2
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530AbXENAtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758388AbXENAtH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:49:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3591 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758530AbXENAtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:49:07 -0400
Received: (qmail 1933 invoked from network); 14 May 2007 00:49:04 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 May 2007 00:49:04 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 May 2007 20:49:03 -0400
Content-Disposition: inline
In-Reply-To: <200705140250.22478.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47209>

On Mon, May 14, 2007 at 02:50:22AM +0200, Jakub Narebski wrote:

> -'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
> +'git-add' [-n] [-v] [-f] [--] <file>...
> +'git-add' [-n] [-v] [-f] -u [[--] <file>...]
> +'git-add' (--interactive | -i)

I don't see the point in splitting -u out as its own separate "mode" of
operation. To me it's conceptually a flag that says "don't add untracked
files, and remove deleted files". But I don't have a strong opinion (and
certainly splitting out -i makes sense).

-Peff
