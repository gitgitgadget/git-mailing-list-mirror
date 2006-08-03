From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 03 Aug 2006 17:48:11 +0200
Organization: At home
Message-ID: <eat5qp$3sr$1@sea.gmane.org>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org> <20060803153403.GA30729@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 03 17:49:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fRP-0001U8-UA
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWHCPss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWHCPss
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:48:48 -0400
Received: from main.gmane.org ([80.91.229.2]:26313 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964802AbWHCPsq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:48:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8fQu-0001L6-C9
	for git@vger.kernel.org; Thu, 03 Aug 2006 17:48:24 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 17:48:24 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 17:48:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24735>

Marc Singer wrote:

> That isn't enough.  I did something like that when I was exploring the
> script.  While the change *does* eliminate the 403 error, it doesn't
> make the rest of the script work properly.  All of the links return to
> the same page that lists the projects.

Strange... PATH_INFO is used _only_ if 'p' parameter is not set. And all
links use 'p=$project', not PATH_INFO...

Are you sure you did changes mentioned in earlier post?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
