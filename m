From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: qgit idea: marking refs (heads and tags)
Date: Tue, 04 Jul 2006 14:45:17 +0200
Organization: At home
Message-ID: <e8dnst$pvh$1@sea.gmane.org>
References: <e8d3i6$ne9$1@sea.gmane.org> <e5bfff550607040503x75b1abdavbbeb80b41a454e7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 14:46:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxkHs-0000Mf-Ii
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 14:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWGDMpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 08:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGDMpx
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 08:45:53 -0400
Received: from main.gmane.org ([80.91.229.2]:40383 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750727AbWGDMpx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 08:45:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxkHj-0000Ke-J2
	for git@vger.kernel.org; Tue, 04 Jul 2006 14:45:47 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 14:45:47 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 14:45:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23295>

Marco Costalba wrote:

> On 7/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> One thing I sorely lack in qgit as compared to gitk (and even gitweb[*1*])
>> is marking commits with refs (heads and tags, marked with different colors
>> or different shape marker). gitk currently uses markers in short log line
>> before text of commit summary, gitweb uses markers after (at the end) of
>> commit log summary. In qgit head commits are marked as such, but not to
>> which branche they belong[*2*].
> 
> Currently you have to select the head and the status bar will show
> related information: branch, tag message, etc.

That is step in right direction, but still when viewing history as a whole
I'd like to know which branch is which. Head refs are marked, so it shouldn't
be much work (well, perhaps some on the GUI side) to add, as an option,
head name somewhere (before or after, or even somwehere else) along commit
"subject".

>> And also somewhat (but to much lesser extent) showing explicitely sha1-ids
>> for commit, parents, tree, referenced object (in tag), to copy'n'paste to
>> shell.
> 
> Something as a typical browser "copy selected link" context menu entry?

Yes, "copy sha1 of selected link" would be nice.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
