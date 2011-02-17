From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 10:17:45 +0000 (UTC)
Message-ID: <loom.20110217T110820-459@post.gmane.org>
References: <loom.20110217T074533-358@post.gmane.org> <4D5CDBAD.4050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 11:18:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq0w4-00081O-Al
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 11:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1BQKSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 05:18:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:34290 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041Ab1BQKSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 05:18:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pq0vt-0007vO-GB
	for git@vger.kernel.org; Thu, 17 Feb 2011 11:17:57 +0100
Received: from 218.107.217.218 ([218.107.217.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:17:57 +0100
Received: from zhangchunlin by 218.107.217.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:17:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 218.107.217.218 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167062>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:

> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
But after I test,I found that after run this command,the file I do 
checkout action become unstaged.
It is weard,because I have set the "--work-tree" to another directory.
my command line for example:
git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout 
HEAD -- Android.mk

You can test with a git repository.I have no idea how to work around now.
