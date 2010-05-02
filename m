From: Jeff King <peff@peff.net>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals
 revision specifiers
Date: Sun, 2 May 2010 01:00:54 -0400
Message-ID: <20100502050054.GE14776@coredump.intra.peff.net>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun May 02 07:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8RIa-00014V-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 07:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab0EBFA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 01:00:56 -0400
Received: from peff.net ([208.65.91.99]:52053 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab0EBFAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 01:00:55 -0400
Received: (qmail 3707 invoked by uid 107); 2 May 2010 05:01:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 01:01:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 01:00:54 -0400
Content-Disposition: inline
In-Reply-To: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146135>

On Sat, May 01, 2010 at 08:36:33PM +0200, Michael J Gruber wrote:

> Due to the increasing usage of the ref namespace (e.g. notes, replace)
> the revision specifier "--all" becomes decreasingly useful. But
> "something like --all" is ineeded for getting a quick overview of
> the development state of a repository.
> 
> Introduce --heads and --locals specifiers in order to help with that:
> 
> --heads == HEAD --branches --remotes
> --locals = HEAD --branches --tags

I don't have anything against the concept, but "--heads" is a horrible
name, as it implies refs/heads (which is of course what --branches does.
Yikes!). I know why you picked it, and once you think about it, yes, it
does make some sense (it is all the local and remote heads), but I am
worried that it will cause confusion.

-Peff
