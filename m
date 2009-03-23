From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Mon, 23 Mar 2009 15:12:39 +0100
Message-ID: <20090323141238.GA14722@glandium.org>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca> <20090323065710.GA7048@coredump.intra.peff.net> <1237812904-sup-3864@ntdws12.chass.utoronto.ca> <20090323140302.GA11005@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	GIT List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:14:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlkvQ-0008VK-5f
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987AbZCWOMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbZCWOMy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:12:54 -0400
Received: from vuizook.err.no ([85.19.221.46]:37835 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757987AbZCWOMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:12:53 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LlktN-0008VK-QB; Mon, 23 Mar 2009 15:12:44 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LlktL-0004BL-9a; Mon, 23 Mar 2009 15:12:39 +0100
Content-Disposition: inline
In-Reply-To: <20090323140302.GA11005@coredump.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114310>

On Mon, Mar 23, 2009 at 10:03:02AM -0400, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 23, 2009 at 08:57:27AM -0400, Ben Walton wrote:
> 
> > That's a fair point.  I've been lugging this around for a bit in the
> > build tree I use, so I don't recall specifically what was breaking.
> > The sh in question is the one found in solaris 8.  When I get a few
> > mintues, I'll build without the patch to see what the problem was...
> 
> I wouldn't worry about it. The /bin/sh on Solaris 8 is pretty hopelessly
> broken for our use. At the very least it doesn't understand $()
> subsititution.

Neither does it on solaris 10. Fortunately, there is /usr/xpg4/bin/sh.

Mike
