From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 02:33:04 +0200
Organization: At home
Message-ID: <f06d4m$3rs$1@sea.gmane.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com> <200704181426.29969.andyparkins@gmail.com> <462650A7.5030404@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 02:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeKXB-00078H-Az
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 02:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993043AbXDSA34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 20:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993056AbXDSA34
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 20:29:56 -0400
Received: from main.gmane.org ([80.91.229.2]:33851 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993043AbXDSA3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 20:29:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HeKWm-0005sG-OK
	for git@vger.kernel.org; Thu, 19 Apr 2007 02:29:36 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 02:29:36 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 02:29:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44972>

Steven Grimm wrote:

> Andy Parkins wrote:
>> svn update = git pull
>>   
> 
> That's not quite equivalent, and it's one of the biggest annoyances svn 
> users seem to have when starting up with git in my observation (having 
> gone through it myself and watched a few other people at my company do 
> so.) svn update will merge upstream changes into your locally edited but 
> not yet committed files. git pull will just complain if you have 
> uncommitted local edits to files that changed upstream.

In my opinion the update-then-commit workflow CVS and SVN forces on users
is one of the more annoying features, forcing the user to resolve conflicts
if he/she wants to be up-to-date.

The update-then-commit assumes that you merge on update local modifications
with current server version, assuming that ancestor is current local
committed version. This makes off-line committing impossible, and makes
rare updates (server version advanced by more than one commit) unnecessary
hard.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
