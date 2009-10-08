From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Git archive and trailing "/" in prefix
Date: Thu, 8 Oct 2009 15:35:44 +0000 (UTC)
Message-ID: <loom.20091008T172303-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 17:38:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvv4t-0005a2-7v
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 17:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758581AbZJHPgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758559AbZJHPgr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 11:36:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:34273 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758279AbZJHPgq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 11:36:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mvv2D-00041x-3w
	for git@vger.kernel.org; Thu, 08 Oct 2009 17:36:05 +0200
Received: from host120-48-dynamic.23-79-r.retail.telecomitalia.it ([79.23.48.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 17:36:05 +0200
Received: from sergio.callegari by host120-48-dynamic.23-79-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 17:36:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 79.23.48.120 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090910 Ubuntu/9.04 (jaunty) Shiretoko/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129696>

Hi!

The git-archive man page indicates that if the --prefix option is passed to
git-archive, it is compulsory to end the prefix with a "/"

 git archive [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>] ...

As a matter of fact, the archiver behaves quite strangely if that slash is
missing. Files in the root of the working dir are added to the archive with
their own name modified by the prefix and the same happens for working dir
sub-directories. However, no file present in the sub-directories, nor
sub-sub-directories are added.

I would like to know if there some reason why a trailing "/" is not added
automatically to the prefix when it is missing and the prefix is not empty.
Would that break anything?

Thanks!

Sergio
