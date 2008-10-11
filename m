From: Jeff King <peff@peff.net>
Subject: Re: Adding Reviewed-by/Tested-by tags to other peoples commits
Date: Sat, 11 Oct 2008 03:46:04 -0400
Message-ID: <20081011074604.GA23883@sigill.intra.peff.net>
References: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 09:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoZC8-0008IK-N0
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 09:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYJKHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYJKHqK
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 03:46:10 -0400
Received: from peff.net ([208.65.91.99]:3663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbYJKHqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 03:46:09 -0400
Received: (qmail 5386 invoked by uid 111); 11 Oct 2008 07:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 11 Oct 2008 03:46:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Oct 2008 03:46:04 -0400
Content-Disposition: inline
In-Reply-To: <b2cdc9f30810102337q13432bepa957acaace9ddc5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97966>

On Sat, Oct 11, 2008 at 07:37:04AM +0100, Alex Bennee wrote:

> I've just tested/reviewed a patch of someone elses and I want to
> forward it on the appropriate mailing list. I gather for Linux you
> just add the appropriate tags to the commit. Does git offer a shortcut
> for doing this or do you have to do a reset HEAD^ and re-commit with a
> copy&pasted and modified commit message?

Try "git commit --amend" to edit the commit message. There's no
automatic way of adding acked-by or tested-by tags with git; most people
who do those things often would probably configure their editor to make
it easier.

-Peff
