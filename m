From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 11:52:12 +0100
Organization: At home
Message-ID: <emdorr$kt$1@sea.gmane.org>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Dec 21 11:49:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxLUs-0001kH-9Z
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWLUKtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWLUKtz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:49:55 -0500
Received: from main.gmane.org ([80.91.229.2]:50877 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964776AbWLUKty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:49:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GxLUg-0004Ed-6m
	for git@vger.kernel.org; Thu, 21 Dec 2006 11:49:46 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 11:49:46 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 11:49:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35050>

Alexander Litvinov wrote:

>>> What do you think about a patch that makes git-commit-tree call iconv on
>>> its input to get it to UTF-8 (or any other charset).
>>
>> We had this discussion over and over again. Last time (I think) was here:
>> http://article.gmane.org/gmane.comp.version-control.git/11710
>> Summary: we do not want to force the use of utf8.
> 
> May we can add new header into commit with commit text encoding ?

I think it should be repository-wide decision. And we have
i18n.commitEncoding configuration variable (perhaps it should be propagated
on clone?).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
