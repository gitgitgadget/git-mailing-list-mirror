From: Johan Herland <johan@herland.net>
Subject: Re: git pull/merge master on other branch
Date: Fri, 09 May 2008 08:24:12 +0200
Message-ID: <200805090824.12772.johan@herland.net>
References: <g00nb3$dlm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 08:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuM2k-0004x1-Uq
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 08:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbYEIGYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 02:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbYEIGYb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 02:24:31 -0400
Received: from smtp.getmail.no ([84.208.20.33]:32827 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404AbYEIGY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 02:24:28 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K0L00C0J8GOSO00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 09 May 2008 08:24:24 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K0L008R18GD8K80@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 09 May 2008 08:24:13 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K0L00I9B8GD0OF0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 09 May 2008 08:24:13 +0200 (CEST)
In-reply-to: <g00nb3$dlm$1@ger.gmane.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81602>

On Friday 09 May 2008, SungHyun Nam wrote:
> Hello,
> 
> If I am on a branch (reguarly rebased), I don't want to switch to
> master branch, but merge origin into master.
> If I switch to master and pull and switch to branch, I have to
> rebuild almost of sources.
> 
> How I can pull origin into master without switching to master
> branch?

You can't; merging requires use of the working tree (to resolve conflicts).

However, what you can do is make a local clone of your project (cheap,
because it just hardlinks files from the original repo), and checkout the
master branch in the clone, perform the merge (after having set up the same
origin and retrieved its contents), and then fetch (or push) the result back
into the original repo (remember: "fetch" instead of "pull", since the
latter will initiate a merge with your current branch).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
