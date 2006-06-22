From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add title attribute with full first line of tag comment if it is needed
Date: Thu, 22 Jun 2006 08:54:32 +0200
Organization: At home
Message-ID: <e7deqs$vso$1@sea.gmane.org>
References: <11509297422173-git-send-email-jnareb@gmail.com> <7vu06exfym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 08:54:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJ5E-0003P2-HG
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 08:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbWFVGya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 02:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWFVGy3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 02:54:29 -0400
Received: from main.gmane.org ([80.91.229.2]:28343 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750973AbWFVGy3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 02:54:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtJ57-0003Oh-Pb
	for git@vger.kernel.org; Thu, 22 Jun 2006 08:54:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 08:54:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 08:54:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22300>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> For commits in oneline view (summary, shortlog, history) commit title
>> (first line of commit message) is link to commit itself. If commit title
>> (commit description) is shortened in output, hyperlink has title attribute
>> with full title.
> 
> There are pure fixes and this "-title" enhancement intermixed.
> Can we have fixes-only first?

O.K. done.

> And as you say, git_summary and git_tags do look similar.  Maybe
> we would want to refactor them first to clean things up before
> piling up more features?
 
O.K. will do.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
