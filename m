From: =?utf-8?b?QmlzYW5pLA==?= Alok <alok.bisani@credit-suisse.com>
Subject: Re: How to find out which gitignore blocks my git-add
Date: Fri, 6 Feb 2009 22:00:12 +0000 (UTC)
Message-ID: <loom.20090206T215836-960@post.gmane.org>
References: <498C0525.5040100@gonsolo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 23:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVYll-0003FD-2C
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 23:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZBFWA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 17:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbZBFWAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 17:00:25 -0500
Received: from main.gmane.org ([80.91.229.2]:33023 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbZBFWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 17:00:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVYkJ-0001Qs-6f
	for git@vger.kernel.org; Fri, 06 Feb 2009 22:00:23 +0000
Received: from 79-77-150-192.dynamic.dsl.as9105.com ([79.77.150.192])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 22:00:23 +0000
Received: from alok.bisani by 79-77-150-192.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 22:00:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.77.150.192 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.46 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108793>

Gonzo <gonzo <at> gonsolo.de> writes:

> 
> After doing a "git add file" I get the message:
> 
> "The following paths are ignored by one of your .gitignore files:
> ..."
> 
> Is there an easy way to find out which line in which gitignore file 
> blocks this add?
> Would this be a viable addition to "git add -v"?
> 
> g
> 

It would be nice if a -v option also lists which pattern caused
 it to exclude.
