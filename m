From: Jeff King <peff@peff.net>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 18:03:40 -0400
Message-ID: <20100331220340.GA4564@coredump.intra.peff.net>
References: <18137.1270056387@relay.known.net>
 <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:04:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx60z-00035Q-MD
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab0CaWDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:03:53 -0400
Received: from peff.net ([208.65.91.99]:33062 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab0CaWDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:03:52 -0400
Received: (qmail 15419 invoked by uid 107); 31 Mar 2010 22:04:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 31 Mar 2010 18:04:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Mar 2010 18:03:40 -0400
Content-Disposition: inline
In-Reply-To: <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143696>

On Wed, Mar 31, 2010 at 05:59:49PM -0400, Jay Soffian wrote:

> Aside, the only list of plumbing vs porcelain commands I'm aware of is
> in the bash-completion script under contrib. See
> __git_list_porcelain_commands here:
> 
> http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-completion.bash

Try command-list.txt, which is meant to be authoritative.

> (Note to git list: there should be a man page that has a single-line
> summary of each command and states whether the command is plumbing or
> porcelain. Maybe there is and I just don't know it.)

Try "man git", which splits the command list by porcelain and plumbing
(and further by subcategory).

-Peff
