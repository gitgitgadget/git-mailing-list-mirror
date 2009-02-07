From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Sat, 7 Feb 2009 12:44:27 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngor0hb.cq.sitaramc@sitaramc.homelinux.net>
References: <498C0525.5040100@gonsolo.de>
 <20090206193359.GF19494@coredump.intra.peff.net>
 <slrngopp7n.his.sitaramc@sitaramc.homelinux.net>
 <20090207064221.GA14856@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 13:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVmaP-0000pN-Nk
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 13:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbZBGMoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 07:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbZBGMoo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 07:44:44 -0500
Received: from main.gmane.org ([80.91.229.2]:55317 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbZBGMon (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 07:44:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVmY3-0002Mf-Vf
	for git@vger.kernel.org; Sat, 07 Feb 2009 12:44:40 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 12:44:39 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 12:44:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108846>

On 2009-02-07, Jeff King <peff@peff.net> wrote:
> A toy patch series follows; see 2/2 for a description of why it doesn't
> work like you might hope. I'm not too interested in trying to deal with
> the refactoring that would be required to do it right. But maybe
> somebody else is.

I was thinking it could simply be a separate utility in
contrib for starters, perhaps not even written in C.  I
don't mind volunteering to write one in shell+the usual
toolchain (and I'll test it on msysgit too, because I have
Windows users).  My C days are a bit behind me, sadly...
