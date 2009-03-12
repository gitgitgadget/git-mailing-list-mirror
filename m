From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT RFC PATCH(was Re: egit problem with sym linked eclipse project dirs)] Add some support for symlinked projects.
Date: Thu, 12 Mar 2009 07:56:07 +0100
Message-ID: <200903120756.07853.robin.rosenberg.lists@dewire.com>
References: <p0624081cc5928e2885fd@[192.168.1.114]> <200903112317.41380.robin.rosenberg.lists@dewire.com> <p06240814c5de27cbf520@[63.138.152.192]>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 07:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LherY-0002HR-Jr
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 07:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbZCLG4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbZCLG4O
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 02:56:14 -0400
Received: from mail.dewire.com ([83.140.172.130]:24342 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496AbZCLG4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 02:56:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E8BBC8027E7;
	Thu, 12 Mar 2009 07:56:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUBPbYbwoSCZ; Thu, 12 Mar 2009 07:56:08 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id CACF68006B8;
	Thu, 12 Mar 2009 07:56:08 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <p06240814c5de27cbf520@[63.138.152.192]>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113007>

torsdag 12 mars 2009 03:57:09 skrev Stephen Bannasch <stephen.bannasch@deanbrook.org>:
> OK ... I'm a bit confused now because I no longer have Git listed as 
> a repository type for Team Sharing.
> 
> I deleted the existing org.spearce.* eclipse plugins
> 
>    [eclipse]$ rm -f plugins/org.spearce.*
> 
> pulled from git://repo.or.cz/egit.git
> 
> created a new branch for this test and applied your patch
> 
>    [egit.git (linksbranch)]$ git log
>    commit 2b86cd4e27a9d9158092305271d6fb25ab27846e
>    Author: Stephen Bannasch <stephen.bannasch@gmail.com>
>    Date:   Wed Mar 11 22:29:26 2009 -0400
> 
>        check through links for repositories
>        Robin Rosenberg's patch
>        see: http://marc.info/?l=git&m=123681033214178&w=2
>        and: http://code.google.com/p/egit/issues/detail?id=52
> 
>    commit 341b9c1abadd2ac0ec9ecc7c597990070612e058
>    Author: Ruth Alkema <ruth@diasoft.nl>
>    Date:   Wed Mar 11 16:42:45 2009 +0100
> 
>        Better fix for 'negative position' error on large pack files
> 
>        If position is really big and the window size is fairly small, id can
>        be negative.  Instead of producing a negative position by extending
>        id to a long, mask out the low bits from the original position value
>        to compute the window start.
> 
>        [sp: message by me, as I had already applied v1 of the patch
>             and pushed it (see immediate parent)]
> 
>        Signed-off-by: Ruth Alkema <ruth@diasoft.nl>
>        Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> 
>    ...
> 
> Opened Eclipse and switched to the egit workspace. Refreshed the egit 
> projects and exported the org.spearce.* packages as deployable 
> plugins and fragments to the Eclipse dir.
> 
> The new plugins are there:
> 
>    [eclipse]$ ls plugins/org.spearce.*
>    plugins/org.spearce.egit.core.test_0.4.0.200903112237.jar
>    plugins/org.spearce.egit_0.4.0.200903112237.jar
>    plugins/org.spearce.egit.core_0.4.0.200903112237.jar
>    plugins/org.spearce.jgit_0.4.0.200903112237.jar
>    plugins/org.spearce.egit.ui_0.4.0.200903112237.jar
> 
> Quit and restarted Eclipse.
> 
> When I select a project with an existing git repository and try to 
> enable team/sharing only CVS and SVN are listed.

You don't have the a matching feature. That could be it, but I'm not sure. 
You can also try starting eclipse witth the -clean switch. Looking at the
<workspace>/.metadata/.log could also give you some hints.

For debugging/testing in general it is often easier to launch Eclipse from
eclipse (Run As) without reinstalling. 

-- robin
