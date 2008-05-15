From: Tommy Thorn <tommy-git@thorn.ws>
Subject: git bug: rebase fatal failure
Date: Thu, 15 May 2008 00:27:51 -0700
Message-ID: <482BE5F7.2050108@thorn.ws>
Reply-To: tommy-git@thorn.ws
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 09:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwuaM-0005Zo-7d
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 09:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYEPHlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 03:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYEPHlr
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 03:41:47 -0400
Received: from server204.webhostingpad.com ([69.65.0.218]:59652 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936AbYEPHlq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 03:41:46 -0400
X-Greylist: delayed 87232 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 May 2008 03:41:46 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=TGb2Ajjavo6szN9zS78FlQFiWeqCdSg11IGsdMNZYT8r+Z01RuzyJ4+gXii7oAR9cq+ycV6T+/rO6xBu/wmIZP7X+5eTCac46sUMvdoCy1XHbAyv834vW/F3MKXv5Y+H;
Received: from [68.183.202.16] (helo=silver.tommythorn.kicks-ass.org)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JwXsX-0003BP-HE
	for git@vger.kernel.org; Thu, 15 May 2008 02:27:53 -0500
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82261>

Hi,

I have large-ish repository (143 MB) where git rebase failed 
unexpectedly (see below). If anyone is interested in looking at this, I 
have left a copy of the repository at 
http://thorn.ws/git-fatal-rebase-error.tar.gz

Tommy
PS: Please add me in CC as I'm no longer on this list.


$ git --version
git version 1.5.5.1.93.ge3f3e

$ git rebase cacao my-cacao-build
First, rewinding head to replay your work on top of it...
Applying Import binutils-2.18
.dotest/patch:16878: trailing whitespace.
 
.dotest/patch:17923: trailing whitespace.
  0. Additional Definitions.
.dotest/patch:18024: trailing whitespace.
       Version.
.dotest/patch:18094: trailing whitespace.
//
.dotest/patch:18099: trailing whitespace.
//
fatal: corrupt patch at line 260912
Patch failed at 0001.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
