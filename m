From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collection of stgit issues and wishes
Date: Thu, 21 Dec 2006 12:39:45 +0100
Organization: At home
Message-ID: <emdrl2$bkl$1@sea.gmane.org>
References: <20061208221744.GA3288@nan92-1-81-57-214-146.fbx.proxad.net> <200612110002.05847.jnareb@gmail.com> <b0943d9e0612101524w3a2cccecqdd12023233e8ec0c@mail.gmail.com> <200612110037.54309.jnareb@gmail.com> <b0943d9e0612110459y4009ce7fl44ceaa4bad33edf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 21 12:37:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxMEw-00018e-Gr
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 12:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWLULhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 06:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWLULhW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 06:37:22 -0500
Received: from main.gmane.org ([80.91.229.2]:55721 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964819AbWLULhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 06:37:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxMEa-0003BM-ST
	for git@vger.kernel.org; Thu, 21 Dec 2006 12:37:12 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 12:37:12 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 12:37:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35055>

[Cc: git@vger.kernel.org]

Catalin Marinas wrote:

> BTW, if it's not clear for me how to initially structure a patch
> series, I add everything to a patch and create underlying patches
> afterwards and pick hunks from the big one (usually manually, though
> native support in StGIT for this would be good, as someone pointed out
> on this list). If all the hunks in the big patch were added to other
> patches, pushing the big one should result in an empty patch
> automatically (because of the three-way merging) and can be safely
> removed.

Perhaps this calls for "stg duplicate" command, which would result
in duplicating patch (perhaps one would need to provide name for
the first patch, and optionally laso for second patch) in such way
that first copy would be on top of aplied stack, and second copy
(the duplicate, with an old name) would be at the bottom of the deck
of unapplied patches.

This way if you want to for example split patch into two, you would
do

$ stg duplicate new-name
$ edit files
$ stg refresh
$ stg push

And similarly (with more duplicates) if you want to split it more.

What do you think about this?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
