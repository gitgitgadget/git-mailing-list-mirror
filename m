From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Documentation/git-gc: improve description of --auto
Date: Thu, 18 Oct 2007 22:38:50 -0400
Message-ID: <20071019023850.GD8298@coredump.intra.peff.net>
References: <20071019020510.GB7711@coredump.intra.peff.net> <20071019022909.GZ14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihlS-0002b3-EN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763959AbXJSCix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763868AbXJSCix
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:38:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3889 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762294AbXJSCix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:38:53 -0400
Received: (qmail 7815 invoked by uid 111); 19 Oct 2007 02:38:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:38:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:38:50 -0400
Content-Disposition: inline
In-Reply-To: <20071019022909.GZ14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61613>

On Thu, Oct 18, 2007 at 10:29:09PM -0400, Shawn O. Pearce wrote:

> I personally prefer to read commands in the source as `foo` and
> feel that asciidoc should just format it correctly for the backend.
> If it isn't then we should try to work with the asciidoc folks to
> get it right...

I am hunting this down right now. asciidoc _does_ generate
XML <literal>foo</literal> for `foo`, but it looks like docbook is
throwing that away when converting to manpages. Hopefully there is an
easy tweak...

-Peff
