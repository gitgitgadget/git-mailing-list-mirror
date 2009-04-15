From: Eric Raible <raible@gmail.com>
Subject: Re: list of files that have been added/removed
Date: Wed, 15 Apr 2009 21:42:41 +0000 (UTC)
Message-ID: <loom.20090415T214225-489@post.gmane.org>
References: <31043.1239831470@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 23:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuCuC-0001JX-8R
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 23:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbZDOVmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZDOVmy
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 17:42:54 -0400
Received: from main.gmane.org ([80.91.229.2]:56711 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552AbZDOVmy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 17:42:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LuCse-000524-Az
	for git@vger.kernel.org; Wed, 15 Apr 2009 21:42:52 +0000
Received: from adsl-67-121-115-74.dsl.pltn13.pacbell.net ([67.121.115.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 21:42:52 +0000
Received: from raible by adsl-67-121-115-74.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 21:42:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.121.115.74 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.53 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116652>

layer <layer <at> known.net> writes:

> 
>   I see the changes in the index with "git status" as "deleted" or
>   "added".  
> 
> I meant "new file" here.  Of course I can process the output of "git
> status", but I was looking for a cleaner method, if there is one.
> 
> Thanks.
> 
> Kevin
> 

Perhaps:
git diff --name-only
