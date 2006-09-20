From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 01:38:49 +0200
Organization: At home
Message-ID: <eesje4$qku$2@sea.gmane.org>
References: <20060920231224.GN13132@pasky.or.cz> <eesj84$qku$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 21 01:40:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBfw-0007BS-Rm
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWITXkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWITXkP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:40:15 -0400
Received: from main.gmane.org ([80.91.229.2]:52360 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750738AbWITXkN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:40:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GQBfe-00077q-GA
	for git@vger.kernel.org; Thu, 21 Sep 2006 01:40:02 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 01:40:02 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 01:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27433>

Jakub Narebski wrote:

> Petr Baudis wrote:
> 
>> This patch fixes two things - links to all path elements except the last
>> one were broken since gitweb does not like the trailing slash in them, and
>> the root tree was not reachable from the subdirectory view.
>> 
>> To compensate for the one more slash in the front, the trailing slash is
>> not there anymore. ;-) I don't care if it stays there though.
> 
> Originally '/' was used as separator between directories making the path.
> I'd rather use ' / ' to separate parts of pathname more, and not incorporate
> it in the link.
> 
> Trailing (final) slash is present (and I think should be present) only
> for path in "tree" view. From the path alone you can see if it is "tree"
> or "blob" view.

About link to root tree: we could change the commit title to link to root
tree instead of linking to commit view.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
