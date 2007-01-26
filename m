From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Per-file force update
Date: Fri, 26 Jan 2007 14:02:13 +0100
Organization: At home
Message-ID: <epcu2g$vrv$2@sea.gmane.org>
References: <op.tmpzmzvtzidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 14:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAQiK-0002MN-2B
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 14:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXAZNB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 08:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXAZNB0
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 08:01:26 -0500
Received: from main.gmane.org ([80.91.229.2]:32944 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbXAZNBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 08:01:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HAQhg-0007h4-3l
	for git@vger.kernel.org; Fri, 26 Jan 2007 14:01:16 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:01:16 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 14:01:16 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37851>

Troy Telford wrote:

> I've got a file that (due to some inner workings) changes whenever it's  
> built.
> 
> This causes a problem with git, causing merge conflicts.
> 
> Is there a way I can configure git to /always/ do the equivalent of 'git  
> pull -f', but only for that one file?

Ignore this file, using either .gitignore or .git/into/excludes.
You should not track output files in git (well, in principle).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
