From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: replacing a bad commit
Date: Mon, 05 Feb 2007 17:38:18 +0100
Organization: At home
Message-ID: <eq7mf0$lb0$1@sea.gmane.org>
References: <20070205153949.GT14499@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 17:37:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE6qn-0003sp-E2
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 17:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXBEQhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 11:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXBEQhu
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 11:37:50 -0500
Received: from main.gmane.org ([80.91.229.2]:49727 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbXBEQht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 11:37:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HE6q7-0004Pz-7R
	for git@vger.kernel.org; Mon, 05 Feb 2007 17:37:11 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 17:37:11 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 17:37:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38759>

Blu Corater wrote:

> Here is the situation. Upstream realeses tarballs once in a while. I
> maintain local modifications. Every time upstream releases a tarball, I
> fast forward the 'upstream' branch, and merge into 'local' branch. My
> tree, currently, looks somewhat like this:
> 
>                o---o---o <--topic2
>                |
>                |  o---o---o <--topic1
>                | /
>    o---o---C---A---o---o <--local
>   /   /   /  
>  /   /   /
> o---o---o---B <--upstream
> 
> Problem is, B should have been merged into 'local', at A, but I just
> realized it wasn't (probably due to my own stupidity).
> 
> I need to correct A, i.e. merge with B, but keeping the branches already
> in flux, and propagating the changes due to the merge to them. In short,
> replace A with a properly merged A'.
> 
> I tried branching from C and merging with B, then rebasing topic branches,
> but then I am not sure how to rebase 'local'to eliminate A.

Try using

  $ git rebase --onto A' A local

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
