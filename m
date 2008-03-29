From: Jeff King <peff@peff.net>
Subject: Re: why multiple password prompts?
Date: Sat, 29 Mar 2008 18:05:43 -0400
Message-ID: <20080329220543.GD30851@coredump.intra.peff.net>
References: <alpine.WNT.1.10.0803291141550.11992@znlsyl> <alpine.LNX.1.00.0803291241020.19665@iabervon.org> <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, Paul <lists@pote.com>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 23:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfjBz-0005oi-C4
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 23:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYC2WFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYC2WFq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 18:05:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2906 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbYC2WFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 18:05:45 -0400
Received: (qmail 8784 invoked by uid 111); 29 Mar 2008 22:05:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 18:05:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 18:05:43 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90803291137l20244abcke54941dc92c2c8b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78487>

On Sat, Mar 29, 2008 at 02:37:00PM -0400, Martin Langhoff wrote:

> That's cool - didn't know a rework of the ssh interactions had
> happened. It would be really good if we could detect if there's an
> existing "master" connection and piggyback over that (see options -M
> and -O). Reading man ssh_config it looks like we may be able to say
> something along the lines of " -o ControlMaster=auto ".

I have been using this for at least a year with git; just put
"ControlMaster auto" into your .ssh/config.

-Peff
