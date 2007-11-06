From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-merge ignore specific files
Date: Tue, 06 Nov 2007 14:03:45 +0100
Organization: At home
Message-ID: <fgpong$fmn$1@ger.gmane.org>
References: <174134.11501.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 14:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpO6O-0008Tu-Fd
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXKFNEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbXKFNEE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:04:04 -0500
Received: from main.gmane.org ([80.91.229.2]:44592 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbXKFNED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:04:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IpO5x-0001OL-PA
	for git@vger.kernel.org; Tue, 06 Nov 2007 13:03:53 +0000
Received: from abva250.neoplus.adsl.tpnet.pl ([83.8.198.250])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 13:03:53 +0000
Received: from jnareb by abva250.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 13:03:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abva250.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63673>

Bill Priest wrote:

> All,
>   I have two branches that are slightly different and
> most changes "belong" in both.  There are a handful of
> files/directories that are disparate.  Is there any
> way in git to tell it not to merge these files?  Kind
> of like .gitignore but for merges.

Most probably you can use gitattributes for that.
Or you can use 'our' merge strategy.

>   In addition I'd like a way to specify to git-merge
> to leave all merged files unrecorded in the index. 
> Then as I go through each file making sure that the
> merge "makes sense" (not that git did the right thing;
> but that I want the changes in both branches) that I
> add the change to the index.

You can use gitattributes for that.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
