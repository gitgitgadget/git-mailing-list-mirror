From: Jeff King <peff@peff.net>
Subject: Re: "git add" and absolute paths
Date: Mon, 28 Jan 2008 13:32:23 -0500
Message-ID: <20080128183223.GA31140@coredump.intra.peff.net>
References: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com> <m33asi9jxp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	git mailing list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:33:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJYmx-0001zY-Ma
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 19:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbYA1Sc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 13:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYA1Sc1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 13:32:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1565 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbYA1Sc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 13:32:26 -0500
Received: (qmail 30871 invoked by uid 111); 28 Jan 2008 18:32:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 28 Jan 2008 13:32:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2008 13:32:23 -0500
Content-Disposition: inline
In-Reply-To: <m33asi9jxp.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71895>

On Mon, Jan 28, 2008 at 05:08:44AM -0800, Jakub Narebski wrote:

> > I understand that you can't add arbitrary paths outside of your
> > worktree, but if the absolute path specifies something _inside_ your
> > worktree then it seems that this is either a bug or a "usability
> > shortcoming" if you prefer to avoid the term "bug".
> 
> If I remember correctly this issue was discussed on git mailing list,
> and I guess there were even some patches implementing that, but I
> don't know what happened iwth them: freeze persiod, troubles with
> Cygwin (MS Windows), or what...

I think the thread just trailed off, and no replacement patch got
submitted. See this thread:

  http://mid.gmane.org/200712032153.31322.robin.rosenberg.lists@dewire.com

-Peff
