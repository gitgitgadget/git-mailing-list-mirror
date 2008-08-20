From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: The state and future of the git/mingw** reposiories?
Date: Wed, 20 Aug 2008 22:18:35 +0200
Message-ID: <200808202218.35626.johannes.sixt@telecom.at>
References: <20080820112309.GH10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	prohaska@zib.de, johannes.schindelin@gmx.de
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:19:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVu9h-0002Od-KG
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbYHTUSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbYHTUSl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:18:41 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:36724 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbYHTUSl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:18:41 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id C4DD810A710;
	Wed, 20 Aug 2008 22:18:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D2DB91D38D;
	Wed, 20 Aug 2008 22:18:36 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080820112309.GH10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93031>

On Mittwoch, 20. August 2008, Petr Baudis wrote:
>   Hi,
>
>   I'm currently doing some MSysGit hacking (mostly git-gui-related) and
> I'm wondering what should I actually base my work on, considering the
> statement of 1.6.0 release notes:
>
> 	Source changes needed for porting to MinGW environment are now
> 	all in the main git.git codebase.

If all you need is a mostly working git, you can build off of git.git 
(assuming you have the build environment that msysgit provides).

> However, git diff junio/master...mingw/master shows quite a few
> differences - is there any plan to merge these?

You see three kinds of differences:

- Changes in the test suite.
- Perl related changes (most notably, git-add--interactive in git.git does not 
work on MinGW without these changes).
- One or two gitk related fixes.

All of them will be sent upstream some day.

If you need one of the areas that these changes touches, then you can work off 
of mingw.git.

> If so, do you plan to 
> maintain the mingw fork indefinitely anyway as a staging area for your
> patches that you plan to push upstream, or is it going to be phased out
> eventually?

I hope I can reset mingw.git to git.git some day. But I plan to keep it as 
staging area for patches.

-- Hannes
