From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: Delete a commit
Date: Mon, 21 Dec 2009 18:49:36 +0100
Message-ID: <hgocfi$pge$1@ger.gmane.org>
References: <20091219233957.GC29111@marge.bs.l> <hgjpqu$dos$1@ger.gmane.org> <20091220004340.GA30440@marge.bs.l>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 18:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMmOf-0007HF-8e
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 18:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZLURuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbZLURuJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 12:50:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:59634 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZLURuI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 12:50:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NMmOT-0007A3-6q
	for git@vger.kernel.org; Mon, 21 Dec 2009 18:50:05 +0100
Received: from dsl-083-247-086-199.solcon.nl ([83.247.86.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 18:50:05 +0100
Received: from johanthart by dsl-083-247-086-199.solcon.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 18:50:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-083-247-086-199.solcon.nl
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091220004340.GA30440@marge.bs.l>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135561>

Bertram Scharpf schreef:
> Hi,

>   % git fsck --lost-found
>   dangling commit 6abc221327e896c850c56dafae92277bcfe68e2b
> 
> It is still there. This is the one I want to delete.

It is not in the history of any head anymore, so you could consider it 
deleted. ('git log' does not show this commit)

If you want to prune unreferenced objects, try:
git prune

('git help prune' for options)


> Bertram
> 
> 
