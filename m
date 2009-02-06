From: =?utf-8?b?QmlzYW5pLA==?= Alok <alok.bisani@credit-suisse.com>
Subject: Re: git checkout effect on ls-files --others, how to merge partially?
Date: Fri, 6 Feb 2009 16:37:38 +0000 (UTC)
Message-ID: <loom.20090206T163626-457@post.gmane.org>
References: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCBD@ELON17P32001A.csfb.cs-group.com> <slrngooent.om3.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 18:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVUA0-0004Mi-OU
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 18:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZBFRFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 12:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZBFRFG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 12:05:06 -0500
Received: from main.gmane.org ([80.91.229.2]:47217 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbZBFRFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 12:05:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LVU8U-0007dD-9y
	for git@vger.kernel.org; Fri, 06 Feb 2009 17:05:02 +0000
Received: from ln-bas00.csfb.com ([198.240.128.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 17:05:02 +0000
Received: from alok.bisani by ln-bas00.csfb.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 17:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.240.128.75 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108761>

Sitaram Chamarty <sitaramc <at> gmail.com> writes:

> 
> On 2009-02-06, Bisani, Alok <alok.bisani <at> credit-suisse.com> wrote:
>
> > 	Is there a way to pull in changes from a branch but only limited
> > to a file/files? I ended up doing a manual restore using git-cat-file
> ><branch>@{0}:/file. And checked in.
> 
> git checkout branch -- filename
> 
> 

This is exactly what I was looking for, thank you! I wonder why it is the
checkout command which does this, rather than the pull/merge. What is the reason
that we cannot pull/merge a specific file from a branch?
