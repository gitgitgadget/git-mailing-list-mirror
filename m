From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 02:46:18 +0200
Organization: At home
Message-ID: <eco5kh$pl3$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252135.27894.jnareb@gmail.com> <200608260226.25966.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 26 02:47:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGmKB-0002Ip-CG
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 02:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422950AbWHZAqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 20:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422954AbWHZAqy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 20:46:54 -0400
Received: from main.gmane.org ([80.91.229.2]:46274 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422950AbWHZAqx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 20:46:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGmJj-0002CC-55
	for git@vger.kernel.org; Sat, 26 Aug 2006 02:46:31 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 02:46:31 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 02:46:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26023>

Josef Weidendorfer wrote:

> On Friday 25 August 2006 21:35, you wrote:
>> You can view new gitweb in work at
>>   http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
> 
> Hmm... history pages seem not to work.
> Otherwise, looks fine.

Probably git core on this machine (version 1.3.0) is too old and doesn't
support --full-history option to git-rev-list, needed by git_history.

Relevant changes were made to commitdiff, comitdiff_plain, blobdiff and
blobdiff_plain views.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
