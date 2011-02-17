From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 07:00:42 +0000 (UTC)
Message-ID: <loom.20110217T074533-358@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 08:01:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpxrR-0001XN-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1BQHA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:00:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:43106 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab1BQHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 02:00:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PpxrB-0001Qq-Jc
	for git@vger.kernel.org; Thu, 17 Feb 2011 08:00:53 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 08:00:53 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 08:00:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167045>

I am writing a script for git-gui's "Tools" menu to diff a file.
I want to checkout an origin file in a tmp directory and use the diff tool.
Now it is ok to those unstage file,but to those staged file,
I found that I do not know how to checkout the orgin(unstage) version.

In detail,I change current directory to a tmp directory,
and use for example 
'git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout README'
 to checkout origin version.

Does anyone can help with this? 
I look the git help and can not find way till now.

Thanks!
