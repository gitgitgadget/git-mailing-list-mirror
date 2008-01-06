From: David Soria Parra <sn_@gmx.net>
Subject: Re: how to use git merge -s subtree?
Date: Sun, 06 Jan 2008 02:22:47 +0100
Message-ID: <flpah7$beg$2@ger.gmane.org>
References: <20080105230004.GY29972@genesis.frugalware.org> <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 02:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBKGg-0007I4-Jr
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 02:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYAFBZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 20:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYAFBZK
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 20:25:10 -0500
Received: from main.gmane.org ([80.91.229.2]:48215 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191AbYAFBZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 20:25:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JBKG6-0007li-On
	for git@vger.kernel.org; Sun, 06 Jan 2008 01:25:02 +0000
Received: from p57aee59d.dip.t-dialin.net ([87.174.229.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 01:25:02 +0000
Received: from sn_ by p57aee59d.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Jan 2008 01:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57aee59d.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69698>


> Hi Miklos,
> 
> Here's another way that is perhaps a little cleaner:
> 
> $ git remote add -f B /path/to/B
> $ git merge -s ours --no-commit B/master
> $ git read-tree --prefix=sub/ -u B/master 
> $ git commit -m "subtree merged B"
> 

hi sean,

that works perfectly but it doesn't preserve the history, does it?

                    dsp
