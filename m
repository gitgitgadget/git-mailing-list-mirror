From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Delete a commit
Date: Sun, 20 Dec 2009 01:06:46 +0100
Message-ID: <hgjpqu$dos$1@ger.gmane.org>
References: <20091219233957.GC29111@marge.bs.l>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 01:08:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9LJ-0001HQ-H0
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbZLTAHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZLTAHU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:07:20 -0500
Received: from lo.gmane.org ([80.91.229.12]:53617 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZLTAHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:07:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NM9KN-0000yb-JJ
	for git@vger.kernel.org; Sun, 20 Dec 2009 01:07:15 +0100
Received: from dsl-083-247-086-199.solcon.nl ([83.247.86.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 01:07:15 +0100
Received: from johanthart by dsl-083-247-086-199.solcon.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 01:07:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-083-247-086-199.solcon.nl
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091219233957.GC29111@marge.bs.l>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135508>

Bertram Scharpf schreef:
> Hi,
> 
> I fetched a line from the shell's history and accidentally hit
> enter before editing it. Then I had commited some work that was
> not completed. Is there a way to get rid of that commit as if it
> never were there?

Try:
git reset --soft HEAD~1

You could also:
git commit --amend ...

when you realy finish the commit.

> 
> Thanks in advance.
> 
> Bertram
> 
> 
