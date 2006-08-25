From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Fri, 25 Aug 2006 20:18:19 +0200
Organization: At home
Message-ID: <ecnet5$q78$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net> <eck1em$p8b$1@sea.gmane.org> <e5bfff550608251032p53ba203fl27af782c765f929f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 25 20:18:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGgGA-00058c-SC
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 20:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWHYSSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWHYSSW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 14:18:22 -0400
Received: from main.gmane.org ([80.91.229.2]:20381 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964821AbWHYSSV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 14:18:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGgG3-00057x-2c
	for git@vger.kernel.org; Fri, 25 Aug 2006 20:18:19 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 20:18:19 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 20:18:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26002>

Marco Costalba wrote:

>> >>    Empty patches (mode changes and pure renames and copying)
>> >>    are not written currently.
>> >
>> > That's quite bad.
>>
>> This can be easily changed. Question: what format? Current "gitweb diff
> 
> I don't know if has always been like this, but I don't see on gitweb
> (http://www.kernel.org/git/?p=qgit/qgit.git;a=shortlog) the diff of
> the patch I've just pushed.
> 
> The patch is "Fix correct permissions on this excutable script",
> currently the HEAD of qgit repo. The content it's only a file mode
> change in helpgen.sh, so it' an 'empty' patch.
> 
> I've done something wrong or it's gitweb that does not show this info?

It is visible in "commit" view, but is not visible in either "commitdiff",
or "blobdiff".

Support for showing this kind of changes is planned... but of course
you would have to wait for kernel.org to update their gitweb.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
