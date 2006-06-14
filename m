From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: oprofile on svn import
Date: Wed, 14 Jun 2006 21:38:09 +0200
Organization: At home
Message-ID: <e6poil$e8l$1@sea.gmane.org>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com> <9e4733910606131932w362c6ddcx5bf36ea5591feba1@mail.gmail.com> <9e4733910606141225n11b406fte6229ea9993825dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 14 21:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqbBz-0001M2-9q
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 21:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWFNTiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWFNTiO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 15:38:14 -0400
Received: from main.gmane.org ([80.91.229.2]:4491 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751063AbWFNTiN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 15:38:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqbBl-0001JJ-5F
	for git@vger.kernel.org; Wed, 14 Jun 2006 21:38:05 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 21:38:05 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 21:38:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21857>

Jon Smirl wrote:

> Stats after 18 hours into git-svnimport. Process is now stuck in the
> kernel 64% of the time. All of the kernel time is in page management.
> Perl svnimport process is 290MB now.
> 
> My top candidates for causing the problem are the fork in the perl
> code or the execing of a million tiny git processes.
> 
> The key low level git functions could be made into a library to avoid
> the need to exec them continuously. The svn functions are libraries
> and they hardly show up.

There is ongoing effort to translate git functions into builtins.
Still you would need to translate git-svnimport Perl code into C,
or somehow access git library from Perl.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
