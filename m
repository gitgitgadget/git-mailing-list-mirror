From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/19] gitweb: Remove dependency on external diff and need for temporary files
Date: Sun, 27 Aug 2006 17:37:29 +0200
Organization: At home
Message-ID: <ecse7k$2q3$2@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252315.57181.jnareb@gmail.com> <Pine.LNX.4.64.0608262026230.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 27 17:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHMkD-00048u-Vq
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 17:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWH0PkN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWH0PkN
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 11:40:13 -0400
Received: from main.gmane.org ([80.91.229.2]:15286 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932145AbWH0PkL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 11:40:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GHMjy-00045t-Ka
	for git@vger.kernel.org; Sun, 27 Aug 2006 17:40:02 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:40:02 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26102>

Linus Torvalds wrote:

> On Fri, 25 Aug 2006, Jakub Narebski wrote:
>>
>> This series of patches (now finished) removes dependency on
>> external diff (/usr/bin/diff) to produce commitdiff and blobdiff
>> views, and the need for temporary files.
> 
> Ok, can we now please fix my final annoyance, which is that gitweb from 
> the very beginning has apparently believed that the "Signed-off-by:" etc 
> lines are not important, and they get stripped away when looking at the 
> "commit-diff".

This can be easily fixed.

> Also, "commit-diff" really should have some minimal authorship 
> information. It's silly to have to go to "commit" and then separately ask 
> for "diff" to see all these very basic things.

And this need some layout redesign for commitdiff and log views.
Currently it is specially formatted subject/first line, simplified
message (with empty lines collapsed), and without signoff.

Perhaps something similar to what "log" view uses?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
