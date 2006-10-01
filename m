From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove excessively redundant entries from git_difftree_body
Date: Sun, 01 Oct 2006 21:20:26 +0200
Organization: At home
Message-ID: <efp4d6$a7b$1@sea.gmane.org>
References: <20060928002325.70519.qmail@web31815.mail.mud.yahoo.com> <7vmz8k7nhc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Oct 01 21:20:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6rW-0007kF-1H
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 21:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWJATU0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 15:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJATU0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 15:20:26 -0400
Received: from main.gmane.org ([80.91.229.2]:59580 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932225AbWJATUY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 15:20:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GU6rF-0007gC-4F
	for git@vger.kernel.org; Sun, 01 Oct 2006 21:20:13 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 21:20:13 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 21:20:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28194>

Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
>> 1) All entries on the left are blobs and clicking on them
>> leads to blobs.  No more diff or blob depending on what
>> happened (modified or mode changed) to the file -- this goes
>> to the right, in the "link" column.
>>
>> 2) Remove redundant "blob" from the link column on the right.
>> This can now be had by clicking on the entry itself.
>>
>> This reduces and simplifies the code.
>>
>> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> 
> We lost blobdiff from commitdiff page with this patch, which I
> think it probably is a good change.  We can say "when we display
> a pathname you can click it to get the blob or tree".

In my opinion it is a bad change. We now have "patch" inner-link
to anchor in commitdiff view, but it's equivalent in commit view
i.e. diff aka blobdiff vanished.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
