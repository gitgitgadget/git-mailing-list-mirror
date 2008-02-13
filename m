From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Wed, 13 Feb 2008 05:37:10 -0500
Message-ID: <20080213103710.GA25808@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <m3k5l9cfzi.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:37:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEzt-0007jG-Av
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYBMKhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbYBMKhO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:37:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbYBMKhN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:37:13 -0500
Received: (qmail 13524 invoked by uid 111); 13 Feb 2008 10:37:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 05:37:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 05:37:10 -0500
Content-Disposition: inline
In-Reply-To: <m3k5l9cfzi.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73770>

On Wed, Feb 13, 2008 at 02:23:48AM -0800, Jakub Narebski wrote:

> > However, I wonder if this is the best approach. It would be nice if
> > there were a shorthand for "the empty tree" for diffing,
> 
> /dev/null? --root?

--root doesn't work since it is so entwined with diffing against an
actual tree. I was thinking something more like turning the magic ref
"EMPTY_TREE" internally into the empty tree, and then everything would
just work.

Or is that what you were suggesting "/dev/null" for? Another possible
name is 4b825dc642cb6eb9a060e54bf8d69288fbee4904, which is the SHA-1 of
the empty tree (currently, but I don't suppose we are going to change the
tree format anytime soon).

-Peff
