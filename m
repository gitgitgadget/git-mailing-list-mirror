From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH 1/4] Split up default "core" config parsing into helper routine
Date: Thu, 19 Jun 2008 00:18:49 +0000 (UTC)
Message-ID: <loom.20080619T000837-669@post.gmane.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <20080618224919.GA22599@sigill.intra.peff.net> <alpine.LFD.1.10.0806181552590.2907@woody.linux-foundation.org> <20080618231316.GB23053@sigill.intra.peff.net> <alpine.LFD.1.10.0806181632080.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 02:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97sZ-0002iB-T2
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbYFSATA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYFSAS7
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:18:59 -0400
Received: from main.gmane.org ([80.91.229.2]:59460 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616AbYFSAS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:18:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K97rd-00037M-BR
	for git@vger.kernel.org; Thu, 19 Jun 2008 00:18:57 +0000
Received: from 209-183-055-043.mobile.mymmode.com ([209-183-055-043.mobile.mymmode.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 00:18:57 +0000
Received: from raible by 209-183-055-043.mobile.mymmode.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 00:18:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 209.183.55.43 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9) Gecko/2008052906 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85431>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> Forget about "branch.mybranch.url". It has no meaning. It's not what you 
> are supposed to ever use as a human (it's purely for scripting). It's not 
> worth even thinking about.
> 
> 			Linus

But it's hard to forget about it when the 'git pull' error
message that begins with "You asked me to pull without ..."
mentions these specifically:
  branch.${curr_branch}.remote = <nickname>"
  branch.${curr_branch}.merge = <remote-ref>"
  remote.<nickname>.url = <url>"
  remote.<nickname>.fetch = <refspec>"

It seems to me it would be much more helpful if that message
gave some sample git config command lines rather than the
resulting "scripting-only" names.

- Eric
