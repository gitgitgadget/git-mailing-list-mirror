From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb / cg-export
Date: Wed, 16 Aug 2006 11:54:18 +0200
Organization: At home
Message-ID: <ebupuk$dgl$1@sea.gmane.org>
References: <44E263DD.6030305@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 16 11:54:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDI5s-0006XT-QW
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 11:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHPJxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 05:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWHPJxo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 05:53:44 -0400
Received: from main.gmane.org ([80.91.229.2]:46556 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751082AbWHPJxn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 05:53:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDI5i-0006US-QJ
	for git@vger.kernel.org; Wed, 16 Aug 2006 11:53:38 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 11:53:38 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 11:53:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25510>

Toby White wrote:

> I was wondering if a feature like the following would be of
> use to anyone except me: I'd like to be able to download
> the full source of a given tree from gitweb.
[...]
So you want to have snapshot of a tree. Why not snapshot of a commit, 
or of a tag?

> I've quickly hacked gitweb to do this for me - patch below.
> 
> It adds an extra link to the 'commit' page. Next to the link
> that would lead you to 'tree', there is 'tar.gz' which simply
> returns the tar.gz of the same tree.
> 
> The patch is against the version of gitweb currently in
> Debian, which is, erm, '264-1', apparently, because that's
> what I had to hand.

It is really better to hack git with git. And you can use current gitweb
with old git (well, not always, as current gitweb requires --full-history
option to git-rev-list to be available).
 
> Anyway. I'm no git expert so perhaps this is a really bad
> idea, but I find it useful.

It is usefull idea, as it was implemented independently by Sven Verdoolaege
in http://marc.theaimsgroup.com/?l=git&m=111909432415478&w=2 directly in
gitweb, and by Sham Chukoury in gitweb-xmms2 using snapshot.cgi in Python
in "Snapshot links support" commit
http://git.xmms.se/?p=gitweb-xmms2.git;a=commit;h=3d0284bb784041907de33df5cff8449f8aeb072e
and "Add xmms2 project's snapshot.cgi" commit
http://git.xmms.se/?p=gitweb-xmms2.git;a=commit;h=3d0284bb784041907de33df5cff8449f8aeb072e

I have planned to add snapshot support, see "[RFC] gitweb wishlist and TODO
list" thread in mailing list archives, check
   http://git.or.cz/gitwiki/GitCommunity
for list, but I was planning to do some refactoring, including 
<td class="link"> links refactoring (that is where snapshot links would be
added).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
