From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-commit could allow grouping of short options
Date: Mon, 05 Feb 2007 10:18:59 +0100
Organization: At home
Message-ID: <eq6snc$80m$1@sea.gmane.org>
References: <20070203224151.19678.qmail@41f6d84bf5aaea.315fe32.mid.smarden.org> <20070204010559.GA3421@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 10:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDzyx-0003bR-Oq
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 10:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbXBEJRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 04:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbXBEJRs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 04:17:48 -0500
Received: from main.gmane.org ([80.91.229.2]:46917 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbXBEJRs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 04:17:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDzyn-0004AC-HS
	for git@vger.kernel.org; Mon, 05 Feb 2007 10:17:42 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 10:17:41 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 10:17:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38735>

[Cc: git@vger.kernel.org]

Eric Wong wrote:
> Gerrit Pape <pape@smarden.org> wrote:

>> Hi, please see http://bugs.debian.org/407241:
>> 
>>> git-commit could allow grouping of short options, rather than failing:
>>> 
>>> $ git commit -avs
>>> Usage: /usr/bin/git-commit [-a] [-s] [-v] [--no-verify] ...
>> 
>> I personally would like this too, not only for git-commit.
> 
> I had some patches to implement this a while ago ('gitopt') but I never
> got around to cleaning them up and fixing some bugs.  Hopefully I'll
> have time in the next weeks.

It would be nice to also have long, descriptiove option for each short,
single character option of each git command, for example --patch as longopt
alternative to git-diff-tree -p option, etc.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
