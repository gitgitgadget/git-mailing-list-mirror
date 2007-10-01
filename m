From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Add a simple option parser for use by
	builtin-commit.c.
Date: Mon, 1 Oct 2007 11:00:50 -0400
Message-ID: <20071001150050.GA27904@coredump.intra.peff.net>
References: <1190868632-29287-1-git-send-email-krh@redhat.com> <20070930131133.GA11209@diku.dk> <Pine.LNX.4.64.0710011114310.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 17:01:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcMlk-0003YV-9K
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbXJAPAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 11:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbXJAPAy
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:00:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2102 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbXJAPAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 11:00:53 -0400
Received: (qmail 11102 invoked by uid 111); 1 Oct 2007 15:00:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Oct 2007 11:00:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2007 11:00:50 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710011114310.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59618>

On Mon, Oct 01, 2007 at 11:14:48AM +0100, Johannes Schindelin wrote:

> We _have_ to modify argv.  For example, "git log master -p" is perfectly 
> valid.

We're not going to support POSIXLY_CORRECT!? ;)

-Peff
