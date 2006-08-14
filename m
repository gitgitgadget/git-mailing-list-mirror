From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 20:33:11 +0200
Organization: At home
Message-ID: <ebqfjq$ujd$1@sea.gmane.org>
References: <ebpket$7dt$1@sea.gmane.org> <20060814175130.GB16821@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 20:33:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GChF9-0001Rp-Vg
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 20:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWHNScn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 14:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWHNScn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 14:32:43 -0400
Received: from main.gmane.org ([80.91.229.2]:60056 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752048AbWHNScl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 14:32:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GChEn-0001Mo-Ff
	for git@vger.kernel.org; Mon, 14 Aug 2006 20:32:34 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 20:32:33 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 20:32:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25373>

Michael S. Tsirkin wrote:

>>> Well, what I was *trying* to do is simply add a more descriptive name
>>> for the linus master branch to my existing tree.
>>>
>>> So it seemed like an obvious idea to add
>>> 
>>> Pull: master:origin
>>> Pull: master:linus_master
>> 
>> Couldn't you do this via symlinks or symrefs? 
>> 
>> BTW. Do we support symrefs other than HEAD, and does reflog works with
>> symref heads, and symlinked heads?
> 
> How?

Have only "Pull: master:linus_master" as the pull line, and make origin
symlink (ln -s $GIT_DIR/refs/heads/linus_master $GIT_DIR/refs/heads/origin)
or symref (echo "ref: refs/heads/linus_master" > $GIT_DIR/refs/heads/origin)
or vice versa.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
