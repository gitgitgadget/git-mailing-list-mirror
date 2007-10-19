From: Jeff King <peff@peff.net>
Subject: Re: Splitting a repository
Date: Thu, 18 Oct 2007 20:33:34 -0400
Message-ID: <20071019003334.GA3290@coredump.intra.peff.net>
References: <47179944.6080608@filmaura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gonzalo Garramuno <gga@filmaura.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IifoC-0008TT-O6
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbXJSAdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXJSAdi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:33:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1428 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbXJSAdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:33:37 -0400
Received: (qmail 5850 invoked by uid 111); 19 Oct 2007 00:33:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 20:33:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 20:33:34 -0400
Content-Disposition: inline
In-Reply-To: <47179944.6080608@filmaura.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61583>

On Thu, Oct 18, 2007 at 02:35:00PM -0300, Gonzalo Garramuno wrote:

> I have a project I have been working on for some time and one of its 
> libraries has grown too much.
> I'm now wanting to split that library into a separate git repository.
> I'm wondering what's the best way to go around this.  Ideally I would like 
> to have:

Look at the documentation for "git-filter-branch". You can make a new
history for each of the split parts that you want.

-Peff
