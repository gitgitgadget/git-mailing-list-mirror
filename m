From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory leaks
Date: Fri, 26 May 2006 07:29:49 +0200
Organization: At home
Message-ID: <e563o9$f6a$1@sea.gmane.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz> <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org> <46a038f90605251742p2435ae23k8bfbb98409a30c1c@mail.gmail.com> <Pine.LNX.4.64.0605252204590.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 26 07:30:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjUts-0007S2-Hq
	for gcvg-git@gmane.org; Fri, 26 May 2006 07:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWEZFaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 01:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbWEZFaI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 01:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:46998 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030212AbWEZFaG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 01:30:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FjUtY-0007Pt-CD
	for git@vger.kernel.org; Fri, 26 May 2006 07:29:56 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 07:29:56 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 May 2006 07:29:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20794>

Linus Torvalds wrote:

> 200k commits at 6k commits per hour is about a day and a half (plus the 
> occasional packing load). Taking that long to import a CVS archive is 
> horrible. But I guess it _is_ several years of work, and I guess you 
> really have to do it only once, but still.

And how parsecvs (which as far as I remember didn't have incremental mode)
compares wrt speed to git-cvsimport? It is supposed to be faster...

-- 
Jakub Narebski
Warsaw, Poland
