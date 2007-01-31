From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: When to repack?
Date: Wed, 31 Jan 2007 13:58:37 +0100
Organization: At home
Message-ID: <epq3nd$pv5$1@sea.gmane.org>
References: <17856.37016.341839.397309@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 13:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCF1t-00066J-TA
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 13:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219AbXAaM5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 07:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933218AbXAaM5e
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 07:57:34 -0500
Received: from main.gmane.org ([80.91.229.2]:52807 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933219AbXAaM5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 07:57:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCF1m-0004be-EX
	for git@vger.kernel.org; Wed, 31 Jan 2007 13:57:30 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 13:57:30 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 13:57:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38244>

[Cc: git@vger.kernel.org]

Bill Lear wrote:

> We have a company repo used by many people throughout the day.  When/how
> can I repack this?  I have come to adopt this approach:
> 
> % mv project project.pack
> % cd project.pack
> % GIT_DIR=. git repack -a -d
> % cd ..
> % mv project.pack project

Repack is safe. You can do it on live repository. It does the save under
temporary name and move to proper place on it's own.

By the way you can use "git --bare repack -a -d" instead of 
"GIT_DIR=. git repack -a -d"
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
