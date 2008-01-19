From: Jeff King <peff@peff.net>
Subject: Re: Tiny bug report, interaction between alias and help
Date: Sat, 19 Jan 2008 17:57:23 -0500
Message-ID: <20080119225723.GA17170@coredump.intra.peff.net>
References: <20080119142750.GA9182@phenix.progiciels-bpi.ca> <20080119174146.GA3913@coredump.intra.peff.net> <alpine.LSU.1.00.0801192252060.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Fran=E7ois?= Pinard <pinard@iro.umontreal.ca>,
	git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMdP-0001RT-2x
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 23:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYASW50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 17:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYASW50
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 17:57:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1535 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbYASW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 17:57:26 -0500
Received: (qmail 26571 invoked by uid 111); 19 Jan 2008 22:57:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 19 Jan 2008 17:57:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Jan 2008 17:57:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801192252060.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71137>

On Sat, Jan 19, 2008 at 10:55:24PM +0000, Johannes Schindelin wrote:

> Urgh... We really have something like that in git?  Looks like a prime 
> candidate for refactoring a la

Yes, my patch was a one-off "how about this?". I already have a
refactored version in my tree (that also converts cmd_help to use
parse_options), but I am holding on to it until post-1.5.4.

-Peff
