From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: change filename/directory name of snapshots
Date: Fri, 08 Jun 2007 13:46:00 +0200
Organization: At home
Message-ID: <f4bf7g$kpe$1@sea.gmane.org>
References: <20070607092708.GA25097@moooo.ath.cx> <7v4pliltuv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwcq1-0005Fn-GW
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968293AbXFHLlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968385AbXFHLlD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:41:03 -0400
Received: from main.gmane.org ([80.91.229.2]:41900 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968272AbXFHLlB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:41:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hwcpl-0004Hf-TO
	for git@vger.kernel.org; Fri, 08 Jun 2007 13:40:49 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 13:40:49 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 13:40:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49470>

Junio C Hamano wrote:

> Matthias Lederhofer <matled@gmx.net> writes:
> 
>> /.git or .git is removed from the project name and the
>> basename of the remaining path is used as the beginning of
>> the filename and as the directory in the archive.
>>
>> The regexp will actually not strip off /.git or .git if there
>> wouldn't be anything left after removing it.
>>
>> Currently the full project name is used as directory in the
>> archive and the basename is used as filename.  For example a
>> repository named foo/bar/.git will have a archive named
>> .git-<version>.* and extract to foo/bar/.git.  With this patch
>> the file is named bar-<version>.* and extracts to bar.
> 
> Makes sense to me for "foo/bar/.git", but I am not sure if we
> would want to do this to "foo/bar.git".  Opinions?

I'd like to have snapshot called bar-<sha1>.tar.gz in first case,
and bar.git-<sha1>.tar.gz (without stripping .git) in the second,
but I wouldn't protest too much about having bar-<sha1>.tar.gz
also in second case.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
