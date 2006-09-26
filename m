From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 10:54:49 +0200
Organization: At home
Message-ID: <efapsl$e65$1@sea.gmane.org>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 10:55:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS8iq-0005YO-5b
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 10:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWIZIzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 04:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWIZIzV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 04:55:21 -0400
Received: from main.gmane.org ([80.91.229.2]:29165 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750745AbWIZIzT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 04:55:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GS8iS-0005U2-GD
	for git@vger.kernel.org; Tue, 26 Sep 2006 10:55:00 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 10:55:00 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 10:55:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27786>

Luben Tuikov wrote:

> Binary and non-binary blobs:
> 
> The "list" table element of tree view is identical
> to the "blob" link part of the link table element.
> I.e. clicking on "blob" is identical to clicking on
> the entry itself.
> 
> Thus, eliminate "blob" from being shown -- the user
> can get identical result by simply clicking on the
> entry itself.

I'd rather not. The fact that the file name and tree name is link,
and the fact that commit title and tag title is link is a _convenience_.
Not always it is visible (without mouseover) that it is link.
And it is _not_ visible in the case of files!

And for example for commits and heads there are two possible
views, commit and commitdiff for commit, shortlog and log for head,
of which we arbitrary chose one for the subject link. So in that
case the additional self link is needed. I'd rather have both.
And for consistency I'd rather always have visible form default
self link/

I'd rather have additional link, than cause confusion to the users.
Perhaps we could separate the self link ("blob" for files, "tree"
for directories) into separate column?

Besides, you have to mouse over the name of file, or name of
directory to see to what view it would lead on.

Nak.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
