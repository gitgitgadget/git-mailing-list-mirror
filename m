From: Michel Jouvin <jouvin@lal.in2p3.fr>
Subject: git-svn doesn't fetch an empty directory with svn:externals
Date: Wed, 13 Jan 2010 11:49:38 +0000 (UTC)
Message-ID: <loom.20100113T124446-187@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 12:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV1jo-0002BA-HF
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 12:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab0AMLuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 06:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834Ab0AMLuG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 06:50:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:46595 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab0AMLuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 06:50:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NV1jd-00026m-PM
	for git@vger.kernel.org; Wed, 13 Jan 2010 12:50:01 +0100
Received: from APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr ([82.124.7.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 12:50:01 +0100
Received: from jouvin by APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 12:50:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.124.7.64 (Opera/9.80 (Windows NT 6.0; U; fr) Presto/2.2.15 Version/10.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136810>

Hi,

I'm running in a problem when trying to fetch a SVN repository branch that 
contains an empty directory with a SVN property svn:externals attached. This 
directory is missing in the Git repository/checkout. I was unable to find an 
option to have it added. I'd like to get it added to readd the externals using 
the trick described in http://kerneltrap.org/mailarchive/git/2007/5/1/245002. 
Without it, I have to recreate it in git, add it to .gitignore... which is 
painful.

BTW, I didn't find any documentation on empty dirs handling by git-svn. They 
seems to be often removed which is not always desirable. Are they options 
related to this?

Cheers,

Michel
