From: Jeff King <peff@peff.net>
Subject: Re: Security and permissions in git
Date: Thu, 29 Jan 2009 18:23:58 -0500
Message-ID: <20090129232358.GA12941@coredump.intra.peff.net>
References: <loom.20090129T203050-865@post.gmane.org> <alpine.LNX.1.00.0901291645300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Renbaum <jrenbaum@hcrest.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgGM-0001Oi-3j
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbZA2XYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753445AbZA2XYB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:24:01 -0500
Received: from peff.net ([208.65.91.99]:46182 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbZA2XYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:24:01 -0500
Received: (qmail 20259 invoked by uid 107); 29 Jan 2009 23:24:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 18:24:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 18:23:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0901291645300.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107752>

On Thu, Jan 29, 2009 at 05:13:41PM -0500, Daniel Barkalow wrote:

> Every commit contains a version of the complete contents, so people have 
> to be able to read the contents of all directories and write some 
> directory contents. However, you can prohibit users from pushing content 
> to the repository unless particular directories (or files) match what's 
> there already. This is generally what people want when they have this 
> requirement.

If this is what you want, see Shawn's contrib/hooks/update-paranoid,
which lets you specify ACLs in the config.

-Peff
