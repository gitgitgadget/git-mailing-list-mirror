From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 0/4] gitweb: ViewVC-like "tree_blame" view
Date: Thu, 31 Aug 2006 03:05:43 +0200
Organization: At home
Message-ID: <ed5cke$n4m$1@sea.gmane.org>
References: <200608310043.12606.jnareb@gmail.com> <7vfyfdg4fw.fsf@assigned-by-dhcp.cox.net> <ed59rk$hk0$1@sea.gmane.org> <200608310247.05385.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 03:05:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIb0D-0004L3-05
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 03:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWHaBFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 21:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHaBFn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 21:05:43 -0400
Received: from main.gmane.org ([80.91.229.2]:19120 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932279AbWHaBFm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Aug 2006 21:05:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIazu-0004Hq-Kb
	for git@vger.kernel.org; Thu, 31 Aug 2006 03:05:34 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 03:05:34 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 03:05:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26242>

Josef Weidendorfer wrote:

> On Thursday 31 August 2006 02:18, Jakub Narebski wrote:
>> Ooops, I forgot to explain this. Strike-through, which actually should be
>> using different color like red for example means that the file has
>> 1-commit long history, i.e. it just appeared in given commit.
> 
> Seems useful. Perhaps better green. And red for...
> (As you talk about "just appeared") What's about deleted files, similar
> to attic in CVS? It could be quite useful to provide an alternate
> tree-blame mode including deleted files; where the given commit
> would specify the deletion.

Deletion, or renaming.

Actually the currently used implementation (2-items max length history for
each file) doesn't allow for that. The other two implementations (you can
choose other 2 implementations by changing 'rev-list' in "my $version =
shift || 'rev-list'" to 'diff-tree' or 'ls-tree') can do this. I think it
would be perhaps easiest with git-ls-tree, if git-ls-tree would acquire
--stdin option, similar to git-diff-tree...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
